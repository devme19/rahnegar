part of 'authorize_cubit.dart';

@immutable
sealed class AuthorizeState {}

final class AuthorizeInitial extends AuthorizeState {}
final class Authorized extends AuthorizeState {}
final class UnAuthorized extends AuthorizeState {}
