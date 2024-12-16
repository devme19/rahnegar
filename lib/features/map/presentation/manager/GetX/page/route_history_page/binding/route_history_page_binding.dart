import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rahnegar/common/utils/constants.dart';
import 'package:rahnegar/features/car/domain/usecase/get_my_cars_usecase.dart';
import 'package:rahnegar/features/map/data/data_sources/remote/web_socket_service.dart';
import 'package:rahnegar/features/map/domain/usecase/get_routes_usecase.dart';
import 'package:rahnegar/features/map/presentation/manager/GetX/page/route_history_page/controller/route_history_page_controller.dart';

import '../../../../../../../car/data/datasources/local/car_local_datasource.dart';
import '../../../../../../../car/data/datasources/local/car_local_datasource_impl.dart';
import '../../../../../../../car/data/datasources/remote/car_remote_datasource.dart';
import '../../../../../../../car/data/repository/car_repository_impl.dart';
import '../../../../../../../car/domain/repository/car_repository.dart';
import '../../../../../../data/data_sources/local/map_local_data_source.dart';
import '../../../../../../data/data_sources/remote/map_remote_datasource.dart';
import '../../../../../../data/repository/map_repository_impl.dart';
import '../../../../../../domain/repository/map_repository.dart';

class RouteHistoryPageBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<MapRemoteDataSource>(()=>MapRemoteDataSource());
    Get.lazyPut<MapLocalDataSource>(()=>MapLocalDataSourceImpl(box: Get.find<GetStorage>()));
    Get.lazyPut<WebSocketService>(()=>WebSocketService(url: webSocketUrl));
    Get.lazyPut<MapRepository>(()=>MapRepositoryImpl(remoteDataSource: Get.find<MapRemoteDataSource>(),webSocketService: Get.find<WebSocketService>()));
    Get.lazyPut<GetRoutesUseCase>(()=> GetRoutesUseCase(repository: Get.find<MapRepository>()));
    Get.lazyPut<CarRemoteDatasource>(()=>CarRemoteDatasource());
    Get.lazyPut<CarLocalDatasource>(()=>CarLocalDatasourceImpl());
    Get.lazyPut<CarRepository>(()=>CarRepositoryImpl(remoteDatasource: Get.find<CarRemoteDatasource>(),localDataSource: Get.find<CarLocalDatasource>()));
    Get.lazyPut<GetMyCarsUseCase>(()=>GetMyCarsUseCase(repository: Get.find<CarRepository>()));
    Get.lazyPut(()=>RouteHistoryPageController());
  }

}