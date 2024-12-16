

import 'dart:convert';

import 'package:rahnegar/features/auth/domain/entity/user_entity.dart';

class UserDataModel extends UserDataEntity{

  UserDataModel(
  {
  super.id,
    super.firstName,
  super.lastName,
    super.city,
    super.state
  });
  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json['id'],
      firstName: json['first_name']??'',
      lastName: json['last_name']??'',
      city: json['city']??'',
      state: json['state']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'city': city,
      'state': state,
    };
  }
  String toJsonString() {
    return jsonEncode(toJson());
  }
}