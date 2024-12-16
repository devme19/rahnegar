import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/failure_action.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/auth/domain/usecase/get_otp_code_usecase.dart';
import 'package:rahnegar/features/auth/domain/usecase/otp_verification_usecase.dart';
import 'package:rahnegar/features/auth/domain/usecase/get_user_info_usecase.dart';
import 'package:rahnegar/routes/app_routes.dart';

import '../../../../../../../../routes/route_names.dart';

class OtpPageController extends GetxController{


 late GetOtpCodeUseCase _getOtpCodeUseCase;
 late OtpVerificationUseCase _otpVerificationUseCase;
 late GetUserInfoUseCase _getUserInfoUseCase;
 final getOtpCodeStatus = RxStatus.empty().obs;
 getOtpCode(String phoneNumber){
   _getOtpCodeUseCase = Get.find();
   getOtpCodeStatus.value = RxStatus.loading();
   Map<String,dynamic> body={
     "phone":phoneNumber
   };
   _getOtpCodeUseCase.call(Params(body: body)).then((response){
    if(response.isRight){
      getOtpCodeStatus.value = RxStatus.success();
    }else if(response.isLeft){
      getOtpCodeStatus.value = RxStatus.error();
     failureDialog(response.left,Get.context);
    }
   });
 }
 otpVerification(String phoneNumber,String otpCode){
   _otpVerificationUseCase = Get.find();
   Map<String,dynamic> body={
     "phone":phoneNumber,
     "otp_code":otpCode
   };
   _otpVerificationUseCase.call(Params(body: body)).then((response){
     _getUserInfoUseCase = Get.find();
     if(response.isRight){
       _getUserInfoUseCase.call(NoParams()).then((response){
         if (response.isRight) {
           final userData = response.right.data;
           final firstName = userData?.firstName;

           if (firstName != null && firstName.isNotEmpty) {
             Get.offAllNamed(RouteNames.mainPage);
           } else {
             Get.offAllNamed(RouteNames.userInfoPage);
           }
         } else {
           Get.offAllNamed(RouteNames.userInfoPage);
         }
       });
     }else if(response.isLeft){
       failureDialog(response.left,Get.context);
     }
   });
 }
}