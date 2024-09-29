import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_app/app/router/app_router.dart';
import 'package:spotify_clone_app/app/views/view_intro/view_model/intro_event.dart';
import 'package:spotify_clone_app/app/views/view_intro/view_model/intro_state.dart';

class IntroViewModel extends Bloc<IntroEvent, IntroState> {
  IntroViewModel() : super(IntroInitialState()) {
    on<GetStartedEvent>(_getStarted);
  }
  FutureOr<void> _getStarted(GetStartedEvent event, Emitter<IntroState> emit) {
    event.context.router.replace(ChooseModeViewRoute());
  }
}
