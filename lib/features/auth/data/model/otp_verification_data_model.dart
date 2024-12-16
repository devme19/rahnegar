import 'package:rahnegar/features/auth/domain/entity/otp_verification_data_entity.dart';

class OtpVerificationDataModel extends OtpVerificationDataEntity{
  OtpVerificationDataModel({
    required super.access,
    required super.refresh
});
  factory OtpVerificationDataModel.fromJson(Map<String, dynamic> json) {
    return OtpVerificationDataModel(
      access: json['access']??'',
      refresh: json['refresh']??'',
    );
  }
}