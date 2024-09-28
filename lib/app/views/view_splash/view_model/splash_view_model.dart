import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_app/app/router/app_router.dart';
import 'package:spotify_clone_app/app/views/view_splash/view_model/splash_event.dart';
import 'package:spotify_clone_app/app/views/view_splash/view_model/splash_state.dart';

class SplashViewModel extends Bloc<SplashEvent, SplashState> {
  SplashViewModel() : super(SplashInitialState()) {
    on<SplashInitialEvent>(_onSplashInitial);
  }

  Future<FutureOr<void>> _onSplashInitial(
      SplashInitialEvent event, Emitter<SplashState> emit) async {
    Future.delayed(const Duration(seconds: 3), () async {
      // Assuming you have a correct context here
      event.context.router.replace(const IntroViewRoute());
    });
  }
}