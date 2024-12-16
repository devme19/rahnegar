import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:rahnegar/features/auth/data/model/user_data_model.dart';
import 'package:rahnegar/features/intro/data/model/user_model.dart';

import '../client/exception.dart';

abstract class BaseLocalDataSource{
  String getToken();
  String getRefreshToken();
  bool saveRefreshToken(String refreshToken);
  bool saveToken(String token);

  String getFcmToken();
  bool saveFcmToken(String fcmToken);

  bool saveUserInfo(String usrInfo);
  UserDataModel getUserInfo();
}
class BaseLocalDataSourceImpl implements BaseLocalDataSource{
  GetStorage box = GetStorage();
  String tokenKey = "tokenKey";
  String refreshTokenKey = "refreshTokenKey";
  String fcmTokenKey = "fcmTokenKey";
  String userKey = "userKey";

  @override
  String getRefreshToken() {
    try {
      return box.read(refreshTokenKey);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  String getToken() {
    try {
      return box.read(tokenKey);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  bool saveRefreshToken(String refreshToken) {
    try {
      box.write(refreshTokenKey, refreshToken);
      return true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  bool saveToken(String token) {
    try {
      box.write(tokenKey, token);

      return true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  String getFcmToken() {
    try {
      return box.read(fcmTokenKey);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  bool saveFcmToken(String fcmToken) {
    try {
      box.write(fcmTokenKey, fcmToken);
      return true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  UserDataModel getUserInfo() {
    try{
      String userStr = box.read(userKey);
      if(userStr.isNotEmpty){
        return UserDataModel.fromJson(jsonDecode(userStr));
      }
      return UserDataModel();
    }catch(e){
      throw CacheException(message: e.toString());
    }
  }

  @override
  bool saveUserInfo(String usrInfo) {
    try{
      box.write(userKey, usrInfo);
      return true;
    }catch(e){
      throw CacheException(message: e.toString());
    }
  }

}