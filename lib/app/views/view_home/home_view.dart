import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_clone_app/app/views/view_home/view_model/home_event.dart';
import 'package:spotify_clone_app/app/views/view_home/view_model/home_state.dart';
import 'package:spotify_clone_app/app/views/view_home/view_model/home_view_model.dart';
import 'package:spotify_clone_app/app/views/view_home/widgets/home_top_card_widget.dart';
import 'package:spotify_clone_app/app/views/view_home/widgets/play_list_widget.dart';
import 'package:spotify_clone_app/app/views/view_home/widgets/song_search_delegate_widget.dart';
import 'package:spotify_clone_app/app/views/view_home/widgets/song_tile_widget.dart';
import 'package:spotify_clone_app/core/constants/color_constants.dart';
import 'package:spotify_clone_app/core/extensions/context_extension.dart';
import 'package:spotify_clone_app/core/widgets/app_bar.dart';
import 'package:spotify_clone_app/core/widgets/drawer_widget.dart';
import 'package:spotify_clone_app/gen/assets.gen.dart';

@RoutePage()
class HomeView extends StatelessWidget {
  HomeView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeViewModel()..add(HomeInitialEvent()),
      child: BlocBuilder<HomeViewModel, HomeState>(
        builder: (context, state) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: _buildAppBar(context, state),
            endDrawer: const DrawerWidget(),
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  BasicAppbar _buildAppBar(BuildContext context, HomeState state) {
    return BasicAppbar(
      hideBack: true,
      onPressed: () {},
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SongSearchDelegate(state.songs ?? []),
              );
            },
          ),
          Expanded(
            child: Center(
              child: SvgPicture.asset(
                Assets.images.svg.spotifyLogo,
                height: context.mediumValue,
                width: context.highValue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomeState state) {
    if (state.songs == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is HomeErrorState) {
      return Center(child: Text(state.message));
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          const HomeTopCardWidget(),
          context.sizedHeightBoxNormal,
          _buildSongList(context, state),
          _buildPlayList(context, state),
        ],
      ),
    );
  }

  Widget _buildSongList(BuildContext context, HomeState state) {
    return Padding(
      padding: EdgeInsets.only(left: context.mediumValue),
      child: SizedBox(
        width: context.width,
        height: context.height * .30,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: state.songs!.length,
          itemBuilder: (context, index) {
            final song = state.songs![index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: context.lowValue),
              child: SizedBox(
                width: context.width * 0.4,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(context.mediumValue * .7),
                            child: Image.network(
                              song.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.music_note);
                              },
                            ),
                          ),
                        ),
                        context.sizedHeightBoxLow,
                        Text(
                          song.title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          song.artist,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: context.height * 0.038,
                      left: context.width * 0.24,
                      child: IconButton(
                        icon: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(context.mediumValue),
                              color: AppColors.darkBackground),
                          child: Padding(
                            padding: EdgeInsets.all(context.lowValue),
                            child: Icon(Icons.play_arrow,
                                size: context.width * 0.1,
                                color: AppColors.lightBackground),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPlayList(BuildContext context, HomeState state) {
    return Padding(
      padding: EdgeInsets.only(left: context.mediumValue),
      child: Column(
        children: [
          PlayListWidget(
            showSeeMore: state.showSeeMore,
            onSeeMorePressed: () {
              context.read<HomeViewModel>().add(SeeMoreEvent());
            },
            text: state.showSeeMore ? 'See Less' : 'See More',
            onSeeLessPressed: () {
              context.read<HomeViewModel>().add(SeeLessEvent());
            },
          ),
          AnimatedContainer(
            duration: context.durationMedium,
            height: state.showSeeMore ? null : context.highValue * 5,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.showSeeMore ? state.songs!.length : 3,
              itemBuilder: (context, index) {
                final song = state.songs![index];
                return SizedBox(
                    width: context.width,
                    child: SongTile(
                      songs: [song], // Tek bir şarkı nesnesi geçiyoruz     
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
