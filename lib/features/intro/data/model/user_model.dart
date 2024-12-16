



import 'package:rahnegar/features/intro/data/model/user_data_model.dart';
import 'package:rahnegar/features/intro/domain/entity/user_entity.dart';

import '../../../../common/model/error_model.dart';

class UserModel extends UserEntity{
  UserModel({
    super.data,
    super.error
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      data: UserDataModel.fromJson(json['data']),
      error: ErrorModel.fromJson(json['error']),
    );
  }
}