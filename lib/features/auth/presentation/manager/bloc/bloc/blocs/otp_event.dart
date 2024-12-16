part of 'otp_bloc.dart';

@immutable
sealed class OtpEvent {}

class GetOtpCodeEvent extends OtpEvent{
  final String phoneNumber;
  GetOtpCodeEvent({required this.phoneNumber});
}

class OtpVerificationEvent extends OtpEvent{
  final String otpCode;
  final String phoneNumber;
  OtpVerificationEvent({required this.otpCode,required this.phoneNumber});
}
