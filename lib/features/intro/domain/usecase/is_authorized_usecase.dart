import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/intro/domain/repository/intro_repository.dart';

class IsAuthorizedUseCase implements UseCase<bool,NoParams>{
  final IntroRepository repository;

  IsAuthorizedUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    // TODO: implement call
    return repository.isAuthorized();
  }

}