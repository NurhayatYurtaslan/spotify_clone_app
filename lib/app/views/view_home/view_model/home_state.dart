abstract class HomeState {
  final List<dynamic>? songs;
  final List<dynamic>? playList;
  final bool showSeeMore;

  HomeState({
    required this.showSeeMore,
    this.songs,
    this.playList,
  });

  HomeState copyWith({
    List<dynamic>? songs,
    List<dynamic>? playList,
    bool? showSeeMore,
  });
}

class HomeInitialState extends HomeState {
  HomeInitialState({super.songs, super.playList, required super.showSeeMore});

  @override
  HomeInitialState copyWith({
    List<dynamic>? songs,
    List<dynamic>? playList,
    bool? showSeeMore,
  }) {
    return HomeInitialState(
      songs: songs ?? this.songs,
      playList: playList ?? this.playList,
      showSeeMore: showSeeMore ?? this.showSeeMore,
    );
  }
}

class SeeMoreState extends HomeState {
  SeeMoreState({super.songs, super.playList, required super.showSeeMore});

  @override
  SeeMoreState copyWith({
    List<dynamic>? songs,
    List<dynamic>? playList,
    bool? showSeeMore,
  }) {
    return SeeMoreState(
      songs: songs ?? this.songs,
      playList: playList ?? this.playList,
      showSeeMore: showSeeMore ?? this.showSeeMore,
    );
  }
}

class SeeLessState extends HomeState {
  SeeLessState({super.songs, super.playList, required super.showSeeMore});

  @override
  SeeLessState copyWith({
    List<dynamic>? songs,
    List<dynamic>? playList,
    bool? showSeeMore,
  }) {
    return SeeLessState(
      songs: songs ?? this.songs,
      playList: playList ?? this.playList,
      showSeeMore: showSeeMore ?? this.showSeeMore,
    );
  }
}
