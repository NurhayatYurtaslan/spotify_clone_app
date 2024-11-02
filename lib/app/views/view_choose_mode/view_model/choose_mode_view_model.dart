import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_app/app/router/app_router.dart';
import 'package:spotify_clone_app/app/views/view_choose_mode/view_model/choose_mode_event.dart';
import 'package:spotify_clone_app/app/views/view_choose_mode/view_model/choose_mode_state.dart';

class ChooseModeViewModel extends Bloc<ChooseModeEvent, ChooseModeState> {
  ChooseModeViewModel() : super(ChooseModeInitialState()) {
    on<ChooseModeInitialEvent>(_onChooseModeInitial);
  }
  Future<FutureOr<void>> _onChooseModeInitial(
      ChooseModeInitialEvent event, Emitter<ChooseModeState> emit) async {
    event.context.router.replace(const SigninOrSignupViewRoute());
  }
}
