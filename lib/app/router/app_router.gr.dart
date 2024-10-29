// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [ChooseModeView]
class ChooseModeViewRoute extends PageRouteInfo<void> {
  const ChooseModeViewRoute({List<PageRouteInfo>? children})
      : super(
          ChooseModeViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChooseModeViewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ChooseModeView();
    },
  );
}

/// generated route for
/// [ExploreView]
class ExploreViewRoute extends PageRouteInfo<void> {
  const ExploreViewRoute({List<PageRouteInfo>? children})
      : super(
          ExploreViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExploreViewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ExploreView();
    },
  );
}

/// generated route for
/// [FavoriteView]
class FavoriteViewRoute extends PageRouteInfo<void> {
  const FavoriteViewRoute({List<PageRouteInfo>? children})
      : super(
          FavoriteViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoriteViewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FavoriteView();
    },
  );
}

/// generated route for
/// [HomeView]
class HomeViewRoute extends PageRouteInfo<HomeViewRouteArgs> {
  HomeViewRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          HomeViewRoute.name,
          args: HomeViewRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'HomeViewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeViewRouteArgs>(
          orElse: () => const HomeViewRouteArgs());
      return HomeView(key: args.key);
    },
  );
}

class HomeViewRouteArgs {
  const HomeViewRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'HomeViewRouteArgs{key: $key}';
  }
}

/// generated route for
/// [IntroView]
class IntroViewRoute extends PageRouteInfo<void> {
  const IntroViewRoute({List<PageRouteInfo>? children})
      : super(
          IntroViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'IntroViewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const IntroView();
    },
  );
}

/// generated route for
/// [NavBarView]
class NavBarViewRoute extends PageRouteInfo<void> {
  const NavBarViewRoute({List<PageRouteInfo>? children})
      : super(
          NavBarViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'NavBarViewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NavBarView();
    },
  );
}

/// generated route for
/// [ProfileView]
class ProfileViewRoute extends PageRouteInfo<void> {
  const ProfileViewRoute({List<PageRouteInfo>? children})
      : super(
          ProfileViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileViewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileView();
    },
  );
}

/// generated route for
/// [SettingsView]
class SettingsViewRoute extends PageRouteInfo<void> {
  const SettingsViewRoute({List<PageRouteInfo>? children})
      : super(
          SettingsViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsViewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsView();
    },
  );
}

/// generated route for
/// [SigninOrSignupView]
class SigninOrSignupViewRoute extends PageRouteInfo<void> {
  const SigninOrSignupViewRoute({List<PageRouteInfo>? children})
      : super(
          SigninOrSignupViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'SigninOrSignupViewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SigninOrSignupView();
    },
  );
}

/// generated route for
/// [SigninView]
class SigninViewRoute extends PageRouteInfo<void> {
  const SigninViewRoute({List<PageRouteInfo>? children})
      : super(
          SigninViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'SigninViewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SigninView();
    },
  );
}

/// generated route for
/// [SignupView]
class SignupViewRoute extends PageRouteInfo<void> {
  const SignupViewRoute({List<PageRouteInfo>? children})
      : super(
          SignupViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupViewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignupView();
    },
  );
}

/// generated route for
/// [SplashView]
class SplashViewRoute extends PageRouteInfo<void> {
  const SplashViewRoute({List<PageRouteInfo>? children})
      : super(
          SplashViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashViewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashView();
    },
  );
}
