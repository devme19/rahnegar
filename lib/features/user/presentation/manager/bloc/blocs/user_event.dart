part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}
class GetUserInfoEvent extends UserEvent{}
class UpdateUserInfoEvent extends UserEvent{
  final Map<String,dynamic> body;
  UpdateUserInfoEvent({required this.body});
}
