import 'package:get/get.dart';
import 'package:rahnegar/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:rahnegar/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:rahnegar/features/auth/data/repository/auth_repository_impl.dart';
import 'package:rahnegar/features/auth/domain/repository/auth_repository.dart';
import 'package:rahnegar/features/auth/domain/usecase/get_otp_code_usecase.dart';
import 'package:rahnegar/features/auth/domain/usecase/get_user_info_usecase.dart';
import 'package:rahnegar/features/auth/domain/usecase/otp_verification_usecase.dart';
import '../controller/otp_page_controller.dart';

class OtpPageBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(()=>AuthRemoteDatasource());
    Get.lazyPut(()=>AuthLocalDatasource());
    Get.lazyPut<AuthRepository>(()=>AuthRepositoryImpl(remoteDatasource: Get.find<AuthRemoteDatasource>(),localDatasource: Get.find<AuthLocalDatasource>()));
    Get.lazyPut<GetOtpCodeUseCase>(()=>GetOtpCodeUseCase(repository: Get.find<AuthRepository>()));
    Get.lazyPut<OtpVerificationUseCase>(()=>OtpVerificationUseCase(repository: Get.find<AuthRepository>()));
    Get.lazyPut<GetUserInfoUseCase>(()=>GetUserInfoUseCase(repository: Get.find<AuthRepository>()));
    Get.lazyPut(()=>OtpPageController());

  }

}