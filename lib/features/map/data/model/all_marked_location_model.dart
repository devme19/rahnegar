import 'package:rahnegar/features/map/domain/entity/all_marked_location_entity.dart';

import '../../../../common/model/error_model.dart';

class AllMarkedLocationModel extends AllMarkedLocationEntity{
  AllMarkedLocationModel({super.data,super.error});

  factory AllMarkedLocationModel.fromJson(Map<String, dynamic> json) {
    var locationList = json['data'] as List;
    List<Data> locations = locationList.map((location) => DataModel.fromJson(location)).toList();
    return AllMarkedLocationModel(
      data: locations,
      error: ErrorModel.fromJson(json['error']),
    );
  }
}
class DataModel extends Data {
  DataModel({
    super.id,
    super.name,
    super.createdAt,
    super.userId,
    super.latitude,
    super.longitude,
  });
  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      name: json['name'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      userId: json['user_id'],
      createdAt: json['created_at']
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }

  factory DataModel.fromDataEntity(Data data) {
    return DataModel(
      id: data.id,
        name: data.name,
        latitude: data.latitude,
        longitude: data.longitude,
    );
  }
}
