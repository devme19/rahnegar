import 'package:equatable/equatable.dart';

class CommandResponseEntity extends Equatable{
  String? message;
  String? taskId;

  CommandResponseEntity({this.message,this.taskId});
  @override
  // TODO: implement props
  List<Object?> get props => [message,taskId];

}