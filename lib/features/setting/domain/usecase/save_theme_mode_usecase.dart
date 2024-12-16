import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/setting/domain/repository/setting_repository.dart';

class SaveThemeModeUseCase implements UseCase<bool,Params>{
    final SettingRepository repository;

  SaveThemeModeUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(Params params) {
    return repository.saveThemeMode(params.stringValue!);
  }
}