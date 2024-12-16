import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/map/domain/repository/map_repository.dart';

class DeleteMarkedLocationUseCase implements UseCase<bool,Params>{

  final MapRepository repository;

  DeleteMarkedLocationUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(Params params) {
    return repository.deleteMarkedLocation(body: params.body!);
  }
}