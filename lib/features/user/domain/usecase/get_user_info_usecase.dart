import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/user/domain/entity/user_entity.dart';
import 'package:rahnegar/features/user/domain/repository/user_repository.dart';

class GetUserInfoUseCase implements UseCase<UserEntity,NoParams>{
  final UserRepository repository;

  GetUserInfoUseCase({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) {
    return repository.getUserInfo();
  }
}