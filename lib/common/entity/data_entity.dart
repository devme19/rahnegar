import 'package:equatable/equatable.dart';

class DataEntity extends Equatable {
  final int code;
  final String description;

  const DataEntity({
    required this.code,
    required this.description,
  });

  @override
  List<Object?> get props => [code, description];
}