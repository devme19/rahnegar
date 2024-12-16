

import 'package:rahnegar/features/auth/data/model/otp_verification_data_model.dart';

import '../../domain/entity/otp_verification_entity.dart';
import '../../../../common/model/error_model.dart';

class OtpVerificationModel extends OtpVerificationEntity {
  OtpVerificationModel({
    ErrorModel? error,
    OtpVerificationDataModel? data,
  }) : super(
    error: error!,
    data: data!,
  );

  factory OtpVerificationModel.fromJson(Map<String, dynamic> json) {
    return OtpVerificationModel(
      error: ErrorModel.fromJson(json['error']),
      data: OtpVerificationDataModel.fromJson(json['data']),
    );
  }
}