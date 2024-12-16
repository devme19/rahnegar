import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/car/domain/repository/car_repository.dart';

class GetFcmTokenUseCase implements UseCase<String,NoParams>{
  final CarRepository repository;

  GetFcmTokenUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(NoParams params) {
    return repository.getFcmToken();
  }


}