

import 'package:rahnegar/features/map/domain/entity/all_marked_location_entity.dart';
import 'package:rahnegar/features/map/domain/entity/mark_location_response_entity.dart';
import 'package:rahnegar/features/map/domain/entity/route_history_entity.dart';

import '../../../../common/client/failures.dart';
import '../../../../common/utils/either.dart';
import '../entity/location_entity.dart';

abstract class MapRepository{
  Future<Either<Failure,MarkLocationResponseEntity>> markLocation({required Map<String,dynamic> body});
  Future<Either<Failure,AllMarkedLocationEntity>> getAllMarkedLocation();
  Future<Either<Failure,bool>> deleteMarkedLocation({required Map<String, dynamic> body});
  Future<Either<Failure,RouteHistoryEntity>> getRoutesHistory({required Map<String,dynamic> body});
  Future<void> startFetchingCoordinates({required String message});
  Stream<LocationEntity> getCoordinates();
}