import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone_app/app/views/view_home/widgets/home_top_card_widget.dart';
import 'package:spotify_clone_app/app/views/view_home/widgets/play_list_widget.dart';
import 'package:spotify_clone_app/core/extensions/context_extension.dart';
import 'package:spotify_clone_app/core/widgets/app_bar.dart';
import 'package:spotify_clone_app/gen/assets.gen.dart';

@RoutePage()
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        hideBack: true,
        onPressed: () {},
        title: SvgPicture.asset(
          Assets.images.svg.spotifyLogo,
          height: context.mediumValue,
          width: context.highValue,
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeTopCardWidget(),
            PlayListWidget(),
          ],
        ),
      ),
    );
  }
}
