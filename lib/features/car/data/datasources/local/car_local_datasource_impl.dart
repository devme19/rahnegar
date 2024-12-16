import 'package:get_storage/get_storage.dart';
import 'package:rahnegar/features/car/data/datasources/local/car_local_datasource.dart';

import '../../../../../common/base_data_sources/base_local_data_source.dart';
import '../../../../../common/client/exception.dart';

class CarLocalDatasourceImpl extends BaseLocalDataSourceImpl implements CarLocalDatasource {

  GetStorage box = GetStorage();
  final String carKey = "carKey";


  @override
  bool saveDefaultCar(String car) {
    try {
      box.write(carKey, car);
      return true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  String loadDefaultCar() {
    try{
      String car = box.read(carKey)??'';
      return car;
    } catch (e){
      throw CacheException(message: e.toString());
    }
  }

}