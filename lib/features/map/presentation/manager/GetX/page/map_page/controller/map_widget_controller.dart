import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MyMarker{
  List<Marker> items = [];
}
class MapWidgetController extends GetxController with StateMixin{
  Rx<MyMarker> markers= MyMarker().obs;
  Rx<LatLng> initialCameraPosition = const LatLng(35.689198, 51.388973).obs;
  LatLng? initialPosition;
  MapController? mapController;
  Position? latestPosition;
  Map<String, dynamic>? jsonMap;
  bool isSearch = false;
  @override
  void onInit() {
    super.onInit();
    // homeController = Get.find<HomeController>();
    mapController = MapController();
    determinePosition();
  }

  Future<Position> determinePosition() async {
   change(null, status: RxStatus.loading());
    await getLocationPermission();
    latestPosition = await Geolocator.getCurrentPosition();
    if(initialPosition!=null) {
      initialCameraPosition.value = initialPosition!;
    } else {
      initialCameraPosition.value = LatLng(latestPosition!.latitude,latestPosition!.longitude);
    }
   change(null,status:  RxStatus.success());
    initialCameraPosition.value = LatLng(latestPosition!.latitude, latestPosition!.longitude);
    // getMapCenter();
    mapController!.move(initialCameraPosition.value, 15);
    getMapCenter();
    return latestPosition!;
  }
  getLocationPermission() async{
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

  }
  getMapCenter(){
    // markers.value.items.clear();
    markers.value.items.add(Marker(
      width: 200.0,
      height: 200.0,
      point: initialCameraPosition.value,
      child: const Icon(Icons.location_on,color: Colors.red,size: 50,)
    ));
    markers.refresh();
  }
  getCurrentPosition()async{
    mapController!.move(initialCameraPosition.value, 15);
  }
}