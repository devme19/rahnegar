import 'package:get/get.dart';
import 'package:rahnegar/features/user/domain/usecase/get_user_info_usecase.dart';


import '../../../../../../data/datasources/remote/user_remote_datasource.dart';
import '../../../../../../data/repository/user_repository_impl.dart';
import '../../../../../../domain/repository/user_repository.dart';
import '../../../../../../domain/usecase/update_user_info_usecase.dart';
import '../controller/user_info_page_controller.dart';

class UserInfoPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>UserRemoteDatasource());
    // Get.lazyPut<UserRepository>(()=>UserRepositoryImpl(remoteDatasource: Get.find<UserRemoteDatasource>()));
    Get.lazyPut<UpdateUserInfoUseCase>(()=>UpdateUserInfoUseCase(repository: Get.find<UserRepository>()));
    Get.lazyPut<GetUserInfoUseCase>(()=>GetUserInfoUseCase(repository: Get.find<UserRepository>()));
    Get.lazyPut(()=>UserInfoPageController());
  }

}