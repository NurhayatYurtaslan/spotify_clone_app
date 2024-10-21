abstract class HomeState {
  final List<dynamic>? songs;
  final List<dynamic>? playList;
  final bool showSeeMore;  // Yeni eklenen alan

  HomeState({this.songs, this.playList, required this.showSeeMore});

  HomeState copyWith({
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

class HomeInitialState extends HomeState {
  HomeInitialState({super.songs, super.playList, required super.showSeeMore});
}

class SeeMoreState extends HomeState {
  SeeMoreState({super.songs, super.playList, required super.showSeeMore});
}
