import 'package:equatable/equatable.dart';

import '../../../../common/entity/error_entity.dart';

class MyCarsEntity extends Equatable{
  List<CarEntity>? data;
  ErrorEntity? error;

  MyCarsEntity({this.data, this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [data,error];
}
class CarEntity extends Equatable{
  int? id;
  String? createdAt;
  int? userId;
  String? nickname;
  int? modelId;
  int? year;
  int? deviceId;
  String? serialNumber;
  String? modelEn;
  String? modelFa;
  String? iconLink;
  String? brand;
  int? model;

  CarEntity(
      { this.id,
        this.createdAt,
        this.userId,
        this.nickname,
        this.modelId,
        this.year,
        this.deviceId,
        this.serialNumber,
        this.modelEn,
        this.modelFa,
        this.iconLink,
        this.brand,
        this.model
      });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    createdAt,
    userId,
    nickname,
    modelId,
    year,
    deviceId,
    iconLink
  ];
}