import 'package:rahnegar/features/user/domain/entity/update_data_entity.dart';
import 'package:rahnegar/features/user/domain/entity/update_user_entity.dart';
import 'package:rahnegar/features/user/domain/entity/user_entity.dart';

import '../../../../common/model/data_model.dart';
import '../../../../common/model/error_model.dart';

class UpdateUserModel extends UpdateUserEntity {
  UpdateUserModel({
    ErrorModel? error,
    UserDataModel? data,
  }) : super(
          error: error!,
          data: data!,
        );

  factory UpdateUserModel.fromJson(Map<String, dynamic> json) {
    return UpdateUserModel(
      error: ErrorModel.fromJson(json['error']),
      data: UserDataModel.fromJson(json['data']),
    );
  }
}

class UserDataModel extends UpdateDataEntity {
  const UserDataModel({super.code, super.description, super.object});
  factory UserDataModel.fromJson(Map<String,dynamic> json){
    return UserDataModel(
      code: json['code'],
      description: json['description'],
      object: ObjectDataModel.fromJson(json['object'])
    );
  }


}
class ObjectDataModel extends ObjectEntity{
  const ObjectDataModel({super.id,super.firstName,super.lastName,super.userName,super.address,super.city,super.phone,super.state});
  factory ObjectDataModel.fromJson(Map<String,dynamic> json){
    return ObjectDataModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      userName: json['username'],
      address: json['address'],
      phone: json['phone'],
      state: json['state'],
      city: json['city'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'username': userName,
      'address': address,
      'phone': phone,
      'state': state,
      'city': city,
    };
  }
}
