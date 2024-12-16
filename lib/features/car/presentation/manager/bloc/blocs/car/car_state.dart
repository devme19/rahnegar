part of 'car_bloc.dart';

abstract class CarState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CarInitial extends CarState {}

class CarLoading extends CarState {}

class CarLoaded extends CarState {
  late final List<CarEntity> cars;
  @override
  List<Object?> get props => [cars];
}

class CarError extends CarState {
  final Failure failure;

  CarError({required this.failure});

  @override
  List<Object?> get props => [failure];
}

class CarUpdated extends CarState {
  final List<CarEntity> cars;
  final bool isBottomSheet;
  CarUpdated({required this.cars,this.isBottomSheet=false});

  @override
  List<Object?> get props => [cars,isBottomSheet];
}

class CarSaved extends CarState {}
class CarAdded extends CarState {}
class CarDeleted extends CarState {}
class DefaultCarFailure extends CarState{}
class DefaultCarLoading extends CarState{}
class DefaultCarSavedSuccess extends CarState{
  final CarEntity carEntity;
  DefaultCarSavedSuccess({required this.carEntity});
}
class CommandInProgress extends CarState{}

class GetBatteryStatusLoading extends CarState{}
class GetBatteryStatusLoaded extends CarState{
  final List<PercentData> percentData;
  GetBatteryStatusLoaded({required this.percentData});
}
class GetMileageStatusLoading extends CarState{}
class GetMileageStatusLoaded extends CarState{
  final MileageEntity mileageEntity;
  GetMileageStatusLoaded({required this.mileageEntity});
}
class GetMileageStatusError extends CarState{
  final Failure failure;

  GetMileageStatusError({required this.failure});
}
class GetCommandsLoading extends CarState{
}
class GetCommandsFailure extends CarState{
  final Failure failure;

  GetCommandsFailure({required this.failure});
}
class CommandUpdated extends CarState{
  final List<cmd.DataEntity> commands;
  final String title;
  CommandUpdated({required this.commands,this.title=""});
}
