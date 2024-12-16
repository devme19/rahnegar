import 'package:equatable/equatable.dart';

class BatteryStatusResponseEntity extends Equatable{

  String? type;
  double? vehicleBattery;
  double? deviceBattery;
  String? createdAt;

  BatteryStatusResponseEntity({this.type,this.vehicleBattery,this.deviceBattery,this.createdAt});
  @override
  // TODO: implement props
  List<Object?> get props => [type,vehicleBattery,deviceBattery,createdAt];
}