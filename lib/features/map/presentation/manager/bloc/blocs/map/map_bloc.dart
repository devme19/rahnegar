import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/map/data/model/item.dart';
import 'package:rahnegar/features/map/domain/entity/location_entity.dart';
import 'package:rahnegar/features/map/domain/entity/route_history_entity.dart';
import 'package:rahnegar/features/map/domain/usecase/get_coordinates_usecase.dart';
import 'package:rahnegar/features/map/domain/usecase/get_routes_usecase.dart';
import 'package:rahnegar/native/native_bridge.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final NativeBridge nativeBridge;
  final GetCoordinatesUseCase getCoordinatesUseCase;
  final GetRoutesUseCase getRoutesUseCase;
  Timer? _timer, _historyTimer;
  bool _isPaused = true;
  bool _historyIsPaused = true;
  String serialNumber = '';
  LocationEntity? latestLocation;
  bool reset = false;
  MapController mapController = MapController(
      initPosition: GeoPoint(latitude: 35.7219, longitude: 51.3347));
  GeoPoint? previousGeoPoint;
  final int timeInterval = 5;
  final int historyTimeInterval = 3;
  List<GeoPoint> latestPoints=[];

  MapBloc(
      {required this.nativeBridge,
      required this.getCoordinatesUseCase,
      required this.getRoutesUseCase})
      : super(MapInitial()) {
    on<SearchEvent>(_onSearch);
    on<ListenToLocationEvent>(_listenToLocation);
    on<GetCoordinateEvent>(getCoordinate);
    on<GetRoutesEvent>(_getRoutes);
    add(ListenToLocationEvent());
  }

  Future<void> _getRoutes(GetRoutesEvent event, Emitter<MapState> emit) async {
    emit(GetRoutsLoading());
    final response =
        await getRoutesUseCase.call(Params(body: event.queryParameters));
    response.fold(
      (failure) {
        emit(GetRoutesFailed(failure: failure));
      },
      (routeHistoryEntity) {
        List<RouteHistoryDataEntity> routes = routeHistoryEntity.data!;
        mapController.clearAllRoads();
        mapController.removeMarker(GeoPoint(
            latitude: latestLocation!.latitude!,
            longitude: latestLocation!.longitude!));
        mapController.drawRoadManually(routeHistoryEntity.points!,
            const RoadOption(roadColor: Colors.blue, roadWidth: 15.0));
        if(_historyTimer!=null) {
          _historyTimer!.cancel();
        }
        historyRoadMovement(routeHistoryEntity.points!);
        emit(GetRoutesLoaded(routes: routes));
      },
    );
  }

  historyRoadMovement(List<GeoPoint> points) async {
    // pauseTimer();
    double bearing = 0;
    int index = 0;
    _isPaused = true;
    _historyIsPaused = true;
    if(_timer!=null) {
      _timer!.cancel();
    }
    if(_historyTimer!=null){
      _historyTimer!.cancel();
    }
    if(latestLocation!=null){
      if(latestLocation!.latitude!=null && latestLocation!.longitude !=null){
       await mapController.removeMarker(GeoPoint(latitude: latestLocation!.latitude!, longitude: latestLocation!.longitude!));
      }
    }
    // if(latestPoints.isNotEmpty){
    //
    //   await mapController.removeMarkers(latestPoints);
    //   await Future.delayed(const Duration(seconds: 3));
    // }
    _historyIsPaused = false;
    _historyTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if(!_historyIsPaused){
        {
          if (index < points.length - 1) {
            bearing = calculateBearing(
              points[index].latitude,
              points[index].longitude,
              points[index + 1].latitude,
              points[index + 1].longitude,
            );
            mapController.changeLocationMarker(
              oldLocation: points[index],
              newLocation: points[index + 1],
              markerIcon: MarkerIcon(
                  iconWidget: Transform.rotate(
                    angle: bearing * pi / 180, // Convert degrees to radians
                    child: Image.asset(
                      'assets/images/map/car2.png',
                      width: 45,
                    ),
                  )),
            );
            index++;
            latestLocation = LocationEntity(
                longitude: points[index].longitude,
                latitude: points[index].latitude);
          } else {
            _historyTimer!.cancel();
          }
        }
      }
    });
    latestPoints = points;
  }

  onSearchListTileTap(
      {required double latitude, required double longitude}) async {
    String result =
        await nativeBridge.addMarker(latitude: latitude, longitude: longitude);
  }

  clearSearch() async {
    String result = await nativeBridge.clearSearch();
  }

  removeSelectedLocationMarker() async {
    String result = await nativeBridge.removeSelectedLocationMarker();
  }

  getCoordinate(GetCoordinateEvent event, Emitter<MapState> emit) {
    emit(GetLocationLoading());
    _timer = Timer.periodic(Duration(seconds: timeInterval), (timer) async {
      print("get coordinate for ${event.serialNumber}");
      serialNumber = event.serialNumber;
      await getCoordinatesUseCase.startFetching(
          '{"type": "get_location", "device_sn": "$serialNumber"}');
    });
  }

  goToLocation(double latitude, double longitude) async {
    // if(latestLocation!= null) {
    //  if(latestLocation!.latitude !=null && latestLocation!.longitude!=null){
    //    String result = await nativeBridge.goToLocation(latitude: latestLocation!.latitude!, longitude: latestLocation!.longitude!);
    //  }
    // }
    final GeoPoint currentGeoPoint = GeoPoint(
      latitude: latitude,
      longitude: longitude,
    );
    mapController.moveTo(currentGeoPoint);
  }

  void pauseTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _isPaused = true;
      print("timer paused");
    }
    if (_historyTimer != null) {
      // _historyTimer!.cancel();
      _historyIsPaused = true;
    }
  }

  void resumeTimer() {
    if(_historyIsPaused && _historyTimer != null){
      _historyIsPaused=false;
    }
    else
    if (_isPaused) {
      if (latestLocation != null) {
        if (latestLocation!.latitude != null &&
            latestLocation!.longitude != null) {
          mapController.removeMarker(GeoPoint(
              latitude: latestLocation!.latitude!,
              longitude: latestLocation!.longitude!));
        }
      }
      _isPaused = false;
      print("timer started");
      add(GetCoordinateEvent(serialNumber: serialNumber));
    }
  }

  Future<void> _listenToLocation(
      ListenToLocationEvent event, Emitter<MapState> emit) async {
    double bearing = 0;
    try {
      await emit.forEach<LocationEntity>(
        getCoordinatesUseCase.call(),
        onData: (location) {
          print('${location.latitude} --- ${location.longitude}');
          if (location.longitude != null && location.latitude != null) {
            latestLocation = location;
            if(_historyTimer != null){
              _historyTimer!.cancel();
            }
            if (reset) {
              goToLocation(location.latitude!, location.longitude!);
              reset = false;
            }
            final GeoPoint currentGeoPoint = GeoPoint(
              latitude: location.latitude!,
              longitude: location.longitude!,
            );
            if (previousGeoPoint == null) {
              previousGeoPoint = currentGeoPoint;
              mapController.moveTo(currentGeoPoint, animate: true);
            } else {
              bearing = calculateBearing(
                previousGeoPoint!.latitude,
                previousGeoPoint!.longitude,
                currentGeoPoint.latitude,
                currentGeoPoint.longitude,
              );
            }
            print("Bearing:$bearing");

            // Update the marker location on the map.
            mapController.changeLocationMarker(
              oldLocation: previousGeoPoint!,
              newLocation: currentGeoPoint,
              markerIcon: MarkerIcon(
                  iconWidget: Transform.rotate(
                angle: bearing * pi / 180, // Convert degrees to radians
                child: Image.asset(
                  'assets/images/map/car2.png',
                  width: 45,
                ),
              )),
            );
            mapController.moveTo(currentGeoPoint, animate: true);
            // Update the previous location with the current one.
            previousGeoPoint = currentGeoPoint;
            // nativeBridge.sendLiveLocation(
            //     latitude: location.latitude!, longitude: location.longitude!);
          } else {
            return LocationNotSet();
          }
          return LocationLoaded(location: location);
        },
        onError: (_, __) => GetLocationFailed(),
      );
    } catch (e) {
      emit(GetLocationFailed());
    }
  }

  Future<void> _onSearch(SearchEvent event, Emitter<MapState> emit) async {
    emit(SearchInProgress());
    try {
      List<Item> list = await nativeBridge.search(term: event.term);
      emit(SearchSucceed(items: list));
    } catch (e) {
      emit(SearchFailed(failure: e.toString()));
    }
  }

  double calculateBearing(double lat1, double lon1, double lat2, double lon2) {
    final double lat1Rad = lat1 * pi / 180;
    final double lat2Rad = lat2 * pi / 180;
    final double dLon = (lon2 - lon1) * pi / 180;

    final double y = sin(dLon) * cos(lat2Rad);
    final double x =
        cos(lat1Rad) * sin(lat2Rad) - sin(lat1Rad) * cos(lat2Rad) * cos(dLon);

    final double bearingRad = atan2(y, x);
    return (bearingRad * 180 / pi + 360) %
        360; // Convert to degrees and normalize
  }
}
