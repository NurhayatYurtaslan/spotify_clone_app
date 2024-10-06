import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_app/app/router/app_router.dart';
import 'package:spotify_clone_app/app/views/view_signin/view_model/signin_event.dart';
import 'package:spotify_clone_app/app/views/view_signin/view_model/signin_state.dart';
import 'package:spotify_clone_app/core/repository/model/auth/signin/signin_request_model.dart';
import 'package:spotify_clone_app/core/repository/service/auth_service.dart';

class SigninViewModel extends Bloc<SigninEvent, SigninState> {
  final AuthService authService = AuthService();

  // Controllers for email and password input
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SigninViewModel({
    required Function() onSuccessCallback,
    required Function(String errorMessage) onErrorCallback,
  }) : super(SigninInitialState()) {
    on<SigninInitialEvent>((event, emit) async {
      await _onSignin(event, emit, onSuccessCallback, onErrorCallback);
    });
    on<SigninWithGoogleEvent>((event, emit) async {
      await _onSigninWithGoogle(event, emit, onErrorCallback);
    });
    on<BackEvent>(_onBack);
    on<RegisterEvent>(_onRegister);
  }

  // Dispose of controllers to prevent memory leaks
  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }

  Future<void> _onSignin(
      SigninInitialEvent event,
      Emitter<SigninState> emit,
      Function() onSuccessCallback,
      Function(String errorMessage) onErrorCallback) async {
    FocusManager.instance.primaryFocus?.unfocus();
    emit(SigninLoadingState());

    // Basic validation for email and password
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      emit(SigninFailureState('Please enter both email and password.'));
      onErrorCallback('Please enter both email and password.');
      return;
    }

    // Optional email format validation
    const emailPattern = r'^[^@]+@[^@]+\.[^@]+';
    if (!RegExp(emailPattern).hasMatch(emailController.text)) {
      emit(SigninFailureState('Your email format is incorrect.'));
      onErrorCallback('Your email format is incorrect.');
      return;
    }

    try {
      await authService.signIn(SignInRequestModel(
          email: emailController.text.trim(),
          password: passwordController.text.trim()));

      emit(SigninSuccessState());
      onSuccessCallback(); // Notify on success
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(e, stack, fatal: true);
      String errorMessage = 'An error occurred. Please try again.';
      if (e is FirebaseAuthException) {
        errorMessage = e.code == 'invalid-email'
            ? 'Your email format is incorrect.'
            : 'Email or password incorrect.';
      }
      emit(SigninFailureState(errorMessage));
      onErrorCallback(errorMessage); // Notify on error
    }
  }

  Future<void> _onBack(BackEvent event, Emitter<SigninState> emit) async {
    event.context.router.replace(const SigninOrSignupViewRoute());
  }

  Future<void> _onRegister(
      RegisterEvent event, Emitter<SigninState> emit) async {
    event.context.router.replace(const SignupViewRoute());
  }

  Future<void> _onSigninWithGoogle(
      SigninWithGoogleEvent event,
      Emitter<SigninState> emit,
      Function(String errorMessage) onErrorCallback) async {
    emit(SigninLoadingState());

    try {
      final User? user = await authService.loginWithGoogle(event.context);
      if (user != null) {
        emit(SigninSuccessState());
        event.context.router.replace(const HomeViewRoute());
      }
    } on PlatformException catch (e) {
      // Log the error with Crashlytics
      String errorMessage = 'Platform Error: ${e.message}';
      emit(SigninFailureState(errorMessage));
      onErrorCallback(errorMessage);
    } catch (e, stackTrace) {
      // Log the unexpected error with Crashlytics
      FirebaseCrashlytics.instance.recordError(e, stackTrace, fatal: true);
      String errorMessage = 'An unexpected error occurred. Please try again.';
      emit(SigninFailureState(errorMessage));
      onErrorCallback(errorMessage);
    }
  }
}
