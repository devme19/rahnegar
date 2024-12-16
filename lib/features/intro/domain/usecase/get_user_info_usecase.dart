import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/intro/domain/entity/user_entity.dart';
import 'package:rahnegar/features/intro/domain/repository/intro_repository.dart';

class GetUserInfoUseCase implements UseCase<UserEntity,NoParams>{
  final IntroRepository repository;

  GetUserInfoUseCase({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) {
    return repository.getUserInfo();
  }

}