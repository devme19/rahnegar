import 'package:get/get.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/intro/domain/usecase/is_authorized_usecase.dart';
import 'package:rahnegar/routes/app_routes.dart';

import '../../../../../../../../routes/route_names.dart';

class SplashPageController extends GetxController{

  late IsAuthorizedUseCase isAuthorizedUseCase;
  isAuthorized(){
    isAuthorizedUseCase = Get.find();
    isAuthorizedUseCase.call(NoParams()).then((response){

      Future.delayed(const Duration(seconds: 2)).then((onValue){
        if(response.isRight){
          Get.offAllNamed(RouteNames.mainPage);
        }else if(response.isLeft){
          Get.offAllNamed(RouteNames.otpPage);
        }
      });
    });
  }

}