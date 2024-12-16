import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/car/domain/entity/command_response_entity.dart';
import 'package:rahnegar/features/car/domain/repository/car_repository.dart';

class SendCommandUseCase implements UseCase<CommandResponseEntity,Params>{

  final CarRepository repository;

  SendCommandUseCase({required this.repository});

  @override
  Future<Either<Failure, CommandResponseEntity>> call(Params params) {
    return repository.sendCommand(body: params.body!);
  }

}