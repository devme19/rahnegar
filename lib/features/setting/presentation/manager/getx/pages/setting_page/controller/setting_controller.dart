import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/setting/domain/usecase/get_locale_usecase.dart';
import 'package:rahnegar/features/setting/domain/usecase/get_theme_mode_usecase.dart';
import 'package:rahnegar/features/setting/domain/usecase/save_locale_usecase.dart';
import 'package:rahnegar/features/setting/domain/usecase/save_theme_mode_usecase.dart';

import '../../../../../../../../theme/app_themes.dart';

class SettingController extends GetxController{

  var selectedLocale = const Locale('fa', 'IR').obs;
  RxBool isDarkMode = false.obs;
  Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  SaveLocaleUseCase saveLocaleUseCase = Get.find();
  SaveThemeModeUseCase saveThemeModeUseCase = Get.find();
  GetLocaleUseCase getLocaleUseCase = Get.find();
  GetThemeModeUseCase getThemeModeUseCase = Get.find();



  @override
  void onInit() {
    super.onInit();
    getLocale();
    getTheme();
  }

  changeLocale({required String languageCode, required String countryCode}){
    var locale = Locale(languageCode, countryCode);
    selectedLocale.value = locale;
    Get.updateLocale(selectedLocale.value);
    saveLocaleUseCase.call(Params(stringValue: languageCode));
  }

  changeTheme({required String mode}){
    themeMode.value = theme(mode);
    saveThemeModeUseCase.call(Params(stringValue: mode));
  }

  getLocale()async{
    getLocaleUseCase.call(NoParams()).then((response){
      if(response.isRight){
        String languageCode =response.right;
        if (languageCode == 'fa'){
          selectedLocale.value = const Locale('fa', 'IR');
        }else{
          selectedLocale.value = const Locale('en', 'US');
        }
      }
    });
  }

  getTheme()async{
    getThemeModeUseCase.call(NoParams()).then((response){
      if(response.isRight) {
        String mode = response.right;
        themeMode.value = theme(mode);
      }
    });
  }

  ThemeMode theme(String mode){
    switch (mode){
      case "light":
        return ThemeMode.light;
      case "dark":
        return ThemeMode.dark;
      case "system":
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }


}