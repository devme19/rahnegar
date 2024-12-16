import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/car/domain/entity/my_cars_entity.dart';
import 'package:rahnegar/features/car/domain/repository/car_repository.dart';

class GetMyCarsUseCase implements UseCase<MyCarsEntity,NoParams>{
  CarRepository repository;

  GetMyCarsUseCase({required this.repository});

  @override
  Future<Either<Failure, MyCarsEntity>> call(NoParams params) {
    return repository.getMyCars();
  }
}