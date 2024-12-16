import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/map/domain/entity/mark_location_response_entity.dart';
import 'package:rahnegar/features/map/domain/repository/map_repository.dart';

class MarkLocationUseCase implements UseCase<MarkLocationResponseEntity,Params>{

  final MapRepository repository;

  MarkLocationUseCase({required this.repository});

  @override
  Future<Either<Failure, MarkLocationResponseEntity>> call(Params params) {
    return repository.markLocation(body: params.body!);
  }
}