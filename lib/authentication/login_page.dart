import 'package:flutter/material.dart';
import 'package:track_zen/auth_bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_zen/authentication/page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              "assets/image.jpg",
            ),
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(50),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    "LOGIN",
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          10,
                        ),
                      ),
                    ),
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: (val) => (val!.trim().isEmpty)
                                ? "email must be entered"
                                : null,
                            style: const TextStyle(color: Colors.black),
                            controller: _emailController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20,
                                  ),
                                ),
                              ),
                              label: Text(
                                "Email or Username",
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(
                            8.0,
                          ),
                          child: TextFormField(
                            validator: (val) => (val!.trim().isEmpty)
                                ? "password must be entered"
                                : null,
                            style: const TextStyle(color: Colors.black),
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20,
                                  ),
                                ),
                              ),
                              label: Text("Password"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      (state is LoggedInState)
                          ? Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const NextPage(),
                              ),
                            )
                          : null;
                      (state is AuthErrorState)
                          ? ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  state.errorMessage!,
                                ),
                              ),
                            )
                          : null;
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Colors.green,
                                ),
                              ),
                              child: const Text(
                                "SignIn",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                BlocProvider.of<AuthBloc>(context).add(
                                  LoginEvent(
                                      emailController: _emailController,
                                      passwordController: _passwordController,
                                      formKey: _formKey),
                                );
                              },
                            ),
                            TextButton(
                              onPressed: () {
                                BlocProvider.of<AuthBloc>(context)
                                    .add(ShowRegisterPageEvent());
                              },
                              child: const Text("create new"),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
