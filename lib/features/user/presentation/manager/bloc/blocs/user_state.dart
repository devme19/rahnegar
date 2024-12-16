part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}
final class FailureState extends UserState{
  final Failure failure;

  FailureState({required this.failure});
}
final class SuccessState extends UserState{}
final class GetUserInfoSuccess extends UserState{
  final UserEntity userEntity;

  GetUserInfoSuccess({required this.userEntity});
}
final class GetUserInfoFailure extends UserState{

}
