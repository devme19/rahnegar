import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/user/domain/entity/update_user_entity.dart';
import 'package:rahnegar/features/user/domain/repository/user_repository.dart';

class UpdateUserInfoUseCase implements UseCase<UpdateUserEntity,Params>{
  final UserRepository repository;

  UpdateUserInfoUseCase({required this.repository});

  @override
  Future<Either<Failure, UpdateUserEntity>> call(Params params) {
    return repository.updateUser(params.body!);
  }
}