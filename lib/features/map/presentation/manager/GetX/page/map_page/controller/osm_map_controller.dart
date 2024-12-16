

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:rahnegar/common/utils/failure_action.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/car/data/model/my_cars_model.dart';
import 'package:rahnegar/features/car/domain/usecase/get_my_cars_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/load_default_car_usecase.dart';
import 'package:rahnegar/features/map/data/model/all_marked_location_model.dart';
import 'package:rahnegar/features/map/data/model/location_model.dart';
import 'package:rahnegar/features/map/domain/entity/all_marked_location_entity.dart';
import 'package:rahnegar/features/map/domain/entity/location_entity.dart';
import 'package:rahnegar/features/map/domain/usecase/delete_marked_location_usecase.dart';
import 'package:rahnegar/features/map/domain/usecase/get_all_marked_location_usecase.dart';
import 'package:rahnegar/features/map/domain/usecase/get_coordinates_usecase.dart';
import 'package:rahnegar/features/map/domain/usecase/mark_location_usecase.dart';
import 'package:rahnegar/features/map/presentation/manager/GetX/page/map_page/widgets/location_to_mark_widget.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:async';

import '../../../../../../../../common/client/failures.dart';
import '../../../../../../../../common/utils/either.dart';
import '../../../../../../../car/domain/entity/my_cars_entity.dart';

class OsmMapController extends GetxController{

  MapController mapController = MapController(

      initPosition: GeoPoint(latitude: 35.7219,longitude: 51.3347));
  GeoPoint? destinationPoint;
  Rx<LocationEntity> location = LocationEntity().obs;
  GeoPoint? previousGeoPoint;
  TextEditingController searchController = TextEditingController();
  bool _isPaused = true;

  Timer? _timer;
  RxDouble rotation=0.0.obs;
  Rx<AllMarkedLocationEntity> allMarkedLocationEntity = AllMarkedLocationEntity(data: []).obs;
  RxBool showMarkedLocationsWidget = false.obs;
  Rx<RxStatus> searchByNameStatus = RxStatus.empty().obs;
  RxList<SearchInfo> searchResults = <SearchInfo>[].obs;
  RxBool isExpanded = false.obs;
  RxList<CarEntity> myCars = <CarEntity>[].obs;
  Rx<CarEntity> selectedCar = CarEntity().obs;
  Rx<RxStatus> getMyCarsStatus = RxStatus.empty().obs;
  RxBool showClearIcon = false.obs;

  GetAllMarkedLocationUseCase getAllMarkedLocationUseCase = Get.find();
  MarkLocationUseCase markLocationUseCase = Get.find();
  DeleteMarkedLocationUseCase deleteMarkedLocationUseCase = Get.find();
  GetCoordinatesUseCase getCoordinatesUseCase = Get.find();
  GetMyCarsUseCase getMyCarsUseCase = Get.find();
  LoadDefaultCarUseCase loadDefaultCarUseCase = Get.find();



  Future<void> listenToGetCoordinate() async {
      getCoordinatesUseCase.call().listen((locationModel) {
        location.value = locationModel;
        handleLocationUpdate(locationModel);
        print(location.value);
      });
  }
  void pauseTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _isPaused = true;
      print("timer paused");
    }
  }
  void resumeTimer() {
    if (_isPaused) {
      _isPaused = false;
      print("timer started");
      getCoordinate();
    }
  }
  getCoordinate(){
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async{
      await getCoordinatesUseCase.startFetching('{"type": "get_location", "device_sn": "${selectedCar.value.serialNumber}"}');
    });
  }
  @override
  void onInit() {
    super.onInit();
    getMyCars();
    listenToGetCoordinate();
    mapController.listenerMapSingleTapping.addListener((){
      isExpanded.value = false;
    });
    mapController.listenerMapLongTapping.addListener(()async{
      GeoPoint? point = mapController.listenerMapLongTapping.value;
      Get.dialog( LocationToMarkWidget(
        point: point,
          onSubmit: (location){
        print(location);
        markLocation(DataModel.fromDataEntity(location).toJson());
      },onCancel: (){},));
        });
  }
  Future<AllMarkedLocationEntity> getAllMarkedLocations()async{
    Either<Failure, AllMarkedLocationEntity> response = await getAllMarkedLocationUseCase.call(NoParams());
    if(response.isRight){
      allMarkedLocationEntity.value = response.right;
      allMarkedLocationEntity.refresh();
    }
    else if(response.isLeft)
    {
      final failure = response.left;
      if(failure is ServerFailure) {
        if(failure.errorCode != 404){
          failureDialog(response.left, Get.context);
        }
      }else{
        failureDialog(response.left, Get.context);
      }

    }
    return allMarkedLocationEntity.value;
  }
  showMarkedLocations()async{
    if(allMarkedLocationEntity.value.data!.isEmpty) {
      final response = await getAllMarkedLocations();
      if (response.data != null) {
        if (response.data!.isNotEmpty) {
          for (var item in response.data!) {
            await Future.delayed(const Duration(milliseconds: 500));
            addMarker(item);
          }
          showMarkedLocationsWidget.value = true;
        } else {
          showMarkedLocationsWidget.value = false;
        }
      }
    }
  }

  markLocation(Map<String,dynamic> body){
    markLocationUseCase.call(Params(body: body)).then((response){
      if(response.isRight){
        // for(var point in allMarkedLocationEntity.value.data!){
        //   removeMarker(point);
        // }
        // showMarkedLocations();
        allMarkedLocationEntity.value.data!.add(DataModel(
          latitude: response.right.data!.latitude,
          longitude: response.right.data!.longitude,
          name: response.right.data!.name
        ));
        if(showMarkedLocationsWidget.value == false){
          showMarkedLocationsWidget.value = true;
        }
        addMarker(allMarkedLocationEntity.value.data!.last);
      }else if(response.isLeft){

      }
    });
  }

  goToLocation(GeoPoint point)async{
    await mapController.moveTo(point,animate: true);
  }

  addMarker(Data location){

    GeoPoint point = GeoPoint(latitude: location.latitude!, longitude: location.longitude!);
    mapController.addMarker(
      point,
      markerIcon: MarkerIcon(
        iconWidget: SizedBox(
          height: 80.0,
          child: Column(
            children: [
              Text(location.name!,style: const TextStyle(color: Colors.red,fontWeight: FontWeight.normal,fontSize: 15)),
              const Icon(Icons.location_on, color: Colors.red,size: 50,),
            ],
          ),
        )
      ),
    );
  }
  deleteMarkedLocation(Data item){
    final body={'id':item.id};
    deleteMarkedLocationUseCase.call(Params(body: body)).then((response){
      if(response.isRight){
        GeoPoint point = GeoPoint(latitude: item.latitude!, longitude: item.longitude!);
        mapController.removeMarker(point);
        allMarkedLocationEntity.value.data!.remove(item);
        allMarkedLocationEntity.refresh();
        if(allMarkedLocationEntity.value.data!.isEmpty){
          showMarkedLocationsWidget.value = false;
        }
      }else if(response.isLeft){
        failureDialog(response.left, Get.context);
      }
    });
  }
  removeMarker(Data location){
    GeoPoint point = GeoPoint(latitude: location.latitude!, longitude: location.longitude!);
    mapController.removeMarker(point);
  }
  searchCity(context)async{
    GeoPoint? p = await showSimplePickerLocation(
      context: context,
      isDismissible: true,
      title: "Title dialog",
      textConfirmPicker: "pick",
      initCurrentUserPosition: const UserTrackingOption(enableTracking: true,unFollowUser: true),
    );
    // List<SearchInfo> points = await addressSuggestion(name);
    // for(var item in points){
    //   print(item.address!.name);
    //   print(item.address!.city);
    //   print(item.address!.state);
    //   print(item.address!.street);
    // }
  }
  Future<void> searchCityByName(String cityName) async {
    try {
      searchByNameStatus.value = RxStatus.loading();
      final  results = await addressSuggestion(cityName);
      isExpanded.value = true;
      searchResults.clear();
      searchByNameStatus.value = RxStatus.success();

      if (results.isNotEmpty) {
        searchResults.addAll(results);
      } else {
        print("No city found with the name: $cityName");
      }
    } catch (e) {
      searchByNameStatus.value = RxStatus.error();
    }
  }
  onListTileTap(SearchInfo item,String name){
    isExpanded.value = false;
    searchController.text = name;
    goToLocation(item.point!);
  }

  void handleLocationUpdate(LocationEntity location) async {
    final GeoPoint currentGeoPoint = GeoPoint(
      latitude: location.latitude!,
      longitude: location.longitude!,
    );

    print("${location.latitude} - ${location.longitude}");

    // If previous point is null, initialize it and move the map to the first location.
    if (previousGeoPoint == null) {
      previousGeoPoint = currentGeoPoint;
      await mapController.moveTo(currentGeoPoint, animate: true);
    }

    // Update the marker location on the map.
    await mapController.changeLocationMarker(
      oldLocation: previousGeoPoint!,
      newLocation: currentGeoPoint,
      markerIcon: const MarkerIcon(
        icon: Icon(
          Icons.circle,
          color: Colors.blue,
          size: 15,
        ),
      ),
    );

    // Update the previous location with the current one.
    previousGeoPoint = currentGeoPoint;
  }

  getMyCars(){
    getMyCarsStatus.value = RxStatus.loading();
    getMyCarsUseCase.call(NoParams()).then((response){
      if(response.isRight){
        getMyCarsStatus.value = RxStatus.success();
        myCars.clear();
        myCars.addAll(response.right.data!);
        if (myCars.isNotEmpty && selectedCar.value.id==null){
          selectedCar.value  = myCars.first;
        }
      }else if(response.isLeft){
        failureDialog(response.left,Get.context);
      }
    });
  }
  Future<CarEntity> loadDefaultCar()async{
    print("load");
    Either<Failure,String> response = await loadDefaultCarUseCase.call(NoParams());
    if(response.isRight){
      Map<String,dynamic> json = jsonDecode(response.right);
      selectedCar.value = CarModel.fromJson(json);
      return selectedCar.value;
    }
    return CarEntity();
  }

}

class Marker extends StatelessWidget {
  Marker({super.key,required this.name}){
    print(name);
  }
  String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.0,
      child: Column(
        children: [
          Text(name,style: const TextStyle(color: Colors.red,fontWeight: FontWeight.w100,fontSize: 15)),
          const Icon(Icons.location_on, color: Colors.red,size: 50,),
        ],
      ),
    );
  }
}
