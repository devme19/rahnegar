import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/constants.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/common/utils/failure_action.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/car/data/model/my_cars_model.dart';
import 'package:rahnegar/features/car/domain/entity/my_cars_entity.dart';
import 'package:rahnegar/features/car/domain/usecase/get_battery_status_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/get_my_cars_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/load_default_car_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/save_default_car_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/send_command_usecase.dart';

import '../../../../../widgets/chart_widget.dart';

class HomePageController extends GetxController{

  GetMyCarsUseCase getMyCarsUseCase = Get.find();
  SaveDefaultCarUseCase saveDefaultCarUseCase = Get.find();
  LoadDefaultCarUseCase loadDefaultCarUseCase = Get.find();
  SendCommandUseCase sendCommandUseCase = Get.find();
  GetBatteryStatusUseCase getBatteryStatusUseCase = Get.find();

  Rx<RxStatus> getMyCarsStatus = RxStatus.empty().obs;
  Rx<RxStatus> getMyCarsBottomSheetStatus = RxStatus.empty().obs;
  RxList<CarEntity> myCars = <CarEntity>[].obs;
  Rx<CarEntity> selectedCar = CarEntity().obs;
  RxList<PercentData> percentData = <PercentData>[].obs;


  RxBool switchValue = true.obs;


  @override
  void onInit() {
    super.onInit();
    getMyCars();
    loadDefaultCar();
    getBatteryStatus();
  }

  getMyCars({bool isBottomSheet=false}){
    if(isBottomSheet){
      getMyCarsBottomSheetStatus.value = RxStatus.loading();
    }else{
      getMyCarsStatus.value = RxStatus.loading();
    }

    getMyCarsUseCase.call(NoParams()).then((response){
      if(response.isRight){
        myCars.clear();
        if(isBottomSheet){
          getMyCarsBottomSheetStatus.value = RxStatus.success();
        }else{
          getMyCarsStatus.value = RxStatus.success();
        }
        if(response.right.data != null){
          myCars.addAll(response.right.data!);
          if(myCars.isNotEmpty){
            if(selectedCar.value.id == null){
              selectedCar.value = myCars[0];
            }
          }
        }

      }else if (response.isLeft){
        if(isBottomSheet){
          getMyCarsBottomSheetStatus.value = RxStatus.error();
        }else{
          getMyCarsStatus.value = RxStatus.error();
        }
        failureDialog(response.left, Get.context);
      }
    });
  }
  saveDefaultCar(CarModel car){
    String jsonString = jsonEncode(car.toJson());
    saveDefaultCarUseCase.call(Params(stringValue: jsonString)).then((response){
      if(response.isRight){
        print("saved");
      }else if(response.isLeft){
        print("Failure");
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

  sendCommand({required Commands command, required Values value,required Function() onDone}){
    print(value.name);
    Map<String,dynamic> body={"type":"command", "device_sn" :selectedCar.value.serialNumber , "command":value.name};
    sendCommandUseCase.call(Params(body: body)).then((response){
      if(response.isRight){
        print(response.right);
        onDone();
      }else if(response.isLeft){
      }
    });
    commandStatus[command] = value;
    print(command.name);
    print(value.name);
  }
  getBatteryStatus(){
    Map<String,dynamic> body={"type":"get_battery_status", "device_sn" :selectedCar.value.serialNumber};
    percentData.clear();
    percentData.add(PercentData(89, DateTime.parse("2024-10-03 06:48:24.713543+00:00")));
    percentData.add(PercentData(70, DateTime.parse("2024-10-03 08:30:24.713543+00:00")));
    percentData.add(PercentData(65, DateTime.parse("2024-10-03 09:10:24.713543+00:00")));
    percentData.add(PercentData(50, DateTime.parse("2024-10-03 10:13:24.713543+00:00")));
    percentData.add(PercentData(40, DateTime.parse("2024-10-04 10:48:24.713543+00:00")));
    percentData.add(PercentData(35, DateTime.parse("2024-10-05 12:07:24.713543+00:00")));
    percentData.add(PercentData(10, DateTime.parse("2024-10-06 13:47:24.713543+00:00")));
    percentData.add(PercentData(25, DateTime.parse("2024-10-07 15:48:24.713543+00:00")));
    percentData.add(PercentData(33, DateTime.parse("2024-10-08 16:10:24.713543+00:00")));
    // percentData.add(PercentData(38, DateTime.parse("2024-10-08 19:48:24.713543+00:00")));
    // percentData.add(PercentData(46, DateTime.parse("2024-10-08 20:48:24.713543+00:00")));
    // percentData.add(PercentData(78, DateTime.parse("2024-10-08 23:48:24.713543+00:00")));
    // percentData.add(PercentData(100, DateTime.parse("2024-10-08 23:55:24.713543+00:00")));
    // getBatteryStatusUseCase.call(Params(body: body)).then((response){
    //   if(response.isRight){
    //     percentData.add(PercentData(response.right.vehicleBattery!, DateTime.parse(response.right.createdAt!)));
    //     print(response.right);
    //   }else if(response.isLeft){
    //
    //   }
    // });
  }

}