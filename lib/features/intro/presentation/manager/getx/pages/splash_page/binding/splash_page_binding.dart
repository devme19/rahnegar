import 'package:get/get.dart';
import 'package:rahnegar/features/intro/data/datasources/local/intro_local_datasource.dart';
import 'package:rahnegar/features/intro/data/datasources/remote/intro_remote_datasource.dart';
import 'package:rahnegar/features/intro/data/repository/intro_repository_impl.dart';
import 'package:rahnegar/features/intro/domain/repository/intro_repository.dart';
import 'package:rahnegar/features/intro/domain/usecase/is_authorized_usecase.dart';

import '../controller/splash_page_controller.dart';

class SplashPageBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(()=>IntroLocalDatasource());
    Get.lazyPut(()=>IntroRemoteDatasource());
    Get.lazyPut<IntroRepository>(()=>IntroRepositoryImpl(localDatasource: Get.find<IntroLocalDatasource>(),remoteDatasource: Get.find<IntroRemoteDatasource>()));
    Get.lazyPut<IsAuthorizedUseCase>(()=>IsAuthorizedUseCase(repository: Get.find<IntroRepository>()));
    Get.lazyPut(()=>SplashPageController());
  }

}