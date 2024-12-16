import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/features/user/domain/entity/update_user_entity.dart';
import 'package:rahnegar/features/user/domain/entity/user_entity.dart';

import '../../../../common/utils/either.dart';

abstract class UserRepository{
  Future<Either<Failure,UpdateUserEntity>> updateUser(Map<String,dynamic> body);
  Future<Either<Failure,UserEntity>> getUserInfo();
}