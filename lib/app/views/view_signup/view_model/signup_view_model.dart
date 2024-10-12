import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modern_snackbar/modern_snackbar.dart';
import 'package:spotify_clone_app/app/router/app_router.dart';
import 'package:spotify_clone_app/core/constants/color_constants.dart';
import 'package:spotify_clone_app/core/extensions/context_extension.dart';
import 'package:spotify_clone_app/core/repository/model/auth/signup/signup_request_model.dart';
import 'package:spotify_clone_app/core/repository/service/auth_service.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupViewModel extends Bloc<SignupEvent, SignupState> {
  final AuthService authService = AuthService();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode passwordFocusNode = FocusNode();

  bool isPasswordVisible = false;
  bool passwordRequirementsVisible = false;
  List<bool> passwordRequirementsMet = [false, false, false, false, false];

  SignupViewModel() : super(SignupInitialState()) {
    on<BackEvent>(_onBack);
    on<SigninEvent>(_onSignin);
    on<SignupInitialEvent>((event, emit) async {
      await _onSignup(event, emit);
    });

    on<CheckPasswordRequirementsEvent>((event, emit) {
      _checkPasswordRequirements();
      emit(SignupInitialState());
    });

    passwordFocusNode.addListener(() {
      if (!passwordFocusNode.hasFocus) {
        passwordRequirementsVisible = false;
        add(CheckPasswordRequirementsEvent()); // Add event to handle password visibility
      }
    });
  }

  @override
  Future<void> close() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
    return super.close();
  }

  void _onBack(BackEvent event, Emitter<SignupState> emit) {
    _showSnackbar(
      context: event.context,
      title: 'Please Wait',
      message: 'Returning to previous screen.',
      backgroundColor: AppColors.backColor,
    );
    Future.delayed(event.context.durationMedium, () {
      if (event.context.mounted) {
        event.context.router.replace(const ChooseModeViewRoute());
      }
    });
  }

  void _onSignin(SigninEvent event, Emitter<SignupState> emit) {
    _showSnackbar(
      context: event.context,
      title: 'Please Wait',
      message: 'Navigating to registration screen.',
      backgroundColor: AppColors.registerColor,
    );
    Future.delayed(event.context.durationMedium, () {
      if (event.context.mounted) {
        event.context.router.replace(const SigninViewRoute());
      }
    });
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    add(CheckPasswordRequirementsEvent()); // Trigger event to update state
  }

  void togglePasswordRequirementsVisibility() {
    passwordRequirementsVisible = !passwordRequirementsVisible;
    add(CheckPasswordRequirementsEvent()); // Add event to trigger state change
  }

  void _checkPasswordRequirements() {
    final password = passwordController.text;
    passwordRequirementsMet[0] = password.length >= 8;
    passwordRequirementsMet[1] = RegExp(r'(?=.*[A-Z])').hasMatch(password);
    passwordRequirementsMet[2] = RegExp(r'(?=.*[a-z])').hasMatch(password);
    passwordRequirementsMet[3] = RegExp(r'(?=.*\d)').hasMatch(password);
    passwordRequirementsMet[4] = RegExp(r'(?=.*[@#\$%\&\.])').hasMatch(password);
  }

  Future<void> _onSignup(
      SignupInitialEvent event, Emitter<SignupState> emit) async {
    FocusManager.instance.primaryFocus?.unfocus();
    emit(SignupLoadingState());

    final isValid = _validateFields(event.context);
    if (!isValid) return;

    try {
      await _signUpUser(event, emit);

      if (event.context.mounted) {
        emit(SignupSuccessState());
        _showSnackbar(
          context: event.context,
          title: 'Success',
          message: 'Sign up successful.',
          backgroundColor: AppColors.primary,
          icon: Icons.check,
        );

        Future.delayed(event.context.durationLow, () {
          if (event.context.mounted) {
            event.context.router.replace(const HomeViewRoute());
          }
        });
      }
    } catch (e) {
      if (event.context.mounted) {
        _handleSignupError(e, event.context, emit);
      }
    }
  }

  bool _validateFields(BuildContext context) {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      if (context.mounted) {
        _showSnackbar(
          context: context,
          title: 'Warning',
          message: 'Please fill all fields.',
          backgroundColor: AppColors.warningColor,
        );
      }
      return false;
    }

    return true;
  }

  Future<void> _signUpUser(
      SignupInitialEvent event, Emitter<SignupState> emit) async {
    await authService.signUp(SignUpRequestModel(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      name: usernameController.text.trim(),
    ));

    if (event.context.mounted) {
      emit(SignupSuccessState());
      _showSnackbar(
        context: event.context,
        title: 'Success',
        message: 'Sign up successful.',
        backgroundColor: AppColors.primary,
        icon: Icons.check,
      );

      Future.delayed(event.context.durationLow, () {
        if (event.context.mounted) {
          event.context.router.replace(const HomeViewRoute());
        }
      });
    }
  }

  void _handleSignupError(
      dynamic error, BuildContext context, Emitter<SignupState> emit) {
    if (context.mounted) {
      String errorMessage = 'An error occurred. Please try again.';
      if (error is FirebaseAuthException) {
        errorMessage = error.code == 'email-already-in-use'
            ? 'This email is already in use.'
            : 'Failed to register.';
      }
      emit(SignupFailureState(errorMessage));
      _showSnackbar(
        context: context,
        title: 'Error',
        message: errorMessage,
        backgroundColor: AppColors.errorColor,
      );
    }
  }

  void _showSnackbar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    String title = 'Notification',
    IconData icon = Icons.info,
  }) {
    if (context.mounted) {
      ModernSnackbar(
        titleColor: backgroundColor,
        title: title,
        description: message,
        backgroundColor: backgroundColor,
        icon: icon,
      ).show(context);
    }
  }
}
