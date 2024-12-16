import 'package:get/get.dart';
import 'package:rahnegar/features/setting/data/datasources/locale_data_source/setting_local_data_source.dart';
import 'package:rahnegar/features/setting/data/datasources/locale_data_source/setting_local_data_source_impl.dart';
import 'package:rahnegar/features/setting/data/repository/setting_repository_impl.dart';
import 'package:rahnegar/features/setting/domain/repository/setting_repository.dart';
import 'package:rahnegar/features/setting/domain/usecase/get_locale_usecase.dart';
import 'package:rahnegar/features/setting/domain/usecase/get_theme_mode_usecase.dart';
import 'package:rahnegar/features/setting/domain/usecase/save_locale_usecase.dart';
import 'package:rahnegar/features/setting/domain/usecase/save_theme_mode_usecase.dart';
import 'package:rahnegar/features/setting/presentation/manager/getx/pages/setting_page/controller/setting_controller.dart';

class SettingPageBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<SettingLocalDataSource>(()=>SettingLocalDataSourceImpl());
    Get.lazyPut<SettingRepository>(()=>SettingRepositoryImpl(localDataSource: Get.find<SettingLocalDataSource>()));
    Get.lazyPut<GetLocaleUseCase>(()=>GetLocaleUseCase(repository: Get.find<SettingRepository>()));
    Get.lazyPut<SaveLocaleUseCase>(()=>SaveLocaleUseCase(repository: Get.find<SettingRepository>()));
    Get.lazyPut<GetThemeModeUseCase>(()=>GetThemeModeUseCase(repository: Get.find<SettingRepository>()));
    Get.lazyPut<SaveThemeModeUseCase>(()=>SaveThemeModeUseCase(repository: Get.find<SettingRepository>()));
    Get.lazyPut<SettingController>(()=>SettingController());
  }

}