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
          // Search Icon on the left
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SongSearchDelegate(state.songs ?? []),
              );
            },
          ),
          // Logo in the center
          Expanded(
            child: Center(
              child: SvgPicture.asset(
                Assets.images.svg.spotifyLogo,
                height: context.mediumValue,
                width: context.highValue,
              ),
            ),
          ),
          // Drawer Icon on the right
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomeState state) {
    if (state.songs == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is HomeErrorState) {
      return Center(child: Text(state.message)); // Hata mesajı göster
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
        height: context.height * .2,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: state.songs!.length,
          itemBuilder: (context, index) {
            final song = state.songs![index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                width: context.width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          song.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.music_note,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      song.title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      // ! Long song name
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      song.artist,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 1,
                      overflow:
                          // ! Long artist name
                          TextOverflow.ellipsis,
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
                    song: song,
                    onFavoritePressed: () {
                      // Favorilere ekleme işlevi burada işlenebilir
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
