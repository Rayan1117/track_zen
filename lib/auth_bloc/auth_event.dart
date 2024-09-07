part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginEvent extends AuthEvent {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  LoginEvent(
      {required this.emailController,
      required this.passwordController,
      required this.formKey});
}

class RegisterEvent extends AuthEvent {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  RegisterEvent(
      {required this.emailController,
      required this.passwordController,
      required this.formKey});
}

class ShowLoginPageEvent extends AuthEvent{

}

class ShowRegisterPageEvent extends AuthEvent{
  
}