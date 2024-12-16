import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/entity/response_entity.dart';
import 'package:rahnegar/features/auth/domain/entity/otp_verification_entity.dart';
import 'package:rahnegar/features/auth/domain/entity/user_entity.dart';

import '../../../../common/utils/either.dart';

abstract class AuthRepository{
  Future<Either<Failure,ResponseEntity>> getOtpCode({required Map<String,dynamic> body});
  Future<Either<Failure,OtpVerificationEntity>> otpCodeVerification({required Map<String,dynamic> body});
  Future<Either<Failure,UserEntity>> getUserInfo();
}