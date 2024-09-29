import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_app/app/views/view_choose_mode/view_model/choose_mode_event.dart';
import 'package:spotify_clone_app/app/views/view_choose_mode/view_model/choose_mode_state.dart';
import 'package:spotify_clone_app/core/theme/app_theme.dart';

class ChooseModeViewModel extends Bloc<ChooseModeEvent, ChooseModeState> {
  ChooseModeViewModel() : super(ChooseModeInitialState(AppTheme.lightTheme)) {
    on<ChooseModeInitialEvent>(_onChangeTheme);
  }

  void _onChangeTheme(ChooseModeInitialEvent event, Emitter<ChooseModeState> emit) {
    // Emit new state with updated theme
    emit(ChooseModeChangedState(event.themeData)); 
  }
}
