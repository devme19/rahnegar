import 'package:bloc/bloc.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/features/auth/domain/usecase/get_user_info_usecase.dart';
import 'package:rahnegar/features/auth/domain/usecase/otp_verification_usecase.dart';

import '../../../../../../../common/utils/usecase.dart';
import '../../../../../domain/usecase/get_otp_code_usecase.dart';


part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final GetOtpCodeUseCase getOtpCodeUseCase;
  final OtpVerificationUseCase otpVerificationUseCase;
  final GetUserInfoUseCase getUserInfoUseCase;
  OtpBloc({required this.getOtpCodeUseCase,required this.otpVerificationUseCase,required this.getUserInfoUseCase}) : super(OtpInitial()) {
    on<GetOtpCodeEvent>(_getOtpCodeEvent);
    on<OtpVerificationEvent>(_otpVerificationEvent);
  }
  _getOtpCodeEvent(GetOtpCodeEvent event, Emitter<OtpState> emit)async{
    emit(OtpLoading());
    await Future.delayed(const Duration(seconds: 1));
    // emit(SuccessState(getOtpCode: true,otpVerification: false));
    Map<String,dynamic> body={
      "phone":event.phoneNumber
    };
    final response = await getOtpCodeUseCase.call(Params(body: body));
    if(response.isRight){
      emit(SuccessState(getOtpCode: true,otpVerification: false));
    }else if(response.isLeft){
      emit(FailureState(failure: response.left));
    }
  }
  _otpVerificationEvent(OtpVerificationEvent event,Emitter<OtpState> emit)async{
    Map<String,dynamic> body={
      "phone":event.phoneNumber,
      "otp_code":event.otpCode
    };
    final response = await otpVerificationUseCase.call(Params(body: body));
    if(response.isRight){
      emit(SuccessState(getOtpCode: false,otpVerification: true));
    }else if(response.isLeft){
      emit(FailureState(failure: response.left));
    }
  }
  getUserInfo({required Function(bool) registeredUSer})async{
    final response = await getUserInfoUseCase.call(NoParams());
    if(response.isRight){
      final user = response.right.data;
      if(user!=null){
        if(user.firstName!=null && user.lastName!=null){
          if(user.firstName!.isNotEmpty && user.lastName!.isNotEmpty) {
            registeredUSer(true);
          }
          else{
            registeredUSer(false);
          }
        }else{
          registeredUSer(false);
        }

      }
      else{
        registeredUSer(false);
      }
    }else if(response.isLeft){
      registeredUSer(false);
    }
  }

}
