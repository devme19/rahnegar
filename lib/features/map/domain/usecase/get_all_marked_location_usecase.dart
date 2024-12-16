import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/map/domain/entity/all_marked_location_entity.dart';
import 'package:rahnegar/features/map/domain/entity/mark_location_response_entity.dart';
import 'package:rahnegar/features/map/domain/repository/map_repository.dart';

class GetAllMarkedLocationUseCase implements UseCase<AllMarkedLocationEntity,NoParams>{

  final MapRepository repository;

  GetAllMarkedLocationUseCase({required this.repository});

  @override
  Future<Either<Failure, AllMarkedLocationEntity>> call(NoParams params) {
    return repository.getAllMarkedLocation();
  }
}