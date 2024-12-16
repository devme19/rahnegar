import 'package:rahnegar/common/entity/error_entity.dart';

class ErrorModel extends ErrorEntity {
  ErrorModel({
    required int code,
    required String description,
  }) : super(
    code: code,
    description: description,
  );

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      code: json['code'] ?? 0,
      description:json['description']??'',
    );
  }
}