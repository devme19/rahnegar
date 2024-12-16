import 'package:equatable/equatable.dart';

class OtpVerificationDataEntity extends Equatable{
  final String access;
  final String refresh;

  OtpVerificationDataEntity({required this.access,required this.refresh});

  @override
  // TODO: implement props
  List<Object?> get props => [access,refresh];
}