import 'package:rahnegar/common/client/exception.dart';
import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/features/setting/data/datasources/locale_data_source/setting_local_data_source.dart';
import 'package:rahnegar/features/setting/domain/repository/setting_repository.dart';

class SettingRepositoryImpl implements SettingRepository{
  final SettingLocalDataSource localDataSource;

  SettingRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, String>> getLocale() async{
    try{
      String locale = localDataSource.getLocale();
      return Right(locale);
    }on CacheException catch(e){
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> getThemeMode() async{
    try{
      String mode = localDataSource.getThemeMode();
      return Right(mode);
    }on CacheException catch(e){
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> saveLocale(String locale) async{
    try{
      bool response = localDataSource.saveLocale(locale);
      return Right(response);
    }on CacheException catch(e){
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> saveThemeMode(String mode) async{
    try{
      bool response = localDataSource.saveThemeMode(mode);
      return Right(response);
    }on CacheException catch(e){
      return Left(CacheFailure(message: e.message));
    }
  }

}