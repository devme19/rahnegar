import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/setting/domain/usecase/get_locale_usecase.dart';
import 'package:rahnegar/features/setting/domain/usecase/save_locale_usecase.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  final SaveLocaleUseCase saveLocaleUseCase;
  final GetLocaleUseCase getLocaleUseCase;

  LocaleCubit({required this.saveLocaleUseCase, required this.getLocaleUseCase})
      : super(LocaleState(locale: const Locale('fa', 'IR'))) {
    _loadInitialTheme();
  }

  void _loadInitialTheme() async {
    final response = await getLocaleUseCase.call(NoParams());
    String languageCode = 'fa';
    String countryCode = 'IR';
    response.fold((ifLeft) => null, (ifRight) {
      if(ifRight == 'en'){
        languageCode = 'en';
        countryCode = 'US';
      }
    });
   changeLocale(languageCode: languageCode, countryCode: countryCode);
  }

  void changeLocale(
      {required String languageCode, required String countryCode}) {
    var locale = Locale(languageCode, countryCode);
    emit(LocaleState(locale: locale)); // Update state
    saveLocaleUseCase.call(Params(stringValue: languageCode)); // Save locale
  }
}
