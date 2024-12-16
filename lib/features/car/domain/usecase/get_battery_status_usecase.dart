import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/car/domain/entity/battery_status_response_entity.dart';
import 'package:rahnegar/features/car/domain/repository/car_repository.dart';

class GetBatteryStatusUseCase implements UseCase<BatteryStatusResponseEntity,Params>{
  final CarRepository repository;

  GetBatteryStatusUseCase({required this.repository});

  @override
  Future<Either<Failure, BatteryStatusResponseEntity>> call(Params params) {
    return repository.getBatteryStatus(body: params.body!);
  }
}