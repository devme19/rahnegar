import 'package:rahnegar/features/car/domain/entity/command_response_entity.dart';

class CommandResponseModel extends CommandResponseEntity{


  CommandResponseModel({super.message, super.taskId});

  factory CommandResponseModel.fromJson(Map<String, dynamic> json) {
    return CommandResponseModel(
        message: json['message'],
        taskId :json['task_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['task_id'] = taskId;
    return data;
  }
}