




import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rahnegar/features/map/data/data_sources/remote/map_remote_datasource.dart';
import 'package:rahnegar/features/map/data/model/all_marked_location_model.dart';
import 'package:rahnegar/features/map/data/model/mark_location_response_model.dart';
import 'package:rahnegar/features/map/domain/entity/all_marked_location_entity.dart';
import 'package:rahnegar/features/map/domain/entity/location_entity.dart';
import 'package:rahnegar/features/map/domain/entity/mark_location_response_entity.dart';
import 'package:rahnegar/features/map/domain/entity/route_history_entity.dart';

import '../../../../common/base_data_sources/base_remote_data_source.dart';
import '../../../../common/client/exception.dart';
import '../../../../common/client/failures.dart';
import '../../../../common/model/error_model.dart';
import '../../../../common/utils/either.dart';
import '../../domain/repository/map_repository.dart';
import '../data_sources/local/map_local_data_source.dart';
import '../data_sources/remote/web_socket_service.dart';
import '../model/route_history_model.dart';

class MapRepositoryImpl implements MapRepository{

  final MapRemoteDataSource remoteDataSource;
  final WebSocketService webSocketService;

  MapRepositoryImpl({required this.remoteDataSource,required this.webSocketService});


  @override
  Future<Either<Failure, MarkLocationResponseEntity>> markLocation({required Map<String, dynamic> body}) async{
    try{
      Response response = await remoteDataSource.markLocation(url: "defined_location/add", body: body);
      MarkLocationResponseEntity markLocationResponseEntity = MarkLocationResponseModel.fromJson(response.data);
      return Right(markLocationResponseEntity);
    }on ServerException catch(e){
      ErrorModel error = ErrorModel.fromJson(e.error!);
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: error.description));
    }on NetworkException catch(e){
      return Left(NetworkFailure(message: e.message));
    }
  }


  @override
  Future<Either<Failure, AllMarkedLocationEntity>> getAllMarkedLocation() async{
    try{
      Response response = await remoteDataSource.getAllMarkedLocation(url: "defined_location/get");
      AllMarkedLocationEntity allMarkedLocationEntity = AllMarkedLocationModel.fromJson(response.data);
      return Right(allMarkedLocationEntity);
    }on ServerException catch(e){
      ErrorModel error = ErrorModel.fromJson(e.error!);
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: error.description));
    }on NetworkException catch(e){
      return Left((NetworkFailure(message: e.message)));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteMarkedLocation({required Map<String, dynamic> body}) async{
    try{
      Response response = await remoteDataSource.deleteMarkedLocation(url: "defined_location/delete", body: body);
      if(response.statusCode == 200)
        {
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
  Future<Either<Failure, RouteHistoryEntity>> getRoutesHistory({required Map<String, dynamic> body}) async{
    try{
      Response response = await remoteDataSource.getRoutesHistory(url: "user_report/get", body: body);
      RouteHistoryEntity routeHistoryEntity = RouteHistoryModel.fromJson(response.data);
      return Right(routeHistoryEntity);
    }on ServerException catch(e){
      ErrorModel error = ErrorModel.fromJson(e.error!);
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: error.description));
    }on NetworkException catch(e){
      return Left((NetworkFailure(message: e.message)));
    }
  }

  @override
  Future<void> startFetchingCoordinates({required String message}) async {
    webSocketService.send(message);
  }

  @override
  Stream<LocationEntity> getCoordinates() {
    return webSocketService.locationStream;
  }





}