import 'package:equatable/equatable.dart';

class ErrorEntity extends Equatable {
  final int code;
  final String description;

  ErrorEntity({
    required this.code,
    required this.description,
  });

  @override
  List<Object?> get props => [code, description];
}