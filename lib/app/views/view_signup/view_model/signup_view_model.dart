import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modern_snackbar/modern_snackbar.dart';
import 'package:spotify_clone_app/core/constants/color_constants.dart';
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
        emit(SignupInitialState());
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

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    // Burada emit çağrılmamalı, sadece on metodları içinde yapılmalı.
  }

  void togglePasswordRequirementsVisibility() {
    passwordRequirementsVisible = !passwordRequirementsVisible;
    // Burada emit çağrılmamalı, sadece on metodları içinde yapılmalı.
  }

  void _checkPasswordRequirements() {
    final password = passwordController.text;
    passwordRequirementsMet[0] = password.length >= 8;
    passwordRequirementsMet[1] = RegExp(r'(?=.*[A-Z])').hasMatch(password);
    passwordRequirementsMet[2] = RegExp(r'(?=.*[a-z])').hasMatch(password);
    passwordRequirementsMet[3] = RegExp(r'(?=.*\d)').hasMatch(password);
    passwordRequirementsMet[4] = RegExp(r'(?=.*[@#\$%\&\.])').hasMatch(password);
  }

  Future<void> _onSignup(SignupInitialEvent event, Emitter<SignupState> emit) async {
    FocusManager.instance.primaryFocus?.unfocus();
    emit(SignupLoadingState());

    final isValid = _validateFields(event.context);
    if (!isValid) return;

    try {
      await _signUpUser(event.context, emit);
    } catch (e) {
      _handleSignupError(e, event.context, emit);
    }
  }

  bool _validateFields(BuildContext context) {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      _showSnackbar(
        context: context,
        title: 'Warning',
        message: 'Please fill all fields.',
        backgroundColor: AppColors.warningColor,
      );
      return false;
    }

    return true;
  }

  Future<void> _signUpUser(BuildContext context, Emitter<SignupState> emit) async {
    await authService.signUp(SignUpRequestModel(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      name: usernameController.text.trim(),
    ));

    emit(SignupSuccessState());
    _showSnackbar(
      context: context,
      title: 'Success',
      message: 'Sign up successful.',
      backgroundColor: AppColors.primary,
      icon: Icons.check,
    );

    Future.delayed(const Duration(seconds: 2), () {
      // Sign in view'e geçiş yap
    });
  }

  void _handleSignupError(dynamic error, BuildContext context, Emitter<SignupState> emit) {
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

  void _showSnackbar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    String title = 'Notification',
    IconData icon = Icons.info,
  }) {
    ModernSnackbar(
      title: title,
      description: message,
      backgroundColor: backgroundColor,
      icon: icon,
    ).show(context);
  }
}