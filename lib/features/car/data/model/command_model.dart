import 'package:rahnegar/common/model/error_model.dart';
import 'package:rahnegar/features/car/domain/entity/command_entity.dart';

class CommandModel extends CommandEntity{
  const CommandModel({
    super.errorEntity,
    super.dataEntity,
  });
  factory CommandModel.fromJson(Map<String, dynamic> json) {
    final List<Command> dataList = [];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        dataList.add(Command.fromJson(v));
      });
    }
    return CommandModel(
      dataEntity: dataList,
      errorEntity: ErrorModel.fromJson(json['error']),
    );
  }
}

class Command extends DataEntity {
  Command(
      {
        super.name,
        super.content,
        super.icon,
        super.blocked,
        super.contentFa,
        super.state
      });

  factory Command.fromJson(Map<String, dynamic> json) {
    return Command(
        name: json['name'],
        content: json['content'],
        icon: json['icon'],
        contentFa: json['content_fa'],
        state: json['state']??false,
        blocked: json['blocked']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['content'] = content;
    data['icon'] = icon;
    data['blocked'] = blocked;
    data['content_fa'] = contentFa;
    data['state'] = state;
    return data;
  }
}
