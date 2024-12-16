import 'package:rahnegar/features/map/domain/entity/location_entity.dart';
import 'package:rahnegar/features/map/domain/repository/map_repository.dart';

class GetCoordinatesUseCase{
  final MapRepository repository;

  GetCoordinatesUseCase({required this.repository});

  Future<void> startFetching(String message) async {
    return repository.startFetchingCoordinates(message: message);
  }

  Stream<LocationEntity> call() {
    return repository.getCoordinates();
  }
}