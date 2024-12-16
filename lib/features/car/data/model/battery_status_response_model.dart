import 'package:rahnegar/features/car/domain/entity/battery_status_response_entity.dart';

class BatteryStatusResponseModel extends BatteryStatusResponseEntity{

  BatteryStatusResponseModel(
      {super.type, super.vehicleBattery, super.deviceBattery, super.createdAt});

  BatteryStatusResponseModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    vehicleBattery = json['vehicle_battery'];
    deviceBattery = json['device_battery'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['vehicle_battery'] = vehicleBattery;
    data['device_battery'] = deviceBattery;
    data['created_at'] = createdAt;
    return data;
  }
}