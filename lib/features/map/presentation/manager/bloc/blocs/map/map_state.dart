part of 'map_bloc.dart';

@immutable
sealed class MapState {}

final class MapInitial extends MapState {}
final class SearchInProgress extends MapState{}
final class SearchSucceed extends MapState{
 final List<Item> items;
  SearchSucceed({required this.items});
}
final class SearchFailed extends MapState{
  final String failure;
  SearchFailed({required this.failure});
}
final class LocationNotSet extends MapState{}
final class GetLocationFailed extends MapState{}
final class GetLocationLoading extends MapState{}
final class LocationLoaded extends MapState{
  final LocationEntity location;
  LocationLoaded({required this.location});
}
class GetRoutsLoading extends MapState{}
class GetRoutesLoaded extends MapState{
  final List<RouteHistoryDataEntity> routes;
  GetRoutesLoaded({required this.routes});
}
class GetRoutesFailed extends MapState{
  final Failure failure;

  GetRoutesFailed({required this.failure});
}
