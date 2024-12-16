import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rahnegar/common/client/exception.dart';
import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/common/entity/response_entity.dart';
import 'package:rahnegar/common/model/response_model.dart';
import 'package:rahnegar/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:rahnegar/common/model/error_model.dart';
import 'package:rahnegar/features/auth/data/model/otp_verification_model.dart';
import 'package:rahnegar/features/auth/data/model/user_data_model.dart';
import 'package:rahnegar/features/auth/data/model/user_model.dart';
import 'package:rahnegar/features/auth/domain/entity/otp_code_entity.dart';
import 'package:rahnegar/features/auth/domain/entity/otp_verification_entity.dart';
import 'package:rahnegar/features/auth/domain/entity/user_entity.dart';
import 'package:rahnegar/features/auth/domain/repository/auth_repository.dart';

import '../datasources/local/auth_local_datasource.dart';


class AuthRepositoryImpl implements AuthRepository{

  final AuthRemoteDatasource remoteDatasource;
  final AuthLocalDatasource localDatasource;


  AuthRepositoryImpl({required this.remoteDatasource,required this.localDatasource});

  @override
  Future<Either<Failure, ResponseEntity>> getOtpCode({required Map<String,dynamic> body}) async{
      try{
        Response response = await remoteDatasource.getOtpCode(url: "user/send_otp", body: body);
        ResponseEntity responseEntity = ResponseModel.fromJson(response.data);
        return Right(responseEntity);
      }on ServerException catch(e){
        ErrorModel error = ErrorModel.fromJson(e.error!);
        return Left(ServerFailure(errorCode: e.errorCode,errorMessage: error.description));
      }on NetworkException catch(e){
        return Left(NetworkFailure(message:e.message));
      }
  }

  @override
  Future<Either<Failure, OtpVerificationEntity>> otpCodeVerification({required Map<String, dynamic> body}) async{
    try{
      Response response = await remoteDatasource.otpVerification(url: "user/send_otp", body: body);
      OtpVerificationEntity otpVerificationEntity = OtpVerificationModel.fromJson(response.data);
      String accessToken = otpVerificationEntity.data.access;
      String refreshToken = otpVerificationEntity.data.refresh;
      if(accessToken.isNotEmpty && refreshToken.isNotEmpty){
        localDatasource.saveToken(accessToken);
        localDatasource.saveRefreshToken(refreshToken);
      }
      else {
        return Left(ServerFailure(errorCode: 0,errorMessage: ''));
      }
      return Right(otpVerificationEntity);
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
      if (userEntity.data != null) {
        UserDataModel userDataModel = userEntity.data as UserDataModel;
        String userDataJsonString = userDataModel.toJsonString();
        localDatasource.saveUserInfo(userDataJsonString);
        print(userDataJsonString);
      } else {
        print('User data is null');
      }
      return Right(userEntity);
    }on ServerException catch(e){
      ErrorModel error = ErrorModel.fromJson(e.error);
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: error.description));
    }on NetworkException catch(e){
      return Left(NetworkFailure(message: e.message));
    }
  }


}