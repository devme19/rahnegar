import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/constants.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/car/data/model/my_cars_model.dart';
import 'package:rahnegar/features/car/domain/entity/brand_entity.dart';
import 'package:rahnegar/features/car/domain/entity/command_entity.dart' as cmd;
import 'package:rahnegar/features/car/domain/entity/mileage_entity.dart';
import 'package:rahnegar/features/car/domain/entity/my_cars_entity.dart';
import 'package:rahnegar/features/car/domain/usecase/add_car_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/delete_car_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/get_battery_status_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/get_brands_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/get_commands_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/get_fcm_token_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/get_mileage_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/get_my_cars_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/load_default_car_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/save_default_car_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/send_command_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/send_fcm_token_usecase.dart';
import 'package:rahnegar/features/car/domain/usecase/update_car_usecase.dart';
import 'package:rahnegar/features/car/presentation/widgets/chart_widget.dart';
import 'package:rahnegar/generated/l10n.dart';

part 'car_event.dart';
part 'car_state.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final AddCarUseCase? addCarUseCase;
  final GetMyCarsUseCase? getMyCarsUseCase;
  final DeleteCarUseCase? deleteCarUseCase;
  final SaveDefaultCarUseCase? saveDefaultCarUseCase;
  final LoadDefaultCarUseCase? loadDefaultCarUseCase;
  final SendFcmTokenUseCase? sendFcmTokenUseCase;
  final GetFcmTokenUseCase? getFcmTokenUseCase;
  final UpdateCarUseCase? updateCarUseCase;
  final SendCommandUseCase? sendCommandUseCase;
  final GetBatteryStatusUseCase? getBatteryStatusUseCase;
  final GetMileageUseCase? getMileageUseCase;
  final GetCommandsUseCase? getCommandsUseCase;
  List<CarEntity> myCars = [];
  List<cmd.DataEntity> commands = [];

  CarBloc(
      {this.addCarUseCase,
      this.getMyCarsUseCase,
      this.deleteCarUseCase,
      this.saveDefaultCarUseCase,
      this.loadDefaultCarUseCase,
      this.sendFcmTokenUseCase,
      this.getFcmTokenUseCase,
      this.updateCarUseCase,
      this.sendCommandUseCase,
      this.getBatteryStatusUseCase,
      this.getMileageUseCase,
      this.getCommandsUseCase})
      : super(CarInitial()) {
    on<LoadMyCarsEvent>(_onLoadMyCars);
    on<AddCarEvent>(_onAddCar);
    on<DeleteCarEvent>(_onDeleteCar);
    on<LoadDefaultCarEvent>(_onLoadDefaultCar);
    on<SaveDefaultCarEvent>(_onSaveDefaultCar);
    on<UpdateCarEvent>(_onUpdateCar);
    on<SendCommandEvent>(_onSendCommand);
    on<GetBatteryStatusEvent>(_onGetBatteryStatus);
    on<GetMileageEvent>(_onGetMileage);
    on<GetCommandsEvent>(_getCommands);
  }

  _getCommands(GetCommandsEvent event, Emitter emit) async {
    Map<String, dynamic> queryParameters = {
      "serial_number": event.serialNumber,
    };
    emit(GetCommandsLoading());
    final response =
        await getCommandsUseCase!.call(Params(body: queryParameters));
    response.fold(
      (failure) => emit(GetCommandsFailure(failure: failure)),
      (command) {
        commands = command.dataEntity!;
        emit(CommandUpdated(commands: commands));
      },
    );
  }

  _onGetMileage(GetMileageEvent event, Emitter<CarState> emit) async {
    // emit(GetMileageStatusLoading());
    Map<String, dynamic> body = {
      "id": event.id,
    };
    final response = await getMileageUseCase!.call(Params(body: body));
    response.fold(
      (failure) => emit(GetMileageStatusError(failure: failure)),
      (mileageEntity) {
        emit(GetMileageStatusLoaded(mileageEntity: mileageEntity));
      },
    );
  }

  _onGetBatteryStatus(
      GetBatteryStatusEvent event, Emitter<CarState> emit) async {
    emit(GetBatteryStatusLoading());
    await Future.delayed(const Duration(seconds: 1));
    List<PercentData> data = [];
    data.clear();
    data.add(
        PercentData(89, DateTime.parse("2024-10-03 06:48:24.713543+00:00")));
    data.add(
        PercentData(70, DateTime.parse("2024-10-03 08:30:24.713543+00:00")));
    data.add(
        PercentData(65, DateTime.parse("2024-10-03 09:10:24.713543+00:00")));
    data.add(
        PercentData(50, DateTime.parse("2024-10-03 10:13:24.713543+00:00")));
    data.add(
        PercentData(40, DateTime.parse("2024-10-04 10:48:24.713543+00:00")));
    data.add(
        PercentData(35, DateTime.parse("2024-10-05 12:07:24.713543+00:00")));
    data.add(
        PercentData(10, DateTime.parse("2024-10-06 13:47:24.713543+00:00")));
    data.add(
        PercentData(25, DateTime.parse("2024-10-07 15:48:24.713543+00:00")));
    data.add(
        PercentData(33, DateTime.parse("2024-10-08 16:10:24.713543+00:00")));
    emit(GetBatteryStatusLoaded(percentData: data));
    // Map<String,dynamic> body={"type":"get_battery_status", "device_sn" : event.serialNumber};
    // final response = await getBatteryStatusUseCase!.call(Params(body: body));
    // response.fold(
    //       (failure) => emit(CarError(failure: failure)),
    //       (response) {
    //         print(response);
    //
    //     // emit(GetBatteryStatusLoaded());
    //   },
    // );
  }

  _onSendCommand(SendCommandEvent event, Emitter<CarState> emit) async {
    emit(CommandInProgress());
    Map<String, dynamic> body = {
      "type": "command",
      "device_sn": event.serialNumber,
      "command": event.command.name,
      "state": !event.command.state
    };
    final response = await sendCommandUseCase!.call(Params(body: body));
    response.fold(
      (failure) => emit(CarError(failure: failure)),
      (response) {
        int index = commands.indexWhere((c) => c == event.command);
        commands[index].state = !commands[index].state;
        emit(CommandUpdated(
            title: event.command.contentFa!, commands: commands));
      },
    );
    // commandStatus[event.commandTitle] = event.value;
  }

  Future<void> _onLoadMyCars(
      LoadMyCarsEvent event, Emitter<CarState> emit) async {
    emit(CarLoading());
    final response = await getMyCarsUseCase!.call(NoParams());
    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          if (failure.errorCode != null) {
            if (failure.errorCode == 404) {
              myCars.clear();
              add(LoadDefaultCarEvent(isBottomSheet: event.isBottomSheet));
            }
          }
        } else {
          emit(CarError(failure: failure));
        }
      },
      (myCarsEntity) {
        myCars.clear();
        myCars.addAll(myCarsEntity.data!);
        add(LoadDefaultCarEvent(isBottomSheet: event.isBottomSheet));
      },
    );
  }

  Future<void> _onAddCar(AddCarEvent event, Emitter<CarState> emit) async {
    final response =
        await addCarUseCase!.call(Params(body: event.car.toJson()));
    response.fold(
      (failure) => emit(CarError(failure: failure)),
      (addCarResponseEntity) {
        String fcmToken = '';
        getFcmTokenUseCase!.call(NoParams()).then((response) {
          if (response.isRight) {
            fcmToken = response.right;
            Map<String, dynamic> body = {
              "device": event.car.serialNumber,
              "device_token": fcmToken
            };
            sendFcmTokenUseCase!.call(Params(body: body)).then((response) {
              if (response.isRight) {
                print("Fcm token sent for ${event.car.serialNumber}");
              }
            });
          }
        });
        // List<CarEntity> list=[];
        // list.addAll(myCars);
        // myCars.clear();
        // myCars.addAll(list);
        // myCars.addAll(addCarResponseEntity.dataEntity!.data!);
        emit(CarAdded());
      },
    );
  }

  Future<void> _onDeleteCar(
      DeleteCarEvent event, Emitter<CarState> emit) async {
    final response =
        await deleteCarUseCase!.call(Params(body: {"id": event.car.id}));
    response.fold(
      (failure) => emit(CarError(failure: failure)),
      (boolResponse) {
        if (boolResponse) {
          final updatedCars = List<CarEntity>.from(myCars)
            ..removeWhere((car) => car.id == event.car.id);

          // Update the local list to maintain consistency with the emitted state
          myCars = updatedCars;
          emit(CarUpdated(cars: updatedCars)); // Create a new list
        }
      },
    );
  }

  _onUpdateCar(UpdateCarEvent event, Emitter<CarState> emit) async {
    updateCarUseCase!.call(Params(body: event.car.toJson())).then((response) {
      if (response.isRight) {
        String fcmToken = '';
        getFcmTokenUseCase!.call(NoParams()).then((response) {
          if (response.isRight) {
            fcmToken = response.right;
            Map<String, dynamic> body = {
              "device": event.car.serialNumber,
              "device_token": fcmToken
            };
            sendFcmTokenUseCase!.call(Params(body: body)).then((response) {
              if (response.isRight) {
                print(response.right);
              }
            });
          }
        });
        add(LoadMyCarsEvent());
      } else if (response.isLeft) {
        emit(CarError(failure: response.left));
      }
    });
  }

  Future<void> _onLoadDefaultCar(
      LoadDefaultCarEvent event, Emitter<CarState> emit) async {
    emit(DefaultCarLoading());
    final response = await loadDefaultCarUseCase!.call(NoParams());
    response.fold(
      (failure) => emit(CarError(failure: failure)),
      (carJson) {
        if (carJson.isNotEmpty) {
          final defaultCar = CarModel.fromJson(jsonDecode(carJson));
          final index = myCars.indexWhere((item) => item.id == defaultCar.id);
          if (index != -1 && index != 0) {
            final carToMove = myCars[index];
            myCars.removeAt(index);
            myCars.insert(0, carToMove);
          }
        }
        if (myCars.isNotEmpty) {
          if (myCars.first.serialNumber != null) {
            add(GetCommandsEvent(serialNumber: myCars.first.serialNumber!));
          }
        }
        emit(CarUpdated(cars: myCars, isBottomSheet: event.isBottomSheet));
        // emit(DefaultCarSuccess(carEntity: defaultCar));
      },
    );
  }

  Future<void> _onSaveDefaultCar(
      SaveDefaultCarEvent event, Emitter<CarState> emit) async {
    final jsonString = jsonEncode(event.car.toJson());
    final response =
        await saveDefaultCarUseCase!.call(Params(stringValue: jsonString));
    response.fold(
      (failure) => emit(CarError(failure: failure)),
      (_) {
        emit(DefaultCarSavedSuccess(carEntity: event.car));
      },
    );
  }
}
