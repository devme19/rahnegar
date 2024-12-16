import 'package:rahnegar/common/model/error_model.dart';
import 'package:rahnegar/features/map/domain/entity/mark_location_response_entity.dart';

class MarkLocationResponseModel extends MarkLocationResponseEntity {
  MarkLocationResponseModel({super.data, super.error});
  factory MarkLocationResponseModel.fromJson(Map<String, dynamic> json) {
    return MarkLocationResponseModel(
      data: DataModel.fromJson(json['data']),
      error: ErrorModel.fromJson(json['error']),
    );
  }
}

class DataModel extends Data {
  DataModel({super.name, super.latitude, super.longitude});
  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      name: json['name'],
      longitude: json['longitude'],
      latitude: json['latitude'],
    );
  }
}
