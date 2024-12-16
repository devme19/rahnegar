import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/common/utils/failure_action.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/car/data/model/my_cars_model.dart';
import 'package:rahnegar/features/car/domain/entity/my_cars_entity.dart';
import 'package:rahnegar/features/car/domain/usecase/get_my_cars_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/load_default_car_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/save_default_car_usecase.dart';
import 'package:rahnegar/features/map/data/model/item.dart';
import 'package:rahnegar/features/map/domain/usecase/get_coordinates_usecase.dart';
import 'package:rahnegar/native/native_bridge.dart';

import '../../../../../../domain/entity/location_entity.dart';

class NeshanMapController extends GetxController{

  GetCoordinatesUseCase getCoordinatesUseCase = Get.find();
  GetMyCarsUseCase getMyCarsUseCase = Get.find();
  LoadDefaultCarUseCase loadDefaultCarUseCase = Get.find();
  SaveDefaultCarUseCase saveDefaultCarUseCase = Get.find();


  Rx<LocationEntity> location = LocationEntity().obs;
  RxBool showClearIcon = false.obs;
  RxBool isExpanded = false.obs;
  Rx<RxStatus> searchByNameStatus = RxStatus.empty().obs;
  RxList<Item> searchResults = <Item>[].obs;
  Rx<RxStatus> getMyCarsStatus = RxStatus.empty().obs;
  RxList<CarEntity> myCars = <CarEntity>[].obs;
  Rx<CarEntity> selectedCar = CarEntity().obs;
  RxInt myCarsLength = 0.obs;


  Timer? _timer;
  bool _isPaused = true;



  @override
  void onInit() {
    super.onInit();
    listenToGetCoordinate();
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
      print("get coordinate for ${selectedCar.value.serialNumber}");
      await getCoordinatesUseCase.startFetching('{"type": "get_location", "device_sn": "${selectedCar.value.serialNumber??''}"}');
    });
  }

  Future<void> listenToGetCoordinate() async {
    getCoordinatesUseCase.call().listen((locationModel) {
      location.value = locationModel;
      handleLocationUpdate(locationModel);
      print(location.value);
    });
  }

  void handleLocationUpdate(LocationEntity location) async {
    NativeBridge().sendLiveLocation(latitude: location.latitude!, longitude: location.longitude!);
  }
  void search(String term) async {
    searchByNameStatus.value = RxStatus.loading();
    searchResults.clear();
    List<Item> list =await NativeBridge().search(term: term);
    searchByNameStatus.value = RxStatus.success();
    showClearIcon.value = true;
    if(list.isNotEmpty){
      searchResults.addAll(list);
      isExpanded.value = true;
    }
  }
  clearSearch()async{
    showClearIcon.value = false;
    isExpanded.value = false;
    removeSelectedLocationMarker();
    Get.focusScope!.unfocus();
    String result = await NativeBridge().clearSearch();
  }
  onSearchListTileTap({required double latitude,required double longitude})async{
    isExpanded.value = false;
    print("latitude: $latitude,longitude: $longitude");
    String result = await NativeBridge().addMarker(latitude: latitude, longitude: longitude);

  }
  goToLocation()async{
    String result = await NativeBridge().goToLocation(latitude: location.value.latitude!, longitude: location.value.longitude!);
  }
  removeSelectedLocationMarker()async{

    String result = await NativeBridge().removeSelectedLocationMarker();
  }
  getMyCars(){
    getMyCarsStatus.value = RxStatus.loading();
    getMyCarsUseCase.call(NoParams()).then((response){
      if(response.isRight){
        getMyCarsStatus.value = RxStatus.success();
        myCars.clear();
        myCars.addAll(response.right.data!);
        myCarsLength.value = myCars.length;
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

  saveDefaultCar(){
    String jsonString = jsonEncode(CarModel.fromCarEntity(selectedCar.value).toJson());
    saveDefaultCarUseCase.call(Params(stringValue: jsonString));
  }
}