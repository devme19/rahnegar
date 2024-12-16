import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/setting/domain/repository/setting_repository.dart';

class GetLocaleUseCase implements UseCase<String,NoParams>{
  final SettingRepository repository;

  GetLocaleUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(NoParams params) {
    return repository.getLocale();
  }
}