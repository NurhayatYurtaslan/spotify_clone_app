import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone_app/app/views/view_choose_mode/view_model/choose_mode_event.dart';
import 'package:spotify_clone_app/app/views/view_choose_mode/view_model/choose_mode_state.dart';
import 'package:spotify_clone_app/app/views/view_choose_mode/view_model/choose_mode_view_model.dart';
import 'package:spotify_clone_app/core/constants/color_constants.dart';
import 'package:spotify_clone_app/core/widgets/basic_app_button.dart';
import 'package:spotify_clone_app/gen/assets.gen.dart';

class ChooseModeView extends StatelessWidget {
  const ChooseModeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChooseModeViewModel, ChooseModeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.lightBackground,
          body: Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(Assets.images.png.chooseModeBg.path),
                  ),
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.15),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: SvgPicture.asset(Assets.images.svg.spotifyLogo),
                    ),
                    const Spacer(),
                    const Text(
                      'Choose Mode',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildThemeOption(
                          context,
                          'Dark Mode',
                          Assets.icons.svg.moon,
                          () {
                            context.read<ChooseModeViewModel>().add(ChooseModeDarkEvent());
                          },
                        ),
                        const SizedBox(width: 40),
                        _buildThemeOption(
                          context,
                          'Light Mode',
                          Assets.icons.svg.sun,
                          () {
                            context.read<ChooseModeViewModel>().add(ChooseModeLightEvent());
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    BasicAppButton(
                      onPressed: () {
                        // Handle continue button action here
                      },
                      title: 'Continue',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildThemeOption(BuildContext context, String label, String assetPath, VoidCallback onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: const Color(0xff30393C).withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  assetPath,
                  fit: BoxFit.none,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
}
