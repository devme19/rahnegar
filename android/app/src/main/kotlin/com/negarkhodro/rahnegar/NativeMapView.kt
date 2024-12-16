package com.negarkhodro.rahnegar

import android.content.Context
import android.graphics.Bitmap

import android.view.View
import com.carto.styles.MarkerStyleBuilder
import io.flutter.plugin.common.BinaryMessenger
import org.neshan.mapsdk.MapView
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.common.MethodChannel
import org.neshan.common.model.LatLng
import org.neshan.mapsdk.internal.utils.BitmapUtils
import org.neshan.mapsdk.model.Marker
import android.graphics.BitmapFactory
import android.graphics.Matrix
import com.carto.graphics.Color
import com.carto.styles.LineStyle
import com.carto.styles.LineStyleBuilder
//import com.google.android.gms.common.api.Response
import org.neshan.mapsdk.model.Polyline
import org.neshan.servicessdk.search.NeshanSearch
import org.neshan.servicessdk.search.model.NeshanSearchResult
import org.neshan.servicessdk.search.model.Item
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import com.google.gson.Gson

class NativeMapView(
    private val context: Context,
    private val messenger: BinaryMessenger,
    viewId: Int
) : PlatformView {
    private lateinit var items: List<Item>
    private var marker: Marker? = null
    private var selectedLocationMarker: Marker? = null
    private var previousLocation: LatLng? = null
    private var isSearching: Boolean = false

    private val methodChannel: MethodChannel = MethodChannel(messenger, "native_map_view_$viewId")
    private val mapView: MapView = MapView(context)


    init {
        // Set up method channel to receive communication from Flutter
        methodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "sendLiveLocation" -> {
                    val latitude = call.argument<Double>("latitude")
                    val longitude = call.argument<Double>("longitude")
                    if (latitude != null && longitude != null) {
                        showCurrentLocation(latitude, longitude)
                        result.success("Location received from flutter")
                    } else {
                        result.error("INVALID_ARGUMENT", "Latitude and Longitude must be provided", null)
                    }
                }

                "search" -> {
                    val term = call.argument<String>("term")
                    if (term != null ) {
                        search(term,result)
//                        result.success("Native Search Term is $term")
                    } else {
                        result.error("INVALID_ARGUMENT", "Latitude and Longitude must be provided", null)
                    }
                }
                "addMarker" -> {
                    val latitude = call.argument<Double>("latitude")
                    val longitude = call.argument<Double>("longitude")
                    if (latitude != null && longitude != null) {
                        addMarker(latitude,longitude)
                        result.success("Native add marker")
                    } else {
                        result.error("INVALID_ARGUMENT", "Latitude and Longitude must be provided", null)
                    }
                }
                "clearSearch" -> {
                    isSearching = false;
                    result.success("Clear search")
                }
                "removeSelectedLocationMarker" -> {
                    if(selectedLocationMarker!=null) {
                        mapView.removeMarker(selectedLocationMarker)
                        result.success("Native remove latest marker")
                    }
                }

                "goToLocation" -> {
                    val latitude = call.argument<Double>("latitude")
                    val longitude = call.argument<Double>("longitude")
                    if (latitude != null && longitude != null) {
                        goToLocation(latitude,longitude)
//                        result.success("Native Search Term is $term")
                    } else {
                        result.error("INVALID_ARGUMENT", "Latitude and Longitude must be provided", null)
                    }
                }
                "changeLocationMarker" -> {
                    val latitude1 = call.argument<Double>("latitude1")
                    val longitude1 = call.argument<Double>("longitude1")
                    val latitude2 = call.argument<Double>("latitude2")
                    val longitude2 = call.argument<Double>("longitude2")

                    if (latitude1 != null && longitude1 != null && latitude2 != null && longitude2 != null) {
                        val previousLocation = LatLng(latitude1,longitude1)
                        val currentLocation = LatLng(latitude2,longitude2)
                        changeLocationMarker(previousLocation,currentLocation)
                        result.success("changeLocationMarker received from native")
                    } else {
                        result.error("INVALID_ARGUMENT", "Latitude and Longitude must be provided", null)
                    }
                }
                "drawPolyLine" -> {
                    val latLngList = call.argument<List<Map<String, Double>>>("latLngList")
                    if (latLngList != null) {
                        drawPolyline(latLngList)
                        result.success("Drawed")
                    } else {
                        result.error("INVALID_ARGUMENT", "LatLng list must be provided", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun addMarker(latitude: Double, longitude: Double) {
        val point = LatLng(latitude, longitude)
        val markerStyle = MarkerStyleBuilder().apply {
            size = 30f
            bitmap = BitmapUtils.createBitmapFromAndroidBitmap(
                BitmapFactory.decodeResource(context.resources, R.drawable.location)
            )
        }.buildStyle()

        val marker = Marker(point, markerStyle)
        mapView.addMarker(marker)
        if(selectedLocationMarker != null){
            mapView.removeMarker(selectedLocationMarker)
        }
        selectedLocationMarker = marker
        mapView.moveCamera(point, 2.1F)
    }
    private fun goToLocation(latitude: Double, longitude: Double) {
        val point = LatLng(latitude, longitude)
        mapView.moveCamera(point, 2.1F)
    }

    private fun showCurrentLocation(latitude: Double,longitude: Double){
        val point = LatLng(latitude, longitude)

        if (marker == null) {
            // If marker is not yet created, create and add it
            val markerStyle = MarkerStyleBuilder().apply {
                size = 10f
                bitmap = BitmapUtils.createBitmapFromAndroidBitmap(
                    BitmapFactory.decodeResource(context.resources, R.drawable.ic_marker)
                )
            }.buildStyle()
            marker = Marker(point, markerStyle)
            mapView.addMarker(marker)
        } else {
            // If marker already exists, just update its position
            marker!!.setLatLng(point)
        }
        // Move the camera to the current location
        if(!isSearching) {
            mapView.moveCamera(point, 2.1F)
        }
    }



    private fun search(term: String, result: MethodChannel.Result) {
        isSearching = true
        val searchPosition: LatLng = mapView.cameraTargetPosition
        try {
            NeshanSearch.Builder("service.c2365f7485b14bd480634f4f8947ed09")
                .setLocation(searchPosition)
                .setTerm(term)
                .build().call(object : Callback<NeshanSearchResult?> {
                    override fun onResponse(
                        call: Call<NeshanSearchResult?>,
                        response: Response<NeshanSearchResult?>
                    ) {
                        if (response.code() == 403) {
                            result.success("Native search response is 403")
                        } else if (response.body() != null) {
                            // Handle response data
                            val items = response.body()?.items

                            if (!items.isNullOrEmpty()) {
                                val gson = Gson()
                                val itemsJson = gson.toJson(items)
                                // Send JSON string to Flutter
                                result.success(itemsJson)
                            } else {
                                result.success("No items found")
                            }
                        } else {
                            result.success("Empty response body")
                        }
                    }

                    override fun onFailure(call: Call<NeshanSearchResult?>, t: Throwable) {
                        result.error("SEARCH_FAILURE", "Native search failure", t.message)
                    }
                })
        } catch (e: Exception) {
            result.error("SEARCH_EXCEPTION", e.message, null)
        }
    }


    private fun changeLocationMarker(previousLocation:LatLng, currentLocation:LatLng){

        val markerStyle = MarkerStyleBuilder().apply {
            size = 30f
            bitmap = BitmapUtils.createBitmapFromAndroidBitmap(
                BitmapFactory.decodeResource(context.resources, R.drawable.ic_marker)
            )
        }.buildStyle()
        mapView.removeMarker(Marker(previousLocation, markerStyle))
        mapView.addMarker(Marker(currentLocation, markerStyle))
        mapView.moveCamera(currentLocation, 2.1F)
    }
    private fun drawRoad(previousLocation:LatLng, currentLocation:LatLng){

        val markerStyle = MarkerStyleBuilder().apply {
            size = 30f
            bitmap = BitmapUtils.createBitmapFromAndroidBitmap(
                BitmapFactory.decodeResource(context.resources, R.drawable.ic_marker)
            )
        }.buildStyle()
        mapView.removeMarker(Marker(previousLocation, markerStyle))
//        Marker(previousLocation, markerStyle).setLatLng()
        mapView.addMarker(Marker(currentLocation, markerStyle))
        mapView.moveCamera(currentLocation, 2.1F)
    }

    override fun getView(): View {
        return mapView // Return the map view for embedding into Flutter
    }

    override fun dispose() {
        TODO("Not yet implemented")

    }

    private fun drawPolyline(latLngList: List<Map<String, Double>>) {

      val latLngs = ArrayList<LatLng>()
        for (latLng in latLngList) {
            val latitude = latLng["latitude"]
            val longitude = latLng["longitude"]
            if (latitude != null && longitude != null) {
                // Process the latitude and longitude
                latLngs.add(LatLng(latitude,longitude)) // Example of adding marker
            }
        }

      val polyline = Polyline(latLngs, getLineStyle())
      mapView.addPolyline(polyline)
      mapView.moveCamera(LatLng(35.769368, 51.327650), .5f)

    }


    private fun getLineStyle(): LineStyle {
        val lineStyleBuilder = LineStyleBuilder()
        lineStyleBuilder.color = Color(2, 119, 189, 190)
        lineStyleBuilder.width = 4f
        return lineStyleBuilder.buildStyle()
    }
}

