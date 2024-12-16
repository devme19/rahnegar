import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/car/data/model/brand_data_model.dart';
import 'package:rahnegar/features/car/data/model/my_cars_model.dart';
import 'package:rahnegar/features/car/domain/entity/brand_data_entity.dart';
import 'package:rahnegar/features/car/domain/entity/brand_entity.dart';
import 'package:rahnegar/features/car/domain/entity/my_cars_entity.dart';
import 'package:rahnegar/features/car/domain/usecase/add_car_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/delete_car_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/get_brands_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/get_fcm_token_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/get_my_cars_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/send_fcm_token_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/update_car_usecase.dart';

import '../../../../../../../../common/utils/either.dart';
import '../../../../../../../../common/utils/failure_action.dart';
import '../../../../../../../../common/model/production_year_model.dart';
import '../../../../../../../../common/utils/get_failure_description.dart';
import '../../../../../../domain/usecase/load_default_car_usecase.dart';
import '../../../../../../domain/usecase/save_default_car_usecase.dart';

class AddCarPageController extends GetxController {
  final addCarStatus = RxStatus.empty().obs;
  final getBrandsStatus = RxStatus.empty().obs;
  final getMyCarsStatus = RxStatus.empty().obs;

  ProductionYearModel? selectedProductionYear;
  BrandDataEntity selectedModelEntity = BrandDataEntity();
  BrandDataEntity selectedBrandEntity = BrandDataEntity();

  AddCarUseCase addCarUseCase = Get.find();
  GetBrandsUseCase getBrandsUseCase = Get.find();
  GetMyCarsUseCase getMyCarsUseCase = Get.find();
  DeleteCarUseCase deleteCarUseCase = Get.find();
  SaveDefaultCarUseCase saveDefaultCarUseCase = Get.find();
  UpdateCarUseCase updateCarUseCase = Get.find();
  LoadDefaultCarUseCase loadDefaultCarUseCase = Get.find();
  SendFcmTokenUseCase sendFcmTokenUseCase = Get.find();
  GetFcmTokenUseCase getFcmTokenUseCase = Get.find();

  Rx<BrandEntity> brandEntity = BrandEntity().obs;
  Rx<MyCarsEntity> myCarsEntity = MyCarsEntity(data: []).obs;

  ProductionYearModel? productionYear;
  int selectedIndex = -1;
  Failure failure = NetworkFailure();
  RxBool addCarValidation = false.obs;
  String serialNumber = '';

  @override
  void onInit() {
    super.onInit();
    getMyCars();
    getBrands();
  }

  addCar(CarModel car) async {
    addCarStatus.value = RxStatus.loading();
    addCarUseCase.call(Params(body: car.toJson())).then((response) {
      if (response.isRight) {
        // myCarsEntity.value.data!.add(CarModel(nickname: car.nickname,id: car.id));
        myCarsEntity.value.data!.add(CarModel(
            id: response.right.dataEntity!.data![0].id,
            nickname: response.right.dataEntity!.data![0].nickname,
            serialNumber: car.serialNumber,
            year: response.right.dataEntity!.data![0].year,
            modelFa: response.right.dataEntity!.data![0].modelFa,
            modelEn: response.right.dataEntity!.data![0].modelEn,
            iconLink: response.right.dataEntity!.data![0].iconLink));
        if(myCarsEntity.value.data!.length == 1){
          saveDefaultCar(CarModel.fromCarEntity(myCarsEntity.value.data!.first));
        }
        myCarsEntity.refresh();
        String fcmToken='';
        getFcmTokenUseCase.call(NoParams()).then((response){
          if(response.isRight){
            fcmToken = response.right;
            Map<String,dynamic> body = {
              "device":car.serialNumber,
              "device_token":fcmToken
            };
            sendFcmTokenUseCase.call(Params(body: body)).then((response){
                if(response.isRight){
                  print(response.right);
                }
            });
          }
        });



      } else if (response.isLeft) {
        failureDialog(response.left, Get.context);
      }
    });
    addCarStatus.value = RxStatus.success();
  }

  deleteCar(CarEntity car) {
    final body = {"id": car.id};
    deleteCarUseCase.call(Params(body: body)).then((response) async{
      if (response.isRight) {
        final defaultCar = await loadDefaultCar();
        myCarsEntity.value.data!.remove(car);
        if(defaultCar.id == car.id){
          if(myCarsEntity.value.data!.isNotEmpty){
            saveDefaultCar(CarModel.fromCarEntity(myCarsEntity.value.data!.first));
          }
          else{
            saveDefaultCar(CarModel());
          }

        }

        myCarsEntity.refresh();
      } else if (response.isLeft) {}
    });
    myCarsEntity.refresh();
  }

  getBrands({String id = ''}) async {
    Map<String, dynamic> body = {};
    if (id.isNotEmpty) {
      body = {'parent_id': id};
    }
    getBrandsStatus.value = RxStatus.loading();
    getBrandsUseCase.call(Params(body: body)).then((response) async {
      if (response.isRight) {
        brandEntity.value = response.right;
        getBrandsStatus.value = RxStatus.success();
      } else if (response.isLeft) {
        getBrandsStatus.value =
            RxStatus.error(getFailureDescription(response.left, Get.context));
        failureDialog(response.left, Get.context);
      }
    });
  }

  getMyCars() async {
    print("mycars");
    getMyCarsStatus.value = RxStatus.loading();
    getMyCarsUseCase.call(NoParams()).then((response) async {
      if (response.isRight) {
        CarEntity defaultCar = await loadDefaultCar();
        getMyCarsStatus.value = RxStatus.success();
        myCarsEntity.value = response.right;
        if (defaultCar.id != null) {
          for(var item in myCarsEntity.value.data!){
            if(item.id == defaultCar.id){
              myCarsEntity.value.data!.remove(item);
              myCarsEntity.value.data!.insert(0, item);
              saveDefaultCar(CarModel.fromCarEntity(item));
              break;
            }
          }
        }

      } else if (response.isLeft) {
        getMyCarsStatus.value = RxStatus.error();
        failureDialog(response.left, Get.context);
      }
    });
  }

  updateCar(CarModel car) async {
    updateCarUseCase.call(Params(body: car.toJson())).then((response) {
      if (response.isRight) {
        String fcmToken='';
        getFcmTokenUseCase.call(NoParams()).then((response){
          if(response.isRight){
            fcmToken = response.right;
            Map<String,dynamic> body = {
              "device":car.serialNumber,
              "device_token":fcmToken
            };
            sendFcmTokenUseCase.call(Params(body: body)).then((response){
              if(response.isRight){
                print(response.right);
              }
            });
          }
        });
        getMyCars();
      } else if (response.isLeft) {
        failureDialog(response.left, Get.context);
      }
    });
  }

  saveDefaultCar(CarModel car) {
    String jsonString = jsonEncode(car.toJson());
    saveDefaultCarUseCase
        .call(Params(stringValue: jsonString))
        .then((response) {
      if (response.isRight) {
        print("saved");
      } else if (response.isLeft) {
        print("Failure");
      }
    });
  }

  Future<CarEntity> loadDefaultCar() async {
    print("load");
    Either<Failure, String> response =
        await loadDefaultCarUseCase.call(NoParams());
    if (response.isRight) {
      Map<String, dynamic> json = jsonDecode(response.right);
      return CarModel.fromJson(json);
    }
    return CarEntity();
  }
}
