import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<RegisterEvent>(
      (event, emit) async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        try {
          if (event.formKey.currentState!.validate()) {
            final UserCredential userCredential = await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: event.emailController.text,
                    password: event.passwordController.text);
            final user = userCredential.user;
            if (user != null) {
              pref.setString("uid", user.uid);
              FirebaseFirestore.instance
                  .collection("user")
                  .doc(user.uid)
                  .set({"email": user.email, "username": user.displayName});
            }
          }
        } catch (err) {
          emit(
            AuthErrorState(
              errorMessage: err.toString(),
            ),
          );
        }
      },
    );

    on<LoginEvent>(
      (event, emit) async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        try {
          if (event.formKey.currentState!.validate()) {
            final UserCredential userCredentials = await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: event.emailController.text,
                    password: event.passwordController.text);
            if (userCredentials.user != null) {
              pref.setString("uid", userCredentials.user!.uid);
              emit(LoggedInState());
            }
          }
        } catch (err) {
          emit(
            AuthErrorState(
              errorMessage: err.toString(),
            ),
          );
        }
      },
    );

    on<ShowLoginPageEvent>(
      (event, emit) => emit(
        ShowLoginPageState(),
      ),
    );
    on<ShowRegisterPageEvent>(
      (event, emit) => emit(
        ShowRegisterPageState(),
      ),
    );
  }
}
