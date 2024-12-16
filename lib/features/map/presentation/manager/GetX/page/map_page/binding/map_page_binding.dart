
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rahnegar/common/utils/constants.dart';
import 'package:rahnegar/features/map/data/data_sources/remote/map_remote_datasource.dart';
import 'package:rahnegar/features/map/domain/usecase/delete_marked_location_usecase.dart';
import 'package:rahnegar/features/map/domain/usecase/get_all_marked_location_usecase.dart';
import 'package:rahnegar/features/map/domain/usecase/get_coordinates_usecase.dart';
import 'package:rahnegar/features/map/domain/usecase/mark_location_usecase.dart';
import 'package:rahnegar/features/map/presentation/manager/GetX/page/map_page/controller/neshan_map_controller.dart';
import 'package:rahnegar/features/map/presentation/manager/GetX/page/map_page/controller/osm_map_controller.dart';
import '../../../../../../../car/data/datasources/local/car_local_datasource.dart';
import '../../../../../../../car/data/datasources/local/car_local_datasource_impl.dart';
import '../../../../../../../car/data/datasources/remote/car_remote_datasource.dart';
import '../../../../../../../car/data/repository/car_repository_impl.dart';
import '../../../../../../../car/domain/repository/car_repository.dart';
import '../../../../../../../car/domain/usecase/get_my_cars_usecase.dart';
import '../../../../../../data/data_sources/local/map_local_data_source.dart';
import '../../../../../../data/data_sources/remote/web_socket_service.dart';
import '../../../../../../data/repository/map_repository_impl.dart';
import '../../../../../../domain/repository/map_repository.dart';

class MapPageBinding extends Bindings{
  @override
  void dependencies() {

    Get.lazyPut<CarRemoteDatasource>(()=>CarRemoteDatasource());
    Get.lazyPut<CarLocalDatasource>(()=>CarLocalDatasourceImpl());
    Get.lazyPut<CarRepository>(()=>CarRepositoryImpl(remoteDatasource: Get.find<CarRemoteDatasource>(),localDataSource: Get.find<CarLocalDatasource>()));
    Get.lazyPut<GetMyCarsUseCase>(()=>GetMyCarsUseCase(repository: Get.find<CarRepository>()));

    Get.lazyPut<MapLocalDataSource>(()=>MapLocalDataSourceImpl(box: Get.find<GetStorage>()));
    Get.lazyPut<MapRemoteDataSource>(()=>MapRemoteDataSource());
    Get.lazyPut<WebSocketService>(()=>WebSocketService(url: webSocketUrl));
    Get.put<MapRepository>(MapRepositoryImpl(remoteDataSource: Get.find<MapRemoteDataSource>(),webSocketService: Get.find<WebSocketService>()));

    Get.lazyPut<GetCoordinatesUseCase>(()=>GetCoordinatesUseCase(repository: Get.find<MapRepository>()));
    Get.lazyPut<GetAllMarkedLocationUseCase>(()=>GetAllMarkedLocationUseCase(repository: Get.find<MapRepository>()));
    Get.lazyPut<MarkLocationUseCase>(()=>MarkLocationUseCase(repository: Get.find<MapRepository>()));
    Get.lazyPut<DeleteMarkedLocationUseCase>(()=>DeleteMarkedLocationUseCase(repository: Get.find<MapRepository>()));
    // Get.lazyPut(() => OsmMapController());
    Get.lazyPut(() => NeshanMapController());
  }

}