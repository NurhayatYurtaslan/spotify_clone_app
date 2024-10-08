import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotify_clone_app/app/views/view_splash/view_model/splash_event.dart';
import 'package:spotify_clone_app/app/views/view_splash/view_model/splash_state.dart';
import 'package:spotify_clone_app/app/views/view_splash/view_model/splash_view_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_clone_app/gen/assets.gen.dart';

@RoutePage()
class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    //system UI visibility management
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return BlocProvider(
      create: (context) => SplashViewModel()..add(SplashInitialEvent(context)),
      child: BlocBuilder<SplashViewModel, SplashState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SvgPicture.asset(Assets.images.svg.spotifyLogo),
            ),
          );
        },
      ),
    );
  }
}
