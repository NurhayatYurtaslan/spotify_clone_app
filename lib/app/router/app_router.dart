import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spotify_clone_app/app/views/view_choose_mode/choose_mode_view.dart';
import 'package:spotify_clone_app/app/views/view_explore/explore_view.dart';
import 'package:spotify_clone_app/app/views/view_favorite/favorite_view.dart';
import 'package:spotify_clone_app/app/views/view_home/home_view.dart';
import 'package:spotify_clone_app/app/views/view_intro/intro_view.dart';
import 'package:spotify_clone_app/app/views/view_profile/profile_view.dart';
import 'package:spotify_clone_app/app/views/view_settings/settings_view.dart';
import 'package:spotify_clone_app/app/views/view_signin/signin_view.dart';
import 'package:spotify_clone_app/app/views/view_signin_or_signup/signin_or_signup_view.dart';
import 'package:spotify_clone_app/app/views/view_signup/signup_view.dart';
import 'package:spotify_clone_app/app/views/view_splash/splash_view.dart';
import 'package:spotify_clone_app/core/widgets/navbar_widget.dart';

part "app_router.gr.dart";

@AutoRouterConfig(
  replaceInRouteName: 'View',
)
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          initial: true,
          page: SplashViewRoute.page,
        ),
        AutoRoute(page: IntroViewRoute.page),
        AutoRoute(page: ChooseModeViewRoute.page),
        AutoRoute(page: SigninOrSignupViewRoute.page),
        AutoRoute(page: SigninViewRoute.page),
        AutoRoute(page: SignupViewRoute.page),
        AutoRoute(page: SettingsViewRoute.page),
        AutoRoute(page: NavBarViewRoute.page, 
        children: [
          AutoRoute(
            page: HomeViewRoute.page,
          ),
          AutoRoute(page: ExploreViewRoute.page),
          AutoRoute(page: FavoriteViewRoute.page),
          AutoRoute(page: ProfileViewRoute.page),
        ]),
      ];
}
