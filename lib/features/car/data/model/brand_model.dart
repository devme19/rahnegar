import 'package:rahnegar/common/model/error_model.dart';
import 'package:rahnegar/features/car/data/model/brand_data_model.dart';
import 'package:rahnegar/features/car/domain/entity/brand_entity.dart';

class BrandModel extends BrandEntity {

  BrandModel({
    ErrorModel? error,
    List<BrandDataModel>? data,
  }) :super(error: error, data: data);

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    final List<BrandDataModel> dataList = [];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        dataList.add(BrandDataModel.fromJson(v));
      });
    }
    return BrandModel(
      data: dataList,
      error:  ErrorModel.fromJson(json['error']),
    );
  }
}