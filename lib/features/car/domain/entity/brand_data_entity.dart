import 'package:equatable/equatable.dart';

class BrandDataEntity extends Equatable{
  int? id;
  String? nameEng;
  String? nameFa;
  int? parentId;

  BrandDataEntity({this.id,this.nameEng=' ',this.nameFa= ' ',this.parentId});
  @override
  // TODO: implement props
  List<Object?> get props => [id,nameEng,nameFa,parentId];
}