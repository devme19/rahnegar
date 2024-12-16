import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/car/data/model/my_cars_model.dart';
import 'package:rahnegar/features/car/domain/usecase/get_my_cars_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/load_default_car_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/save_default_car_usecase.dart';
import 'package:rahnegar/features/map/domain/usecase/get_routes_usecase.dart';

import '../../../../../../../car/domain/entity/my_cars_entity.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class RouteHistoryPageController extends GetxController{
  late MapController mapController;

  GetRoutesUseCase getRoutesUseCase = Get.find();
  GetMyCarsUseCase getMyCarsUseCase = Get.find();
  LoadDefaultCarUseCase loadDefaultCarUseCase = Get.find();
  SaveDefaultCarUseCase saveDefaultCarUseCase = Get.find();

  RxList<CarEntity> myCars = <CarEntity>[].obs;
  Rx<CarEntity> selectedCar = CarEntity().obs;
  Rx<RxStatus> getMyCarsStatus = RxStatus.empty().obs;
  RxString carName=''.obs;


  @override
  void onInit() {
    super.onInit();
    mapController = MapController(initPosition: GeoPoint(latitude: 35.7219,longitude: 51.3347));
  }

  CarEntity loadDefaultCar(){
    print("load default car");
    loadDefaultCarUseCase.call(NoParams()).then((response){
      Map<String,dynamic> json = jsonDecode(response.right);
      selectedCar.value = CarModel.fromJson(json);
      return selectedCar.value;
    });
    return CarEntity();
  }
  saveDefaultCar(){
    String jsonString = jsonEncode(CarModel.fromCarEntity(selectedCar.value).toJson());
    saveDefaultCarUseCase.call(Params(stringValue: jsonString));
  }
  getRoutesHistory(Map<String,dynamic> body){
    List<GeoPoint> points = [
      GeoPoint(latitude: 35.7239,longitude: 51.3357),
      GeoPoint(latitude: 35.7249,longitude: 51.3367),
      GeoPoint(latitude: 35.7259,longitude: 51.3387),
      GeoPoint(latitude: 35.7269,longitude: 51.3397),
      GeoPoint(latitude: 35.7289,longitude: 51.3497),
      GeoPoint(latitude: 35.7299,longitude: 51.3597),
    ];
    // for(var item in response.right.data!){
    //     points.add(GeoPoint(latitude: item.latitude!, longitude: item.longitude!));
    //     if(points.length>20){
    //       break;
    //     }
    // }
    mapController.drawRoadManually(points, const RoadOption(
      roadColor: Colors.purple,
      roadWidth: 10.0,
    ),);
    // getRoutesUseCase.call(Params(body: body)).then((response){
    //   if(response.isRight){
    //     print(response.right);
    //     List<GeoPoint> points = [
    //       GeoPoint(latitude: 35.7239,longitude: 51.3357),
    //       GeoPoint(latitude: 35.7249,longitude: 51.3367),
    //       GeoPoint(latitude: 35.7259,longitude: 51.3387),
    //       GeoPoint(latitude: 35.7269,longitude: 51.3397),
    //       GeoPoint(latitude: 35.7289,longitude: 51.3497),
    //       GeoPoint(latitude: 35.7299,longitude: 51.3597),
    //     ];
    //     // for(var item in response.right.data!){
    //     //     points.add(GeoPoint(latitude: item.latitude!, longitude: item.longitude!));
    //     //     if(points.length>20){
    //     //       break;
    //     //     }
    //     // }
    //    mapController.drawRoadManually(points, const RoadOption(
    //      roadColor: Colors.purple,
    //      roadWidth: 10.0,
    //    ),);
    //   }else if(response.isLeft){
    //
    //   }
    // });
  }
  getMyCars(){
    getMyCarsStatus.value = RxStatus.loading();
    getMyCarsUseCase.call(NoParams()).then((response){
      if(response.isRight){
        getMyCarsStatus.value = RxStatus.success();
        myCars.clear();
        myCars.addAll(response.right.data!);
        if(selectedCar.value.id==null){
          selectedCar.value = myCars.first;

        }
        if(selectedCar.value.nickname!=null){
          carName.value = selectedCar.value.nickname!;
        }else{
          carName.value = selectedCar.value.modelFa!;
        }

      }else if(response.isLeft){
      }
    });
  }
  String getCarName(context){
    if(selectedCar.value.nickname!=null){
      if(selectedCar.value.nickname!.isNotEmpty){
        return selectedCar.value.nickname!;
      }
    }else if(selectedCar.value.modelFa!=null){
      return selectedCar.value.modelFa!;
    }
    return AppLocalizations.of(context)!.pleaseSelectTheCar;
  }


}