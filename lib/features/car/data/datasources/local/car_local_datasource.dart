import 'package:rahnegar/features/auth/data/model/user_data_model.dart';

abstract class CarLocalDatasource{
  bool saveDefaultCar(String car);
  String loadDefaultCar();
  String getFcmToken();
  UserDataModel getUserInfo();
}
