import 'package:rahnegar/features/car/domain/entity/brand_data_entity.dart';

class BrandDataModel extends BrandDataEntity{
  BrandDataModel({
    super.id,
    super.nameEng,
    super.nameFa,
    super.parentId,
});
  factory BrandDataModel.fromJson(Map<String,dynamic> json){
    return BrandDataModel(
      parentId: json['parent_id'],
      nameFa: json['name_fa'],
      nameEng: json['name_eng'],
      id: json['id']
    );
  }
}