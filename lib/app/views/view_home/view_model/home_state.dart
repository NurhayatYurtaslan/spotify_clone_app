import 'package:spotify_clone_app/core/repository/model/songs/songs_model.dart';

abstract class HomeState {
  final List<Song>? songs; // List of Song type
  final List<Song>? filteredSongs;  
  final List<dynamic>? playList; // Suitable type for Playlist items
  final bool showSeeMore;

  HomeState({
    required this.showSeeMore,
    this.songs,
    this.filteredSongs,  
    this.playList,
  });

  HomeState copyWith({
    List<Song>? songs,
    List<Song>? filteredSongs,  
    List<dynamic>? playList,
    bool? showSeeMore,
  });
}

class HomeLoadedState extends HomeState {
  HomeLoadedState({
    super.songs,
    super.playList,
    required super.showSeeMore,
    super.filteredSongs,  
  });

  @override
  HomeLoadedState copyWith({
    List<Song>? songs,
    List<Song>? filteredSongs, 
    List<dynamic>? playList,
    bool? showSeeMore,
  }) {
    return HomeLoadedState(
      songs: songs ?? this.songs,
      filteredSongs: filteredSongs ?? this.filteredSongs,  
      playList: playList ?? this.playList,
      showSeeMore: showSeeMore ?? this.showSeeMore,
    );
  }
}

class HomeLoadingState extends HomeState {
  HomeLoadingState() : super(showSeeMore: false);
  
  @override
  HomeLoadingState copyWith({
    List<Song>? songs,
    List<Song>? filteredSongs,
    List<dynamic>? playList,
    bool? showSeeMore,
  }) {
    return HomeLoadingState(); // Loading state doesn't change
  }
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState({required this.message}) : super(showSeeMore: false);
  
  @override
  HomeErrorState copyWith({
    List<Song>? songs,
    List<Song>? filteredSongs,
    List<dynamic>? playList,
    bool? showSeeMore,
  }) {
    return HomeErrorState(message: message); // Error state doesn't change
  }
}
