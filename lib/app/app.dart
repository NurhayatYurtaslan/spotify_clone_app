import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_app/app/router/app_router.dart';
import 'package:spotify_clone_app/app/views/view_choose_mode/view_model/choose_mode_state.dart';
import 'package:spotify_clone_app/app/views/view_choose_mode/view_model/choose_mode_view_model.dart';
import 'package:spotify_clone_app/core/theme/app_theme.dart';


class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChooseModeViewModel(),
      child: BlocBuilder<ChooseModeViewModel, ChooseModeState>(
        builder: (context, state) {
          ThemeData themeData;
          if (state is ChooseModeChangedState) {
            themeData = state.themeData; // Use the updated theme
          } else {
            themeData = AppTheme.lightTheme; // Default theme
          }
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeData.brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
            routerConfig: _appRouter.config(
              navigatorObservers: () => [NavigatorObserver()],
            ),
          );
        },
      ),
    );
  }
}
