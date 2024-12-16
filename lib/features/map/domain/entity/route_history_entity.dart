import 'package:equatable/equatable.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import '../../../../common/entity/error_entity.dart';

class RouteHistoryEntity extends Equatable{
  List<RouteHistoryDataEntity>? data;
  List<GeoPoint>? points;
  ErrorEntity? error;

  RouteHistoryEntity({this.data, this.error,this.points});

  @override
  // TODO: implement props
  List<Object?> get props => [data,error];
}

class RouteHistoryDataEntity extends Equatable{
  int? id;
  double? latitude;
  double? longitude;
  bool? processed;
  String? createdAt;
  String? deviceSn;

  RouteHistoryDataEntity({this.id, this.longitude, this.latitude,this.processed,this.createdAt,this.deviceSn});

  @override
  // TODO: implement props
  List<Object?> get props => [id,longitude,longitude,deviceSn];
}