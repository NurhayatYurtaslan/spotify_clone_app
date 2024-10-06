import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_clone_app/app/router/app_router.dart';
import 'package:spotify_clone_app/core/repository/model/auth/signup/signup_request_model.dart';
import 'package:spotify_clone_app/core/repository/service/auth_service.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupViewModel extends Bloc<SignupEvent, SignupState> {
  final AuthService authService = AuthService();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignupViewModel({
    required Function() onSuccessCallback,
    required Function(String errorMessage) onErrorCallback,
  }) : super(SignupInitialState()) {
    on<SignupInitialEvent>((event, emit) async {
      await _onSignup(event, emit, onSuccessCallback, onErrorCallback);
    });
    on<SignupWithGoogleEvent>((event, emit) async {
      await _onSignupWithGoogle(event, emit, onErrorCallback);
    });
    on<BackToSigninEvent>(_onBackToSignin);
  }

  @override
  Future<void> close() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }

  Future<void> _onSignup(
    SignupInitialEvent event,
    Emitter<SignupState> emit,
    Function() onSuccessCallback,
    Function(String errorMessage) onErrorCallback,
  ) async {
    FocusManager.instance.primaryFocus?.unfocus();
    emit(SignupLoadingState());

    // Gerekli alanları kontrol et
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      emit(SignupFailureState('Please fill all fields.'));
      onErrorCallback('Please fill all fields.');
      return;
    }

    // Şifre doğrulama
    if (!validatePassword(passwordController.text)) {
      emit(SignupFailureState(
          'Password must contain at least 8 characters, one uppercase letter, one lowercase letter, one number, and one special character.'));
      onErrorCallback(
          'Password must contain at least 8 characters, one uppercase letter, one lowercase letter, one number, and one special character.');
      return;
    }

    // Kayıt işlemi
    try {
      await authService.signUp(SignUpRequestModel(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: usernameController.text.trim(),
      ));

      emit(SignupSuccessState());
      onSuccessCallback(); // Başarılı callback
    } catch (e) {
      String errorMessage = 'An error occurred. Please try again.';
      if (e is FirebaseAuthException) {
        errorMessage = e.code == 'email-already-in-use'
            ? 'This email is already in use.'
            : 'Failed to register.';
      }
      emit(SignupFailureState(errorMessage));
      onErrorCallback(errorMessage); // Hata callback
    }
  }

  // Şifre geçerliliği kontrolü
  bool validatePassword(String password) {
    final passwordRegex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return passwordRegex.hasMatch(password);
  }

  Future<void> _onSignupWithGoogle(
    SignupWithGoogleEvent event,
    Emitter<SignupState> emit,
    Function(String errorMessage) onErrorCallback,
  ) async {
    emit(SignupLoadingState());

    try {
      final User? user = await authService.loginWithGoogle(event.context);
      if (user != null) {
        emit(SignupSuccessState());
        event.context.router.replace(const HomeViewRoute());
      }
    } catch (e) {
      emit(SignupFailureState('Google sign up failed.'));
      onErrorCallback('Google sign up failed.');
    }
  }

  Future<void> _onBackToSignin(
      BackToSigninEvent event, Emitter<SignupState> emit) async {
    event.context.router.replace(const SigninViewRoute());
  }
}
