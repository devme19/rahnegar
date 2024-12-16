import 'package:get/get.dart';
import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/failure_action.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/user/domain/entity/user_entity.dart';
import 'package:rahnegar/features/user/domain/usecase/get_user_info_usecase.dart';
import 'package:rahnegar/features/user/domain/usecase/update_user_info_usecase.dart';
import 'package:rahnegar/routes/app_routes.dart';

import '../../../../../../../../routes/route_names.dart';

class UserInfoPageController extends GetxController{

  UpdateUserInfoUseCase _updateUserInfoUseCase = Get.find();
  final GetUserInfoUseCase _getUserInfoUseCase = Get.find();


  updateUserInfo(Map<String,dynamic> body,Function onDone){
    _updateUserInfoUseCase = Get.find();
    _updateUserInfoUseCase.call(Params(body: body)).then((response){
      if(response.isRight){

        onDone();
      }else if(response.isLeft){
        failureDialog(response.left,Get.context);
      }
    });
  }

  getUserInfo({required Function(UserEntity) onDataReceived}){
    _getUserInfoUseCase.call(NoParams()).then((response){
      if(response.isRight){
        onDataReceived(response.right);
      }else if(response.isLeft){
        failureDialog(response.left, Get.context);
      }
    });
  }
}