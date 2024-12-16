part of 'otp_bloc.dart';

@immutable
sealed class OtpState {}

final class OtpInitial extends OtpState {}
final class FailureState extends OtpState{
  final Failure failure;
  FailureState({required this.failure});
}
final class SuccessState extends OtpState{
  final bool getOtpCode;
  final bool otpVerification;
  SuccessState({this.getOtpCode=false,this.otpVerification=false});
}
final class OtpLoading extends OtpState{
}
