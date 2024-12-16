import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/car/domain/entity/my_cars_entity.dart';
import 'package:rahnegar/features/car/domain/repository/car_repository.dart';

import '../entity/add_vehicle_response_entity.dart';

class UpdateCarUseCase implements UseCase<AddVehicleResponseEntity,Params>{
  final CarRepository repository;

  UpdateCarUseCase({required this.repository});

  @override
  Future<Either<Failure, AddVehicleResponseEntity>> call(Params params) {
    return repository.updateCar(body: params.body!);
  }
}