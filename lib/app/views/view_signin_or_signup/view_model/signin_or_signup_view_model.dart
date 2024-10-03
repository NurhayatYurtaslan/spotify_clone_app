import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'signin_or_signup_event.dart';
import 'signin_or_signup_state.dart';
import 'package:spotify_clone_app/app/router/app_router.dart'; // AutoRoute generated router

class SigninOrSignupViewModel
    extends Bloc<SigninOrSignupEvent, SigninOrSignupState> {
  SigninOrSignupViewModel() : super(SigninState()) {
    on<NavigateToSigninEvent>(_onNavigateToSignin);
    on<NavigateToSignupEvent>(_onNavigateToSignup);
    on<BackEvent>(_onBack);
  }

  Future<void> _onNavigateToSignin(
      NavigateToSigninEvent event, Emitter<SigninOrSignupState> emit) async {
    event.context.router.push(const SigninViewRoute());
  }

  Future<void> _onNavigateToSignup(
      NavigateToSignupEvent event, Emitter<SigninOrSignupState> emit) async {
    event.context.router.push(const SignupViewRoute());
  }

Future<void> _onBack(
    BackEvent event, Emitter<SigninOrSignupState> emit) async {
  event.context.router.replace(const ChooseModeViewRoute());
  
}

}
