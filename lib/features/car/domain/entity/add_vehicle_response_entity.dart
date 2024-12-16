import 'package:equatable/equatable.dart';
import 'package:rahnegar/common/entity/error_entity.dart';
import 'package:rahnegar/features/car/domain/entity/my_cars_entity.dart';

class AddVehicleResponseEntity extends Equatable{
  ErrorEntity? error;
  DataEntity? dataEntity;

  AddVehicleResponseEntity({this.error, this.dataEntity});

  @override
  // TODO: implement props
  List<Object?> get props => [error,dataEntity];
}
class DataEntity extends Equatable{
  int? code;
  String? description;
  List<CarEntity>? data;

  DataEntity({this.code, this.description, this.data});

  @override
  // TODO: implement props
  List<Object?> get props => [
    code,
    description,
    data
  ];
}