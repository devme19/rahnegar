import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/features/intro/domain/entity/user_entity.dart';

import '../../../../common/utils/either.dart';

abstract class IntroRepository{
  Future<Either<Failure,bool>> isAuthorized();
  Future<Either<Failure,UserEntity>> getUserInfo();
}