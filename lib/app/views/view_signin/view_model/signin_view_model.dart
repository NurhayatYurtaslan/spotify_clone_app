import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_app/app/router/app_router.dart';
import 'package:spotify_clone_app/app/views/view_signin/view_model/signin_event.dart';
import 'package:spotify_clone_app/app/views/view_signin/view_model/signin_state.dart';
import 'package:spotify_clone_app/core/repository/model/auth/signin/signin_request_model.dart';
import 'package:spotify_clone_app/core/repository/service/auth_service.dart';

class SigninViewModel extends Bloc<SigninEvent, SigninState> {
  SigninViewModel(
      {required Null Function() onSuccessCallback,
      required Null Function(dynamic errorMessage) onErrorCallback})
      : super(SigninInitialState()) {
    on<SigninInitialEvent>(_onSignin);
    on<SigninWithGoogleEvent>(_onSigninWithGoogle);
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  Future<void> _onSignin(
      SigninInitialEvent event, Emitter<SigninState> emit) async {
    FocusManager.instance.primaryFocus?.unfocus();
    emit(SigninLoadingState());
    try {
      await authService.signIn(SignInRequestModel(
          email: emailController.text.trim(),
          password: passwordController.text.trim()));
      // Navigate to the onboarding page
      event.context.router.replace(const ChooseModeViewRoute());
      emit(SigninSuccessState());
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(e, stack, fatal: true);
      String errorMessage = 'An error occurred. Please try again.';
      if (e is FirebaseAuthException) {
        if (e.code == 'invalid-email') {
          errorMessage = 'Your email format is incorrect.';
        } else {
          errorMessage = 'Email or password incorrect.';
        }
      }
      emit(SigninFailureState(errorMessage));
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
        backgroundColor: Colors.transparent,
        content: Text(errorMessage),
      ));
    }
  }

  Future<void> _onSigninWithGoogle(
      SigninWithGoogleEvent event, Emitter<SigninState> emit) async {
    emit(SigninLoadingState());
    try {
      final User? user = await authService.loginWithGoogle(event.context);
      if (user != null) {
        // Kullanıcı başarıyla giriş yaptı, yönlendirme yapabilirsiniz.
        event.context.router.replace(const SplashViewRoute());
        emit(SigninSuccessState());
      }
    } catch (e) {
      if (e.toString() == "Exception: Login with Google has been canceled") {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(event.context).showSnackBar(
          const SnackBar(
            content: Text("Login with Google has been canceled"),
          ),
        );
      } else {
        FirebaseCrashlytics.instance.recordError(e, null, fatal: true);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(event.context).showSnackBar(
          const SnackBar(
            content: Text("Google login failed"),
          ),
        );
      }
      emit(SigninFailureState(e.toString()));
    }
  }
}