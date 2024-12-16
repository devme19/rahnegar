import 'package:equatable/equatable.dart';

import '../../../../common/entity/error_entity.dart';

class AllMarkedLocationEntity extends Equatable{
  List<Data>? data;
  ErrorEntity? error;


  AllMarkedLocationEntity({this.data, this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [data,error];
}

class Data extends Equatable{
  int? id;
  String? name;
  int? userId;
  double? latitude;
  double? longitude;
  String? createdAt;

  Data(
      {this.id,
        this.name,
        this.userId,
        this.latitude,
        this.longitude,
        this.createdAt});

  @override
  // TODO: implement props
  List<Object?> get props => [id,name,userId,latitude,longitude,createdAt];

}