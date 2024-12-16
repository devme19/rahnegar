import 'package:rahnegar/common/client/failures.dart';

import '../../../../common/utils/either.dart';

abstract class SettingRepository{
  Future<Either<Failure,bool>> saveThemeMode(String mode);
  Future<Either<Failure,String>> getThemeMode();
  Future<Either<Failure,bool>> saveLocale(String locale);
  Future<Either<Failure,String>> getLocale();
}