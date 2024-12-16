import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/setting/domain/usecase/get_locale_usecase.dart';
import 'package:rahnegar/features/setting/domain/usecase/get_theme_mode_usecase.dart';
import 'package:rahnegar/features/setting/domain/usecase/save_theme_mode_usecase.dart';
import 'package:rahnegar/theme/app_themes.dart';

class ThemeCubit extends Cubit<ThemeState>{

  late SaveThemeModeUseCase saveThemeModeUseCase;
  late GetThemeModeUseCase getThemeModeUseCase;
  late GetLocaleUseCase getLocaleUseCase;
  ThemeCubit({required this.saveThemeModeUseCase,required this.getThemeModeUseCase,required this.getLocaleUseCase}):super(ThemeState(themeData: AppThemes.light("fa"), themeMode: ThemeMode.light)){
    _loadInitialTheme();
  }
  void _loadInitialTheme() async {
    final response = await getThemeModeUseCase.call(NoParams());
    String languageCode ="fa";
    final res = await getLocaleUseCase.call(NoParams());
    res.fold(
            (ifLeft)=>null,
            (ifRight)=>languageCode = ifRight);
    String savedMode = 'system';
    response.fold(
            (ifLeft)=>null,
        (ifRight)=>savedMode = ifRight);
    // Convert the saved theme mode to a string and determine the appropriate theme state
    final themeState = _getThemeState(savedMode,languageCode); // Default to 'system' if null
    emit(themeState);
  }
  void changeTheme({required String mode,required String languageCode}) {
    final newThemeState = _getThemeState(mode,languageCode);
    emit(newThemeState);
    saveThemeModeUseCase.call(Params(stringValue: mode));
  }

  ThemeState _getThemeState(String mode,String languageCode) {
    switch (mode) {
      case 'dark':
        return ThemeState(themeData: AppThemes.dark(languageCode), themeMode: ThemeMode.dark);
      case 'light':
        return ThemeState(themeData: AppThemes.light(languageCode), themeMode: ThemeMode.light);
      default:
        return ThemeState(themeData: AppThemes.light(languageCode), themeMode: ThemeMode.system);
    }
  }
}

class ThemeState {
  final ThemeData themeData;
  final ThemeMode themeMode;

  ThemeState({required this.themeData, required this.themeMode});
}