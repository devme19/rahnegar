part of 'get_brands_cubit.dart';

@immutable
sealed class GetBrandsState {}

final class GetBrandsInitial extends GetBrandsState {}
final class GetBrandsLoading extends GetBrandsState{}
final class GetBrandsSuccess extends GetBrandsState{
  List<BrandDataEntity> brands = [];
  GetBrandsSuccess({required this.brands});
}
final class GetBrandsFailure extends GetBrandsState{
  Failure failure;
  GetBrandsFailure({required this.failure});
}
