part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoggedInState extends AuthState {}

final class RegisteredState extends AuthState {}

class ShowLoginPageState extends AuthState {}

class ShowRegisterPageState extends AuthState {}

class AuthErrorState extends AuthState {
  final String? errorMessage;

  AuthErrorState({this.errorMessage});
}
