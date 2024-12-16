import 'package:rahnegar/features/map/domain/entity/location_entity.dart';

class LocationModel extends LocationEntity{

  // Constructor
  LocationModel({
    super.type,
    super.longitude,
    super.latitude,
  });

  // Factory constructor to create an instance from JSON
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      type: json['type'],
      longitude: json['longitude'],
      latitude: json['latitude'],
    );
  }

  // Method to convert the instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}