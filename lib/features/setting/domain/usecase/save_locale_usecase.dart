import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/setting/domain/repository/setting_repository.dart';

class SaveLocaleUseCase implements UseCase<bool,Params>{
  final SettingRepository repository;

  SaveLocaleUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(Params params) {
    return repository.saveLocale(params.stringValue!);
  }
}