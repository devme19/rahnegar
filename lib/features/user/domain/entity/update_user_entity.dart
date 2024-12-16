import 'package:equatable/equatable.dart';
import 'package:rahnegar/common/entity/data_entity.dart';
import 'package:rahnegar/common/entity/error_entity.dart';
import 'package:rahnegar/features/user/domain/entity/update_data_entity.dart';

class UpdateUserEntity extends Equatable{
  final ErrorEntity error;
  final UpdateDataEntity data;

  const UpdateUserEntity({required this.error,required this.data});

  @override
  // TODO: implement props
  List<Object?> get props => [
    error,
    data
  ];

}