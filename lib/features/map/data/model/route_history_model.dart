import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:rahnegar/features/map/domain/entity/route_history_entity.dart';

import '../../../../common/model/error_model.dart';

class RouteHistoryModel extends RouteHistoryEntity {
  RouteHistoryModel({super.data, super.points, super.error});

  factory RouteHistoryModel.fromJson(Map<String, dynamic> json) {
    List<RouteHistoryData> data = [];
    List<GeoPoint> points = [];

    // Check if 'data' is present and parse it
    if (json['data'] != null) {
      data = List<RouteHistoryData>.from(
        json['data'].map((v) => RouteHistoryData.fromJson(v)),
      );

      // Convert RouteHistoryData to GeoPoint list efficiently
      points = data.map((entry) {
        return GeoPoint(latitude: entry.latitude!, longitude: entry.longitude!);
      }).toList();
    }

    return RouteHistoryModel(
      data: data,
      points: points,
      error: json['error'] != null ? ErrorModel.fromJson(json['error']) : null,
    );
  }
}

class RouteHistoryData extends RouteHistoryDataEntity {
  RouteHistoryData({
    super.id,
    super.latitude,
    super.longitude,
    super.processed,
    super.createdAt,
    super.deviceSn,
  });

  factory RouteHistoryData.fromJson(Map<String, dynamic> json) {
    return RouteHistoryData(
      id: json['id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      processed: json['processed'],
      createdAt: json['created_at'],
      deviceSn: json['device_sn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'processed': processed,
      'created_at': createdAt,
      'device_sn': deviceSn,
    };
  }
}

