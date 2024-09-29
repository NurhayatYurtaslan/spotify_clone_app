import 'package:flavor/flavor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spotify_clone_app/app/router/app_router.dart';
import 'package:spotify_clone_app/app/views/view_choose_mode/view_model/choose_mode_state.dart';
import 'package:spotify_clone_app/app/views/view_choose_mode/view_model/choose_mode_view_model.dart';
import 'package:spotify_clone_app/core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
}

class App extends StatefulWidget {
  
  const App({super.key});


  static void setTheme(BuildContext context, ThemeData newThemeData) {
    final stateTheme = context.findAncestorStateOfType<_AppState>();

    stateTheme?.changeTheme(newThemeData);
  }

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeData _themeData = AppTheme.lightTheme;

  changeTheme(ThemeData themeData) {
    setState(() {
      try {
        _themeData = themeData;
      } catch (e) {
        if (kDebugMode) {
          debugPrint(e.toString());
        }
        rethrow;
      }
    });
  }


  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChooseModeViewModel(),
      child: BlocBuilder<ChooseModeViewModel, ChooseModeState>(
        builder: (context, mode) {
          final themeData = mode is ChooseModeInitialState
              ? mode.themeData
              : AppTheme.lightTheme;
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeData.brightness == Brightness.dark
                ? ThemeMode.dark
                : ThemeMode.light,
            routerConfig: _appRouter.config(
                navigatorObservers: () => [NavigatorObserver()]),
          );
        },
      ),
    );
  }
}
