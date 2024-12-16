part of 'map_bloc.dart';

@immutable
sealed class MapEvent {}
class SearchEvent extends MapEvent{
  final String term;
  SearchEvent({required this.term});
}
class ListenToLocationEvent extends MapEvent{}
class GetCoordinateEvent extends MapEvent{
  final String serialNumber;
  GetCoordinateEvent({required this.serialNumber});
}
class GetRoutesEvent extends MapEvent{
  final Map<String,dynamic> queryParameters;
  GetRoutesEvent({required this.queryParameters});
}
