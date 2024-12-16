import 'package:equatable/equatable.dart';

class UpdateDataEntity extends Equatable{
  final int? code;
  final String? description;
  final ObjectEntity? object;

  const UpdateDataEntity({this.code, this.description, this.object});

  @override
  // TODO: implement props
  List<Object?> get props => [code,description,object];
}

class ObjectEntity extends Equatable{
  final int? id;
  final String? userName;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? state;
  final String? city;
  final String? address;

  const ObjectEntity({this.id, this.userName, this.firstName, this.lastName,
    this.phone, this.state, this.city, this.address});

  @override
  // TODO: implement props
  List<Object?> get props => [id,userName,firstName,lastName,phone,state,city,address];


}