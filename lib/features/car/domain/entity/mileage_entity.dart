import 'package:equatable/equatable.dart';
import 'package:rahnegar/common/entity/error_entity.dart';

class MileageEntity extends Equatable{
  final ErrorEntity? errorEntity;
  final DataEntity? dataEntity;


  const MileageEntity({this.errorEntity, this.dataEntity});

  @override
  // TODO: implement props
  List<Object?> get props => [errorEntity,dataEntity];
}
class DataEntity extends Equatable{
  final String? totalDistance;

  const DataEntity({this.totalDistance});

  @override
  // TODO: implement props
  List<Object?> get props => [totalDistance];
}