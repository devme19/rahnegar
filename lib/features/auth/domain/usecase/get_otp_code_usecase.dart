import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/common/entity/response_entity.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/auth/domain/entity/otp_code_entity.dart';
import 'package:rahnegar/features/auth/domain/repository/auth_repository.dart';

class GetOtpCodeUseCase extends UseCase<ResponseEntity,Params>{

  final AuthRepository repository;
  GetOtpCodeUseCase({required this.repository});

  @override
  Future<Either<Failure, ResponseEntity>> call(Params params) {
    return repository.getOtpCode(body: params.body!);
  }


}