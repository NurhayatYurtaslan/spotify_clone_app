import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone_app/app/views/view_home/view_model/home_event.dart';
import 'package:spotify_clone_app/app/views/view_home/view_model/home_state.dart';
import 'package:spotify_clone_app/app/views/view_home/view_model/home_view_model.dart';
import 'package:spotify_clone_app/app/views/view_home/widgets/home_top_card_widget.dart';
import 'package:spotify_clone_app/app/views/view_home/widgets/play_list_widget.dart';
import 'package:spotify_clone_app/core/constants/color_constants.dart';
import 'package:spotify_clone_app/core/extensions/context_extension.dart';
import 'package:spotify_clone_app/core/helpers/is_dark_mode.dart';
import 'package:spotify_clone_app/core/widgets/app_bar.dart';
import 'package:spotify_clone_app/gen/assets.gen.dart';

@RoutePage()
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeViewModel()..add(HomeInitialEvent()),
      child: BlocBuilder<HomeViewModel, HomeState>(
        builder: (context, state) {
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
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const HomeTopCardWidget(),
                  PlayListWidget(
                    showSeeMore: state.showSeeMore,
                    onSeeMorePressed: () {
                      context.read<HomeViewModel>().add(SeeMoreEvent());
                    },
                    text: state.showSeeMore ? 'Less More' : 'See More',
                    onSeeLessPressed: () {
                      context.read<HomeViewModel>().add(SeeLessEvent());
                    },
                  ),
                  if (state.songs == null)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  else if (state.songs!.isEmpty)
                    const Center(
                      child: Text(
                        "Şarkı bulunamadı",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  else
                    SizedBox(
                      height: 400, // Listeyi gösterecek alan
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.showSeeMore ? state.songs!.length : 3,
                        itemBuilder: (context, index) {
                          final song = state.songs![index];

                          return ListTile(
                            leading: Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: context.isDarkMode
                                    ? AppColors.darkGrey
                                    : AppColors.grey,
                              ),
                              child: Icon(
                                Icons.play_arrow_rounded,
                                color: context.isDarkMode
                                    ? AppColors.grey
                                    : AppColors.darkGrey,
                              ),
                            ),
                            title: Text(
                              song['title'] ?? 'Unknown Title',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            subtitle: Text(
                              song['artist'] ?? 'Unknown Artist',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 11),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  (song['duration'] ?? 0.0).toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.favorite,
                                    color: context.isDarkMode
                                        ? AppColors.darkGrey
                                        : AppColors.grey,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
