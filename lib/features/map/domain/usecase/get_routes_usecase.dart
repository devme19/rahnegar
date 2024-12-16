import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/map/domain/entity/route_history_entity.dart';
import 'package:rahnegar/features/map/domain/repository/map_repository.dart';

class GetRoutesUseCase implements UseCase<RouteHistoryEntity,Params>{

  final MapRepository repository;

  GetRoutesUseCase({required this.repository});

  @override
  Future<Either<Failure, RouteHistoryEntity>> call(Params params) {
    return repository.getRoutesHistory(body: params.body!);
  }
}