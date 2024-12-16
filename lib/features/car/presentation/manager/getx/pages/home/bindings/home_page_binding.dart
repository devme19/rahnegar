import 'package:get/get.dart';
import 'package:rahnegar/features/car/data/datasources/local/car_local_datasource.dart';
import 'package:rahnegar/features/car/data/datasources/local/car_local_datasource_impl.dart';
import 'package:rahnegar/features/car/domain/usecase/get_battery_status_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/load_default_car_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/save_default_car_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/send_command_usecase.dart';
import 'package:rahnegar/features/car/presentation/manager/getx/pages/home/controller/home_page_controller.dart';

import '../../../../../../data/datasources/remote/car_remote_datasource.dart';
import '../../../../../../data/repository/car_repository_impl.dart';
import '../../../../../../domain/repository/car_repository.dart';
import '../../../../../../domain/usecase/get_my_cars_usecase.dart';

class HomePageBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<CarRemoteDatasource>(()=>CarRemoteDatasource());
    Get.lazyPut<CarLocalDatasource>(()=>CarLocalDatasourceImpl());
    Get.lazyPut<CarRepository>(()=>CarRepositoryImpl(remoteDatasource: Get.find<CarRemoteDatasource>(),localDataSource: Get.find<CarLocalDatasource>()));
    Get.lazyPut<GetMyCarsUseCase>(()=>GetMyCarsUseCase(repository: Get.find<CarRepository>()));
    Get.lazyPut<SaveDefaultCarUseCase>(()=>SaveDefaultCarUseCase(repository: Get.find<CarRepository>()));
    Get.lazyPut<LoadDefaultCarUseCase>(()=>LoadDefaultCarUseCase(repository: Get.find<CarRepository>()));
    Get.lazyPut<SendCommandUseCase>(()=>SendCommandUseCase(repository: Get.find<CarRepository>()));
    Get.lazyPut<GetBatteryStatusUseCase>(()=>GetBatteryStatusUseCase(repository: Get.find<CarRepository>()));
    Get.lazyPut(()=>HomePageController());
  }

}