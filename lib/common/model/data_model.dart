import '../entity/data_entity.dart';

class DataModel extends DataEntity {
  DataModel({
    required int code,
    required String description,
  }) : super(
    code: code,
    description: description,
  );

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      code: json['code']??0,
      description: json['description']??'',
    );
  }
}