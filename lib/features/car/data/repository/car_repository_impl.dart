import 'package:dio/dio.dart';
import 'package:rahnegar/common/client/exception.dart';
import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/constants.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/features/auth/data/model/user_data_model.dart';
import 'package:rahnegar/features/car/data/datasources/remote/car_remote_datasource.dart';
import 'package:rahnegar/features/car/data/model/add_vehicle_response_model.dart';
import 'package:rahnegar/features/car/data/model/battery_status_response_model.dart';
import 'package:rahnegar/features/car/data/model/brand_model.dart';
import 'package:rahnegar/features/car/data/model/command_model.dart';
import 'package:rahnegar/features/car/data/model/command_response_model.dart';
import 'package:rahnegar/features/car/data/model/mileage_model.dart';
import 'package:rahnegar/features/car/data/model/my_cars_model.dart';
import 'package:rahnegar/features/car/domain/entity/battery_status_response_entity.dart';
import 'package:rahnegar/features/car/domain/entity/brand_entity.dart';
import 'package:rahnegar/features/car/domain/entity/command_entity.dart';
import 'package:rahnegar/features/car/domain/entity/command_response_entity.dart';
import 'package:rahnegar/features/car/domain/entity/mileage_entity.dart';
import 'package:rahnegar/features/car/domain/entity/my_cars_entity.dart';
import 'package:rahnegar/features/car/domain/repository/car_repository.dart';
import 'package:rahnegar/features/car/data/datasources/local/car_local_datasource.dart';
import '../../../../common/model/error_model.dart';
import '../../domain/entity/add_vehicle_response_entity.dart';

class CarRepositoryImpl implements CarRepository{
  final CarRemoteDatasource remoteDatasource;
  final CarLocalDatasource localDataSource;

  CarRepositoryImpl({required this.remoteDatasource,required this.localDataSource});

  @override
  Future<Either<Failure, AddVehicleResponseEntity>> addCar({required Map<String, dynamic> body}) async{
    try{
      Response response = await remoteDatasource.addCar(url: "vehicle/add", body: body);
      AddVehicleResponseEntity responseEntity = AddVehicleResponseModel.fromJson(response.data);
      return Right(responseEntity);
    }on ServerException catch(e){
      ErrorModel error = ErrorModel.fromJson(e.error!);
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: error.description));
    }on NetworkException catch(e){
      return Left(NetworkFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, BrandEntity>> getBrands({Map<String, dynamic>? body}) async{
    try{
      Response response = await remoteDatasource.getBrands(url: "cars/view",formData: body);
      BrandEntity brandEntity = BrandModel.fromJson(response.data);
      return Right(brandEntity);
    }on ServerException catch(e){
      ErrorModel error = ErrorModel.fromJson(e.error!);
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: error.description));
    }on NetworkException catch(e){
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, MyCarsEntity>> getMyCars() async{
    try{
      UserDataModel userDataModel  = localDataSource.getUserInfo();
      MyCarsEntity myCarsEntity = MyCarsEntity();
      if(userDataModel.id !=null){
        Response response = await remoteDatasource.getMyCars(url: "vehicle/list/${userDataModel.id}");
        myCarsEntity = MyCarsModel.fromJson(response.data);
      }
      return Right(myCarsEntity);
    }on ServerException catch(e){
      ErrorModel error = ErrorModel.fromJson(e.error!);
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: error.description));
    }on NetworkException catch(e){
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCar({required Map<String, dynamic> body}) async{
    try{
      Response response = await remoteDatasource.deleteCar(url: "vehicle/delete", body: body);
      if(response.statusCode == 200) {
        return Right(true);
      }
      else{
        return Right(false);
      }
    }on ServerException catch(e){
      ErrorModel error = ErrorModel.fromJson(e.error!);
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: error.description));
    }on NetworkException catch(e){
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> saveDefaultCar({required String car}) async{
    try{
      bool response = localDataSource.saveDefaultCar(car);
      return Right(response);
    } on CacheException catch(e){
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> loadDefaultCar() async{
    try{
      String response = localDataSource.loadDefaultCar();
      return Right(response);
    }on CacheException catch(e){
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, AddVehicleResponseEntity>> updateCar({required Map<String, dynamic> body}) async{
    try{
        Response response = await remoteDatasource.updateCar(url: "vehicle/update", body: body);
        AddVehicleResponseEntity car = AddVehicleResponseModel.fromJson(response.data);
        return Right(car);
    }on ServerException catch(e){
      ErrorModel error = ErrorModel.fromJson(e.error!);
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: error.description));
    }on NetworkException catch(e){
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, CommandResponseEntity>> sendCommand({required Map<String, dynamic> body}) async{
    try{
      final response = await remoteDatasource.sendCommand(url: webSocketUrl, body: body);
      CommandResponseEntity commandResponseEntity = CommandResponseModel.fromJson(response);
      return Right(commandResponseEntity);
    }on ServerException catch(e){
      ErrorModel error = ErrorModel.fromJson(e.error!);
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: error.description));
    }on NetworkException catch(e){
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BatteryStatusResponseEntity>> getBatteryStatus({required Map<String, dynamic> body}) async{
    try{
      final response = await remoteDatasource.sendCommand(url: webSocketUrl, body: body);
      BatteryStatusResponseEntity batteryStatusResponseEntity = BatteryStatusResponseModel.fromJson(response);
      return Right(batteryStatusResponseEntity);
    }on ServerException catch(e){
      ErrorModel error = ErrorModel.fromJson(e.error!);
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: error.description));
    }on NetworkException catch(e){
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> sendFcmToken({required Map<String, dynamic> body}) async{
    try{
      final response = await remoteDatasource.sendFcmToken(url: "user_device/create", body: body);
      return Right(response.statusCode == 200);
    }on ServerException catch(e){
      ErrorModel error = ErrorModel.fromJson(e.error!);
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: error.description));
    }on NetworkException catch(e){
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> getFcmToken() async{
    try{
      String response = localDataSource.getFcmToken();
      return Right(response);
    }on CacheException catch(e){
      return Left(CacheFailure(message: e.message));
    }

  }

  @override
  Future<Either<Failure, MileageEntity>> getMileage({required Map<String, dynamic> queryParameters}) async{
    try{
      final response = await remoteDatasource.getMileage(url: "vehicle/usage", queryParameters: queryParameters);
      MileageEntity mileageEntity = MileageModel.fromJson(response.data);
      return Right(mileageEntity);
    }on ServerException catch(e){
      ErrorModel error = ErrorModel.fromJson(e.error!);
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: error.description));
    }on NetworkException catch(e){
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, CommandEntity>> getCommands({required Map<String, dynamic> queryParameters}) async{
    try{
      final response = await remoteDatasource.getCommands(url: "command/devlist", queryParameters: queryParameters);
      CommandEntity commandEntity = CommandModel.fromJson(response.data);
      return Right(commandEntity);
    }on ServerException catch(e){
      ErrorModel error = ErrorModel.fromJson(e.error!);
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: error.description));
    }
  }



}