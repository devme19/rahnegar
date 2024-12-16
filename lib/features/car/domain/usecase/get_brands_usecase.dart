import 'package:rahnegar/common/client/failures.dart';
import 'package:rahnegar/common/utils/either.dart';
import 'package:rahnegar/common/utils/usecase.dart';
import 'package:rahnegar/features/car/domain/entity/brand_entity.dart';
import 'package:rahnegar/features/car/domain/repository/car_repository.dart';

class GetBrandsUseCase implements UseCase<BrandEntity,Params>{
  final CarRepository repository;

  GetBrandsUseCase({required this.repository});

  @override
  Future<Either<Failure, BrandEntity>> call(Params params) {
    return repository.getBrands(body: params.body!);
  }
}