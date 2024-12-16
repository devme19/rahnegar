import 'package:equatable/equatable.dart';
import 'package:rahnegar/common/entity/data_entity.dart';
import 'package:rahnegar/common/entity/error_entity.dart';

class ResponseEntity extends Equatable{
  final ErrorEntity error;
  final DataEntity data;

  ResponseEntity({
    required this.error,
    required this.data,
  });

  @override
  List<Object?> get props => [error, data];
}