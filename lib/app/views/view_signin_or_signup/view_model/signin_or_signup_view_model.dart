import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modern_snackbar/modern_snackbar.dart';
import 'package:spotify_clone_app/core/constants/color_constants.dart';
import 'package:spotify_clone_app/core/extensions/context_extension.dart';
import 'signin_or_signup_event.dart';
import 'signin_or_signup_state.dart';
import 'package:spotify_clone_app/app/router/app_router.dart'; 

class SigninOrSignupViewModel
    extends Bloc<SigninOrSignupEvent, SigninOrSignupState> {
  SigninOrSignupViewModel() : super(SigninState()) {
    on<NavigateToSigninEvent>(_onNavigateToSignin);
    on<NavigateToSignupEvent>(_onNavigateToSignup);
    on<BackEvent>(_onBack);
  }

  Future<void> _onNavigateToSignin(
      NavigateToSigninEvent event, Emitter<SigninOrSignupState> emit) async {
        ModernSnackbar(
        backgroundColor: AppColors.backColor,
        description: 'Navigate to Signin Page.',
        title: 'Please Wait',
        icon: Icons.timer,
        ).show(event.context);
    Future.delayed(event.context.durationMedium, () {
       
          event.context.router.replace(const SigninViewRoute());
       
      });
  }

  Future<void> _onNavigateToSignup(
      NavigateToSignupEvent event, Emitter<SigninOrSignupState> emit) async {
    event.context.router.push(const SignupViewRoute());
    ModernSnackbar(
        backgroundColor: AppColors.backColor,
        description: 'Navigate to Signup Page.',
        title: 'Please Wait',
        icon: Icons.timer,
        ).show(event.context);
    Future.delayed(event.context.durationMedium, () {
       
          event.context.router.replace(const SignupViewRoute());
        
      });
  }

  Future<void> _onBack(
      BackEvent event, Emitter<SigninOrSignupState> emit) async {
    ModernSnackbar(
      backgroundColor: AppColors.backColor,
        description: 'Returning to previous screen.',
        title: 'Please Wait',
        icon: Icons.timer,
        ).show(event.context);
    Future.delayed(event.context.durationMedium, () {
        if (event.context.mounted) {
          event.context.router.replace(const ChooseModeViewRoute());
        }
      });
  }
}
