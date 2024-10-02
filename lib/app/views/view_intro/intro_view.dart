import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_clone_app/app/views/view_intro/view_model/intro_event.dart';
import 'package:spotify_clone_app/app/views/view_intro/view_model/intro_state.dart';
import 'package:spotify_clone_app/app/views/view_intro/view_model/intro_view_model.dart';
import 'package:spotify_clone_app/core/constants/color_constants.dart';
import 'package:spotify_clone_app/core/extensions/context_extension.dart';
import 'package:spotify_clone_app/core/widgets/basic_app_button.dart';
import 'package:spotify_clone_app/gen/assets.gen.dart';

@RoutePage()
class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    //system UI visibility management
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return BlocProvider(
      create: (context) => IntroViewModel(),
      child: BlocBuilder<IntroViewModel, IntroState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Assets.images.png.introBg.path),
                          fit: BoxFit.fill)),
                ),
                Container(
                  color: Colors.black.withOpacity(0.15),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: context.mediumValue,
                      horizontal: context.mediumValue),
                  child: Column(
                    children: [
                      context.sizedHeightBoxHigh,
                      Align(
                        alignment: Alignment.topCenter,
                        child: SvgPicture.asset(Assets.images.svg.spotifyLogo),
                      ),
                      const Spacer(),
                      const Text(
                        'Enjoy Listening To Music',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 21),
                      ),
                      Padding(
                        padding: context.paddingMedium,
                        child: const Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey,
                              fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      BasicAppButton(
                        onPressed: () {
                          context
                              .read<IntroViewModel>()
                              .add(GetStartedEvent(context));
                        },
                        title: 'Get Started',
                        
                        
                      ),
                      context.sizedHeightBoxExtraHigh
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
