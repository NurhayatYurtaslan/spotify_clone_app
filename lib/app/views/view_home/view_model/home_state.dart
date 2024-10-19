abstract class HomeState {
  List<dynamic>? songs;
  List<dynamic>? playList;
  HomeState({this.songs, this.playList});
}

class HomeInitialState extends HomeState {
  List<dynamic>? songs;
  List<dynamic>? playList;
  HomeInitialState({this.songs, this.playList})
      : super(songs: songs, playList: playList);
}

//add favorite state