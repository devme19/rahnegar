import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable{
  final String? type;
  late final double? longitude;
  final double? latitude;

  LocationEntity({this.type,this.longitude,this.latitude});

  @override
  // TODO: implement props
  List<Object?> get props => [type,longitude,latitude];
}