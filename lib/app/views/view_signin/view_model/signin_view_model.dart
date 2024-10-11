import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_app/app/router/app_router.dart';
import 'package:spotify_clone_app/app/views/view_signin/view_model/signin_event.dart';
import 'package:spotify_clone_app/app/views/view_signin/view_model/signin_state.dart';
import 'package:spotify_clone_app/core/constants/color_constants.dart';
import 'package:spotify_clone_app/core/extensions/context_extension.dart';
import 'package:spotify_clone_app/core/repository/model/auth/signin/signin_request_model.dart';
import 'package:spotify_clone_app/core/repository/service/auth_service.dart';

class SigninViewModel extends Bloc<SigninEvent, SigninState> {
  final AuthService authService = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isObscured = true;

  bool get isObscured => _isObscured;

  SigninViewModel() : super(SigninInitialState()) {
    on<SigninInitialEvent>((event, emit) async {
      await _onSignin(event, emit);
    });

    on<SigninWithGoogleEvent>((event, emit) async {
      emit(SigninLoadingState());
      final user = await authService.loginWithGoogle(event.context);

      if (user != null) {
        emit(SigninSuccessState());
        _showSnackbar(event.context, 'Signed in with Google successfully.',
            AppColors.primary);
        Future.delayed(event.context.durationMedium, () {
          event.context.router.replace(const HomeViewRoute());
        });
      } else {
        emit(SigninFailureState('Google sign-in failed'));
        _showSnackbar(
            event.context, 'Google sign-in failed.', AppColors.errorColor);
      }
    });

    on<BackEvent>(_onBack);
    on<RegisterEvent>(_onRegister);
    on<TogglePasswordVisibilityEvent>(_onTogglePasswordVisibility);
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }

  Future<void> _onSignin(
      SigninInitialEvent event, Emitter<SigninState> emit) async {
    FocusManager.instance.primaryFocus?.unfocus();
    emit(SigninLoadingState());

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      emit(SigninFailureState('Please enter both email and password.'));
      _showSnackbar(event.context, 'Please enter both email and password.',
          AppColors.errorColor);
      return;
    }

    const emailPattern = r'^[^@]+@[^@]+\.[^@]+';
    if (!RegExp(emailPattern).hasMatch(emailController.text)) {
      emit(SigninFailureState('Your email format is incorrect.'));
      _showSnackbar(event.context, 'Your email format is incorrect.',
          AppColors.errorColor);
      return;
    }

    try {
      await authService.signIn(SignInRequestModel(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ));

      emit(SigninSuccessState());
      _showSnackbar(event.context, 'Sign in successful.', AppColors.primary);
          Future.delayed(event.context.durationMedium, () {
      event.context.router.replace(const HomeViewRoute());
    });
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(e, stack, fatal: true);
      String errorMessage = 'An error occurred. Please try again.';
      if (e is FirebaseAuthException) {
        errorMessage = e.code == 'invalid-email'
            ? 'Your email format is incorrect.'
            : 'Email or password incorrect.';
      }
      emit(SigninFailureState(errorMessage));
      _showSnackbar(event.context, errorMessage, AppColors.errorColor);
    }
  }

  void _onBack(BackEvent event, Emitter<SigninState> emit) {
    _showSnackbar(
        event.context, 'Returning to previous screen.', AppColors.backColor);
    Future.delayed(event.context.durationMedium, () {
      event.context.router.replace(const ChooseModeViewRoute());
    });
  }

  void _onRegister(RegisterEvent event, Emitter<SigninState> emit) {
        _showSnackbar(
        event.context, 'Navigating to registration screen.', AppColors.registerColor);
        Future.delayed(event.context.durationMedium, () {
      event.context.router.replace(const SignupViewRoute());
    });
  }

  void _onTogglePasswordVisibility(
      TogglePasswordVisibilityEvent event, Emitter<SigninState> emit) {
    _isObscured = !_isObscured;
    emit(PasswordVisibilityState(_isObscured));
  }

  void _showSnackbar(
      BuildContext context, String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Center(child: Text(message, style: TextStyle(color: Colors.white, fontWeight:FontWeight.w300, fontSize: 18), )),
          backgroundColor: backgroundColor,
          duration: context.durationMedium),
    );
  }
}
