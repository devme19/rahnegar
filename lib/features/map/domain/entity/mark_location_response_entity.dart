import 'package:equatable/equatable.dart';

import '../../../../common/entity/error_entity.dart';

class MarkLocationResponseEntity extends Equatable{
  Data? data;
  ErrorEntity? error;

  MarkLocationResponseEntity({this.data, this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [data,error];
}

class Data extends Equatable{
  String? name;
  double? longitude;
  double? latitude;

  Data({this.name, this.longitude, this.latitude});

  @override
  // TODO: implement props
  List<Object?> get props => [name,longitude,longitude];
}