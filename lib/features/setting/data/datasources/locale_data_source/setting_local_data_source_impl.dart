

import 'package:get_storage/get_storage.dart';
import 'package:rahnegar/features/setting/data/datasources/locale_data_source/setting_local_data_source.dart';

import '../../../../../common/client/exception.dart';

class SettingLocalDataSourceImpl implements SettingLocalDataSource{

  GetStorage box = GetStorage();
  final String localeKey = "localeKey";
  final String themeKey = "themeKey";
  @override
  String getLocale() {
    try{
      String locale = box.read(localeKey);
      return locale;
    } catch (e){
      throw CacheException(message: e.toString());
    }
  }

  @override
  bool saveLocale(String locale) {
    try {
      box.write(localeKey, locale);
      return true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  String getThemeMode() {
    try{
      String mode = box.read(themeKey);
      return mode;
    } catch (e){
      throw CacheException(message: e.toString());
    }
  }

  @override
  bool saveThemeMode(String mode) {
    try {
      box.write(themeKey, mode);
      return true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }



}