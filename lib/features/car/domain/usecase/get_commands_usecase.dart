import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/car/domain/entity/command_entity.dart';
import 'package:rahnegar/features/car/domain/repository/car_repository.dart';

class GetCommandsUseCase extends UseCase<CommandEntity,Params>{
  final CarRepository repository;

  GetCommandsUseCase({required this.repository});

  @override
  Future<Either<Failure, CommandEntity>> call(Params params) {
    return repository.getCommands(queryParameters: params.body!);
  }
}