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
import 'package:modern_snackbar/modern_snackbar.dart'; // ModernSnackbar'ı import edin

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

      if (user != null && event.context.mounted) {
        emit(SigninSuccessState());
        _showSnackbar(
          context: event.context,
          title: 'Success',
          titleColor: AppColors.primary,
          icon: Icons.check,
          message: 'Signed in with Google successfully.',
          backgroundColor: AppColors.primary,
        );
        Future.delayed(event.context.durationMedium, () {
          if (event.context.mounted) {
            event.context.router.replace(const HomeViewRoute());
          }
        });
      } else if (event.context.mounted) {
        emit(SigninFailureState('Google sign-in failed'));
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
      if (event.context.mounted) {
        _showSnackbar(
          context: event.context,
          icon: Icons.error_outline_sharp,
          titleColor: AppColors.warningColor,
          title: 'Warning',
          message: 'Please enter both email and password.',
          backgroundColor: AppColors.warningColor,
        );
      }
      return;
    }

    const emailPattern = r'^[^@]+@[^@]+\.[^@]+';
    if (!RegExp(emailPattern).hasMatch(emailController.text)) {
      emit(SigninFailureState('Your email format is incorrect.'));
      if (event.context.mounted) {
        _showSnackbar(
          icon: Icons.email_outlined,
          title: 'Warning',
          titleColor: AppColors.warningColor,
          context: event.context,
          message: 'Your email format is incorrect.',
          backgroundColor: AppColors.warningColor,
        );
      }
      return;
    }

    try {
      await authService.signIn(SignInRequestModel(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ));

      emit(SigninSuccessState());
      if (event.context.mounted) {
        _showSnackbar(
          context: event.context,
          title: 'Success',
          titleColor: AppColors.primary,
          message: 'Sign in successful.',
          backgroundColor: AppColors.primary,
          icon: Icons.check,
        );
        Future.delayed(event.context.durationMedium, () {
          if (event.context.mounted) {
            event.context.router.replace(const HomeViewRoute());
          }
        });
      }
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(e, stack, fatal: true);
      String errorMessage = 'An error occurred. Please try again.';
      if (e is FirebaseAuthException) {
        errorMessage = e.code == 'invalid-email'
            ? 'Your email format is incorrect.'
            : 'Email or password incorrect.';
      }
      emit(SigninFailureState(errorMessage));
      if (event.context.mounted) {
        _showSnackbar(
          context: event.context,
          title: 'Error',
          titleColor: AppColors.errorColor,
          message: errorMessage,
          backgroundColor: AppColors.errorColor,
        );
      }
    }
  }

  void _onBack(BackEvent event, Emitter<SigninState> emit) {
    if (event.context.mounted) {
      _showSnackbar(
        context: event.context,
        title: 'Please Wait',
        titleColor: AppColors.backColor,
        message: 'Returning to previous screen.',
        backgroundColor: AppColors.backColor,
      );
      Future.delayed(event.context.durationMedium, () {
        if (event.context.mounted) {
          event.context.router.replace(const ChooseModeViewRoute());
        }
      });
    }
  }

  void _onRegister(RegisterEvent event, Emitter<SigninState> emit) {
    if (event.context.mounted) {
      _showSnackbar(
        context: event.context,
        title: 'Please Wait',
        titleColor: AppColors.registerColor,
        message: 'Navigating to registration screen.',
        backgroundColor: AppColors.registerColor,
      );
      Future.delayed(event.context.durationMedium, () {
        if (event.context.mounted) {
          event.context.router.replace(const SignupViewRoute());
        }
      });
    }
  }

  void _onTogglePasswordVisibility(
      TogglePasswordVisibilityEvent event, Emitter<SigninState> emit) {
    _isObscured = !_isObscured;
    emit(PasswordVisibilityState(_isObscured));
  }

  void _showSnackbar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    String title = 'Notification',
    IconData icon = Icons.info,
    Color titleColor = Colors.black,
  }) {
    if (context.mounted) {
      ModernSnackbar(
        titleColor: titleColor,
        title: title,
        description: message,
        backgroundColor: backgroundColor,
        icon: icon,
      ).show(context);
    }
  }
}
