import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone_app/app/views/view_signin_or_signup/view_model/signin_or_signup_event.dart';
import 'package:spotify_clone_app/app/views/view_signin_or_signup/view_model/signin_or_signup_state.dart';
import 'package:spotify_clone_app/app/views/view_signin_or_signup/view_model/signin_or_signup_view_model.dart';
import 'package:spotify_clone_app/core/constants/color_constants.dart';
import 'package:spotify_clone_app/core/helpers/is_dark_mode.dart';
import 'package:spotify_clone_app/core/widgets/app_bar.dart';
import 'package:spotify_clone_app/core/widgets/basic_app_button.dart';
import 'package:spotify_clone_app/gen/assets.gen.dart';

@RoutePage()
class SigninOrSignupView extends StatelessWidget {
  const SigninOrSignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninOrSignupViewModel(),
      child: BlocBuilder<SigninOrSignupViewModel, SigninOrSignupState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                BasicAppbar(
                  onPressed: () {
                    // Ensure that this is being called
                    context.read<SigninOrSignupViewModel>().add(BackEvent(
                        context)); // This should trigger the BackEvent
                  },
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(Assets.icons.svg.topPattern),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SvgPicture.asset(Assets.icons.svg.bottomPattern),
                ),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Image.asset(Assets.images.png.authBg.path)),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(Assets.images.svg.spotifyLogo),
                          const SizedBox(height: 55),
                          const Text(
                            'Enjoy Listening To Music',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(height: 21),
                          const Text(
                            'Spotify is a proprietary Swedish audio streaming and media services provider ',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: AppColors.grey),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: BasicAppButton(
                                  onPressed: () {
                                    context
                                        .read<SigninOrSignupViewModel>()
                                        .add(NavigateToSignupEvent(context));
                                  },
                                  title: 'Register',
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                flex: 1,
                                child: TextButton(
                                  onPressed: () {
                                    // Dispatch the event to navigate to sign-in
                                    context
                                        .read<SigninOrSignupViewModel>()
                                        .add(NavigateToSigninEvent(context));
                                  },
                                  child: Text(
                                    'Sign in',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: context.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
