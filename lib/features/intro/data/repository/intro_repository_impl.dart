import 'package:dio/dio.dart';
import 'package:rahnegar/common/client/exception.dart';
import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/model/error_model.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/features/intro/data/datasources/local/intro_local_datasource.dart';
import 'package:rahnegar/features/intro/data/datasources/remote/intro_remote_datasource.dart';
import 'package:rahnegar/features/intro/data/model/user_data_model.dart';
import 'package:rahnegar/features/intro/data/model/user_model.dart';
import 'package:rahnegar/features/intro/domain/entity/user_entity.dart';
import 'package:rahnegar/features/intro/domain/repository/intro_repository.dart';


class IntroRepositoryImpl implements IntroRepository{
  final IntroLocalDatasource localDatasource;
  final IntroRemoteDatasource remoteDatasource;

  IntroRepositoryImpl({required this.localDatasource,required this.remoteDatasource});

  @override
  Future<Either<Failure, bool>> isAuthorized() async{
    // TODO: implement isAuthorized
    try{
      bool result = localDatasource.isAuthorized();
      return Right(result);
    }on CacheException catch(e){
      return Left(CacheFailure(message: e.message));
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
        localDatasource.saveUsrInfo(userDataJsonString);
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