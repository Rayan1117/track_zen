import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_zen/auth_bloc/auth_bloc.dart';
import 'package:track_zen/authentication/login_page.dart';
import 'package:track_zen/authentication/register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Placeholder(
          child: (state is ShowRegisterPageState) ? RegisterPage() : LoginPage(),
        );
      },
    );
  }
}
