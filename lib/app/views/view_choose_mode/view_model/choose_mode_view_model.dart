import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_app/app/views/view_choose_mode/view_model/choose_mode_event.dart';
import 'package:spotify_clone_app/app/views/view_choose_mode/view_model/choose_mode_state.dart';
import 'package:spotify_clone_app/core/theme/app_theme.dart';

class ChooseModeViewModel extends Bloc<ChooseModeEvent, ChooseModeState> {
  
  ChooseModeViewModel() : super(ChooseModeInitialState(AppTheme.lightTheme)) {
    print('ChooseModeViewModel created'); // Add this line
    on<ChooseModeInitialEvent>(_onChangeTheme);
    on<ChooseModeDarkEvent>(_onChooseDark);
    on<ChooseModeLightEvent>(_onChooseLight);
  }

  void _onChangeTheme(
      ChooseModeInitialEvent event, Emitter<ChooseModeState> emit) {
    // Emit new state with updated theme
    emit(ChooseModeChangedState(event.themeData));
  }

  void _onChooseDark(ChooseModeDarkEvent event, Emitter<ChooseModeState> emit) {
    // Emit dark theme state
    emit(ChooseModeChangedState(AppTheme.darkTheme));
    print('dark theme');
  }

  void _onChooseLight(
      ChooseModeLightEvent event, Emitter<ChooseModeState> emit) {
    // Emit light theme state
    emit(ChooseModeChangedState(AppTheme.lightTheme));
    print('light theme');
  }
}
