import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/car/domain/entity/mileage_entity.dart';
import 'package:rahnegar/features/car/domain/repository/car_repository.dart';

class GetMileageUseCase implements UseCase<MileageEntity,Params>{

  CarRepository repository;
  GetMileageUseCase({required this.repository});

  @override
  Future<Either<Failure, MileageEntity>> call(Params params) {
    return repository.getMileage(queryParameters: params.body!);
  }
}