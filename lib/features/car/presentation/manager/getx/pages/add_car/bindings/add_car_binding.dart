import 'package:get/get.dart';
import 'package:rahnegar/features/car/data/datasources/local/car_local_datasource.dart';
import 'package:rahnegar/features/car/data/datasources/local/car_local_datasource_impl.dart';
import 'package:rahnegar/features/car/data/datasources/remote/car_remote_datasource.dart';
import 'package:rahnegar/features/car/data/repository/car_repository_impl.dart';
import 'package:rahnegar/features/car/domain/repository/car_repository.dart';
import 'package:rahnegar/features/car/domain/usecase/add_car_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/delete_car_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/get_brands_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/get_fcm_token_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/get_my_cars_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/save_default_car_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/send_fcm_token_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/update_car_usecase.dart';

import '../../../../../../domain/usecase/load_default_car_usecase.dart';
import '../controller/add_car_page_controller.dart';

class AddCarBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<CarRemoteDatasource>(()=>CarRemoteDatasource());
    Get.lazyPut<CarLocalDatasource>(()=>CarLocalDatasourceImpl());
    Get.lazyPut<CarRepository>(()=>CarRepositoryImpl(remoteDatasource: Get.find<CarRemoteDatasource>(),localDataSource: Get.find<CarLocalDatasource>()));
    Get.lazyPut<AddCarUseCase>(()=>AddCarUseCase(repository: Get.find<CarRepository>()));
    Get.lazyPut<GetBrandsUseCase>(()=>GetBrandsUseCase(repository: Get.find<CarRepository>()));
    Get.lazyPut<LoadDefaultCarUseCase>(()=>LoadDefaultCarUseCase(repository: Get.find<CarRepository>()));
    Get.lazyPut<GetMyCarsUseCase>(()=>GetMyCarsUseCase(repository: Get.find<CarRepository>()));
    Get.lazyPut<DeleteCarUseCase>(()=>DeleteCarUseCase(repository: Get.find<CarRepository>()));
    Get.lazyPut<SaveDefaultCarUseCase>(()=>SaveDefaultCarUseCase(repository: Get.find<CarRepository>()));
    Get.lazyPut<UpdateCarUseCase>(()=>UpdateCarUseCase(repository: Get.find<CarRepository>()));
    Get.lazyPut<SendFcmTokenUseCase>(()=>SendFcmTokenUseCase(repository: Get.find<CarRepository>()));
    Get.lazyPut<GetFcmTokenUseCase>(()=>GetFcmTokenUseCase(repository: Get.find<CarRepository>()));
    Get.lazyPut<AddCarPageController>(()=>AddCarPageController());

  }

}