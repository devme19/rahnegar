part of 'car_bloc.dart';

abstract class CarEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadMyCarsEvent extends CarEvent {
  final bool isBottomSheet;
  LoadMyCarsEvent({this.isBottomSheet = false});
}

class AddCarEvent extends CarEvent {
  final CarModel car;

  AddCarEvent({required this.car});

  @override
  List<Object> get props => [car];
}

class DeleteCarEvent extends CarEvent {
  final CarEntity car;

  DeleteCarEvent(this.car);

  @override
  List<Object> get props => [car];
}

class UpdateCarEvent extends CarEvent {
  final CarModel car;

  UpdateCarEvent({required this.car});

  @override
  List<Object> get props => [car];
}

class LoadDefaultCarEvent extends CarEvent {
  bool isBottomSheet;

  LoadDefaultCarEvent({this.isBottomSheet=false});
}

class SaveDefaultCarEvent extends CarEvent {
  final CarModel car;

  SaveDefaultCarEvent(this.car);

  @override
  List<Object> get props => [car];
}

class GetBrandsEvent extends CarEvent{
  final String id;
  GetBrandsEvent({required this.id});
}

class SendCommandEvent extends CarEvent{
  final String serialNumber;
  cmd.DataEntity command;
  SendCommandEvent({required this.serialNumber,required this.command});
}

class GetBatteryStatusEvent extends CarEvent{
  final String serialNumber;

  GetBatteryStatusEvent({required this.serialNumber});
}
class GetMileageEvent extends CarEvent{
  final String  id;
  GetMileageEvent({required this.id});
}

class GetCommandsEvent extends CarEvent{
  final String serialNumber;

  GetCommandsEvent({required this.serialNumber});
}



