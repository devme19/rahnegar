import 'package:rahnegar/features/user/domain/entity/user_entity.dart';

class UserDataModel extends UserDataEntity{

  UserDataModel(
  {super.id,
    super.firstName,
  super.lastName,
    super.city,
    super.state
  });
  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json['id']??'',
      firstName: json['first_name']??'',
      lastName: json['last_name']??'',
      city: json['city']??'',
      state: json['state']??'',
    );
  }
}