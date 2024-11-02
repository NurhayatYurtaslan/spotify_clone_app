import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:spotify_clone_app/app/views/view_choose_mode/view_model/choose_mode_event.dart';
import 'package:spotify_clone_app/app/views/view_choose_mode/view_model/choose_mode_state.dart';
import 'package:spotify_clone_app/app/views/view_choose_mode/view_model/choose_mode_view_model.dart';
import 'package:spotify_clone_app/core/constants/color_constants.dart';
import 'package:spotify_clone_app/core/extensions/context_extension.dart';
import 'package:spotify_clone_app/core/widgets/basic_app_button.dart';
import 'package:spotify_clone_app/gen/assets.gen.dart';

const String settingsBox = 'settings';
const String isDarkKey = 'isDark';
const String isLightKey = 'isLight';

@RoutePage()
class ChooseModeView extends StatelessWidget {
  const ChooseModeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChooseModeViewModel(),
      child: BlocBuilder<ChooseModeViewModel, ChooseModeState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.lightBackground,
            body: Stack(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
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
                  padding: EdgeInsets.symmetric(
                      vertical: context.highValue * 0.7,
                      horizontal: context.mediumValue),
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
                      ValueListenableBuilder(
                        valueListenable: Hive.box(settingsBox).listenable(),
                        builder: (context, box, child) {
                          final isDark =
                              box.get(isDarkKey, defaultValue: false);
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildModeButton(
                                context: context,
                                label: 'Dark Mode',
                                isSelected: isDark,
                                icon: Assets.icons.svg.moon,
                                onTap: () {
                                  box.put(isDarkKey, true);
                                  box.put(isLightKey, false);
                                },
                              ),
                              context.sizedWidthBoxHigh,
                              _buildModeButton(
                                context: context,
                                label: 'Light Mode',
                                isSelected: !isDark,
                                icon: Assets.icons.svg.sun,
                                onTap: () {
                                  box.put(isDarkKey, false);
                                  box.put(isLightKey, true);
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 50),
                      BasicAppButton(
                        onPressed: () {
                          context
                              .read<ChooseModeViewModel>()
                              .add(ChooseModeInitialEvent(context));
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
      ),
    );
  }

  Widget _buildModeButton({
    required BuildContext context,
    required String label,
    required bool isSelected,
    required String icon,
    required VoidCallback onTap,
  }) {
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
                  icon,
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
