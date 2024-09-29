import 'package:auto_route/auto_route.dart';
import 'package:spotify_clone_app/app/views/view_choose_mode/choose_mode_view.dart';
import 'package:spotify_clone_app/app/views/view_intro/intro_view.dart';
import 'package:spotify_clone_app/app/views/view_splash/splash_view.dart';

part "app_router.gr.dart";

@AutoRouterConfig(
  replaceInRouteName: 'View',
)
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashViewRoute.page, initial: true),
        AutoRoute(page: IntroViewRoute.page),
        AutoRoute(page: ChooseModeViewRoute.page),
      ];
}