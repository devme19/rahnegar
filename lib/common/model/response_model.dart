import 'package:rahnegar/common/entity/response_entity.dart';
import 'package:rahnegar/common/model/data_model.dart';
import 'package:rahnegar/common/model/error_model.dart';

class ResponseModel extends ResponseEntity {
  ResponseModel({
    ErrorModel? error,
    DataModel? data,
  }) : super(
    error: error!,
    data: data!,
  );

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      error: ErrorModel.fromJson(json['error']),
      data: DataModel.fromJson(json['data']),
    );
  }
}