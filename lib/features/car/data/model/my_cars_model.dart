import 'package:get/get.dart';
import 'package:rahnegar/common/model/error_model.dart';
import 'package:rahnegar/features/car/domain/entity/my_cars_entity.dart';

class MyCarsModel extends MyCarsEntity {
  MyCarsModel({
    super.error,
    super.data,
  });
  factory MyCarsModel.fromJson(Map<String, dynamic> json) {
    final List<CarModel> dataList = [];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        dataList.add(CarModel.fromJson(v));
      });
    }
    return MyCarsModel(
      data: dataList,
      error: ErrorModel.fromJson(json['error']),
    );
  }
}

class CarModel extends CarEntity {
  CarModel(
      {super.id,
      super.createdAt,
      super.userId,
      super.nickname,
      super.modelId,
      super.year,
      super.deviceId,
        super.serialNumber,
        super.modelEn,
        super.modelFa,
        super.iconLink,
        super.brand,
        super.model
      });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
        id: json['id'],
        createdAt: json['created_at'],
        userId: json['user_id'],
        nickname: json['nickname'],
        modelId: json['model_id'],
        model: json['model'],
        year: json['year'],
        serialNumber: json['serial_number'],
        modelEn: json['model_en'],
        modelFa: json['model_fa'],
        deviceId: json['device_id'],
        iconLink: json['icon_link']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['user_id'] = userId;
    data['nickname'] = nickname;
    data['model_id'] = modelId;
    data['year'] = year;
    data['device_id'] = deviceId;
    data['model_en'] = modelEn;
    data['model'] = model;
    data['model_fa'] = modelFa;
    data['serial_number'] = serialNumber;
    data['icon_link'] = iconLink;
    return data;
  }

  factory CarModel.fromCarEntity(CarEntity carEntity) {
    return CarModel(
      id: carEntity.id,
      createdAt: carEntity.createdAt,
      userId: carEntity.userId,
      nickname: carEntity.nickname,
      modelId: carEntity.modelId,
      year: carEntity.year,
      deviceId: carEntity.deviceId,
      serialNumber: carEntity.serialNumber,
      modelEn: carEntity.modelEn,
      modelFa: carEntity.modelFa,
      iconLink: carEntity.iconLink,
      model: carEntity.model
    );
  }
}
