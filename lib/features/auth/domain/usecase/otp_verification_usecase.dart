import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/auth/domain/entity/otp_code_entity.dart';
import 'package:rahnegar/features/auth/domain/entity/otp_verification_entity.dart';
import 'package:rahnegar/features/auth/domain/repository/auth_repository.dart';

class OtpVerificationUseCase implements UseCase<OtpVerificationEntity,Params>{
  final AuthRepository repository;

  OtpVerificationUseCase({required this.repository});

  @override
  Future<Either<Failure, OtpVerificationEntity>> call(Params params) {
    return repository.otpCodeVerification(body: params.body!);
  }

}