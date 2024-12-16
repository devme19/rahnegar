import 'package:equatable/equatable.dart';
import 'package:rahnegar/common/entity/error_entity.dart';
import 'package:rahnegar/features/car/domain/entity/brand_data_entity.dart';

class BrandEntity extends Equatable{
  List<BrandDataEntity>? data;
  ErrorEntity? error;

  BrandEntity({this.data,this.error});
  @override
  // TODO: implement props
  List<Object?> get props => [data,error];
}