import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/car/domain/repository/car_repository.dart';

class SaveDefaultCarUseCase implements UseCase<bool,Params>{
  final CarRepository repository;

  SaveDefaultCarUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(Params params) {
    return repository.saveDefaultCar(car: params.stringValue!);
  }
}