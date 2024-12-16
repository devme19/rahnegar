import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/common/entity/response_entity.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/car/domain/entity/add_vehicle_response_entity.dart';
import 'package:rahnegar/features/car/domain/repository/car_repository.dart';

class AddCarUseCase implements UseCase<AddVehicleResponseEntity,Params>{
  final CarRepository repository;

  AddCarUseCase({required this.repository});

  @override
  Future<Either<Failure, AddVehicleResponseEntity>> call(Params params) {
    return repository.addCar(body: params.body!);
  }
}