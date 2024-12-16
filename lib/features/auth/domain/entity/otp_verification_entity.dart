import 'package:equatable/equatable.dart';
import 'package:rahnegar/features/auth/domain/entity/otp_verification_data_entity.dart';

import '../../../../common/entity/error_entity.dart';

class OtpVerificationEntity  extends Equatable{
  final ErrorEntity error;
  final OtpVerificationDataEntity data;

  OtpVerificationEntity({
    required this.error,
    required this.data,
  });

  @override
  List<Object?> get props => [error, data];
}