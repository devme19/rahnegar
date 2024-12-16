


import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rahnegar/features/setting/presentation/manager/getx/pages/setting_page/bindings/setting_page_binding.dart';
import 'package:rahnegar/features/setting/presentation/manager/getx/pages/setting_page/controller/setting_controller.dart';

import '../common/base_data_sources/base_local_data_source.dart';
import '../common/base_data_sources/base_remote_data_source.dart';
import '../common/client/interceptors/refresh_token_interceptors.dart';

class MainBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<BaseRemoteDataSource>(BaseRemoteDataSourceImpl(),permanent: true);
    Get.put<BaseLocalDataSource>(BaseLocalDataSourceImpl(),permanent: true);
    Get.put<GetStorage>(GetStorage());
    Get.lazyPut<RefreshTokenInterceptor>(()=>RefreshTokenInterceptor(baseLocalDataSource: Get.find<BaseLocalDataSource>()));

    SettingPageBinding().dependencies();

  }

}