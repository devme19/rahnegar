import 'package:rahnegar/common/model/error_model.dart';
import 'package:rahnegar/features/car/domain/entity/mileage_entity.dart';

class MileageModel extends MileageEntity{
  const MileageModel({
   super.errorEntity,
   super.dataEntity
});
  factory MileageModel.fromJson(Map<String, dynamic> json) {
    return MileageModel(
      dataEntity:json['data'] != null? DataModel.fromJson(json['data']):null,
      errorEntity: ErrorModel.fromJson(json['error']),
    );
  }
}

class DataModel extends DataEntity{
  const DataModel({
    super.totalDistance
});
  factory DataModel.fromJson(Map<String,dynamic> json){
    return DataModel(totalDistance: json['total_distance']);
  }
}