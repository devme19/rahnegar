import 'package:rahnegar/common/model/error_model.dart';
import 'package:rahnegar/features/car/domain/entity/add_vehicle_response_entity.dart';

import 'my_cars_model.dart';

class AddVehicleResponseModel extends AddVehicleResponseEntity {
  AddVehicleResponseModel({super.error, super.dataEntity});
  factory AddVehicleResponseModel.fromJson(Map<String, dynamic> json) {
    final error =
        json['error'] != null ? ErrorModel.fromJson(json['error']) : null;
    final data = json['data'] != null ? Data.fromJson(json['data']) : null;
    return AddVehicleResponseModel(
      dataEntity: data,
      error: error,
    );
  }
}

class Data extends DataEntity {
  Data({super.code, super.description, super.data});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
    if (json['object'] != null) {
      data = [];
      data!.add(CarModel.fromJson(json['object'][0]));
      data![0].iconLink = json['object'][1]['icon_link'];
    }
  }
}
