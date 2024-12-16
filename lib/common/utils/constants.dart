const double textButtonBorderRadius = 10;
const double customButtonBorderRadius = 10;
String baseUrl = "http://85.198.13.96:8000/api/v1/";
String webSocketUrl = 'ws://85.198.13.96:8001/ws/android/';
enum Commands{
  doorVehicleStatus,
  closeVehicleDoor,
  allowTurnOn,
  turnOffVehicle,
  lockTurnOnVehicle,
}
enum Values{
  none,
  open_door_vehicle,
  close_door_vehicle,
  allow_turn_on,
  not_allow_turn_on,
  turn_off_vehicle,

}
Map<Commands, Values> commandStatus = {
  Commands.doorVehicleStatus: Values.none,
  Commands.allowTurnOn: Values.none,
  Commands.lockTurnOnVehicle: Values.none,
};