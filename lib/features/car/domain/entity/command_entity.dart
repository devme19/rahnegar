import 'package:equatable/equatable.dart';
import 'package:rahnegar/common/entity/error_entity.dart';

class CommandEntity extends Equatable{
  final ErrorEntity? errorEntity;
  final List<DataEntity>? dataEntity;

  const CommandEntity({this.errorEntity, this.dataEntity});

  @override
  // TODO: implement props
  List<Object?> get props => [errorEntity,dataEntity];
}
class DataEntity extends Equatable{
  final String? name;
  final String? content;
  final String? icon;
  final bool? blocked;
  bool state;
  final String? contentFa;

  DataEntity({this.name,this.content,this.icon,this.blocked,this.state=false,this.contentFa});

  @override
  // TODO: implement props
  List<Object?> get props => [name,content,icon,blocked,state,contentFa];
}