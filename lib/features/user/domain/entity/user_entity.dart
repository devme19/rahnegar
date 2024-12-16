import 'package:equatable/equatable.dart';

import '../../../../common/entity/error_entity.dart';

class UserEntity extends Equatable{
  UserDataEntity? data;
  ErrorEntity? error;
  UserEntity({this.data,this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [data,error];
}

class UserDataEntity extends Equatable{
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? city;
  final String? state;

  const UserDataEntity({this.id,this.firstName, this.lastName, this.city, this.state});

  @override
  // TODO: implement props
  List<Object?> get props => [id,firstName,lastName,city,state];
}