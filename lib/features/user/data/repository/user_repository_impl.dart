import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rahnegar/common/client/exception.dart';
import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/features/user/data/datasources/local/user_local_datatsource.dart';
import 'package:rahnegar/features/user/data/datasources/remote/user_remote_datasource.dart';
import 'package:rahnegar/features/user/data/models/update_user_model.dart';
import 'package:rahnegar/features/user/data/models/user_model.dart';
import 'package:rahnegar/features/user/domain/entity/update_data_entity.dart';
import 'package:rahnegar/features/user/domain/entity/update_user_entity.dart';
import 'package:rahnegar/features/user/domain/entity/user_entity.dart';
import 'package:rahnegar/features/user/domain/repository/user_repository.dart';

import '../../../../common/model/error_model.dart';

class UserRepositoryImpl implements UserRepository{
  final UserRemoteDatasource remoteDatasource;
  final UserLocalDatasource localDatasource;

  UserRepositoryImpl({required this.remoteDatasource,required this.localDatasource});

  @override
  Future<Either<Failure, UpdateUserEntity>> updateUser(Map<String, dynamic> body) async{
    try{
      Response response = await remoteDatasource.updateUser(url: "user/update_user", body: body);
      UpdateUserEntity updateUserEntity = UpdateUserModel.fromJson(response.data);

      if(updateUserEntity.data.object!=null){
        if(updateUserEntity.data.object!.id!=null){
          ObjectEntity? object = updateUserEntity.data.object;

          if (object is ObjectDataModel) {
            String jsonString = jsonEncode(object.toJson());
            localDatasource.saveUserInfo(jsonString);
            print(jsonString);
          }
        }
      }
      return Right(updateUserEntity);
    }on ServerException catch(e){
      ErrorModel error = ErrorModel.fromJson(e.error!);
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: error.description));
    }on NetworkException catch(e){
      return Left(NetworkFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserInfo() async{
    try{
      Response response = await remoteDatasource.getUserInfo(url: "user/get");
      UserEntity userEntity = UserModel.fromJson(response.data);
      return Right(userEntity);
    }on ServerException catch(e){
      ErrorModel error = ErrorModel.fromJson(e.error);
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: error.description));
    }on NetworkException catch(e){
      return Left(NetworkFailure(message: e.message));
    }
  }

}