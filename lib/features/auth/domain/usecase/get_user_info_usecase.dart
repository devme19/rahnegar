import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/auth/domain/entity/user_entity.dart';
import 'package:rahnegar/features/auth/domain/repository/auth_repository.dart';

class GetUserInfoUseCase implements UseCase<UserEntity,NoParams>{
  final AuthRepository repository;

  GetUserInfoUseCase({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) {
    return repository.getUserInfo();
  }

}