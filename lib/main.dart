import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_zen/auth_bloc/auth_bloc.dart';
import 'package:track_zen/authentication/auth_page.dart';
import 'package:track_zen/authentication/page.dart';
import 'package:track_zen/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MaterialApp(
      theme: ThemeData(
          buttonTheme: ButtonThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)),
          colorSchemeSeed: Colors.green),
      home: BlocProvider(
        create: (context) => AuthBloc(),
        child: const AppEntryPoint(),
      ),
    ),
  );
}

class AppEntryPoint extends StatefulWidget {
  const AppEntryPoint({super.key});

  @override
  State<AppEntryPoint> createState() => _AppEntryPointState();
}

class _AppEntryPointState extends State<AppEntryPoint> {
  Widget comp = const Text("Signin");

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.signOut();
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return (snapshot.hasData)?const NextPage():const AuthPage();
      }
    );
  }
}
