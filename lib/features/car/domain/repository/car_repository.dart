import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/entity/response_entity.dart';
import 'package:rahnegar/features/car/domain/entity/battery_status_response_entity.dart';
import 'package:rahnegar/features/car/domain/entity/brand_entity.dart';
import 'package:rahnegar/features/car/domain/entity/command_entity.dart';
import 'package:rahnegar/features/car/domain/entity/command_response_entity.dart';
import 'package:rahnegar/features/car/domain/entity/mileage_entity.dart';
import 'package:rahnegar/features/car/domain/entity/my_cars_entity.dart';

import '../../../../common/utils/either.dart';
import '../entity/add_vehicle_response_entity.dart';

abstract class CarRepository{
  Future<Either<Failure,AddVehicleResponseEntity>> addCar({required Map<String, dynamic> body});
  Future<Either<Failure,BrandEntity>> getBrands({Map<String, dynamic> body});
  Future<Either<Failure,MyCarsEntity>> getMyCars();
  Future<Either<Failure,bool>> deleteCar({required Map<String,dynamic> body});
  Future<Either<Failure,bool>> saveDefaultCar({required String car});
  Future<Either<Failure,String>> loadDefaultCar();
  Future<Either<Failure,AddVehicleResponseEntity>> updateCar({required Map<String,dynamic> body});
  Future<Either<Failure,CommandResponseEntity>> sendCommand({required Map<String,dynamic> body});
  Future<Either<Failure,BatteryStatusResponseEntity>> getBatteryStatus({required Map<String,dynamic> body});
  Future<Either<Failure,bool>> sendFcmToken({required Map<String,dynamic> body});
  Future<Either<Failure,String>> getFcmToken();
  Future<Either<Failure,MileageEntity>> getMileage({required Map<String,dynamic> queryParameters});
  Future<Either<Failure,CommandEntity>> getCommands({required Map<String,dynamic> queryParameters});
}