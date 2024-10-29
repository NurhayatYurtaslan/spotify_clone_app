import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_app/app/views/view_home/view_model/home_event.dart';
import 'package:spotify_clone_app/app/views/view_home/view_model/home_state.dart';
import 'package:spotify_clone_app/core/repository/model/songs/songs_model.dart';

class HomeViewModel extends Bloc<HomeEvent, HomeState> {
  HomeViewModel() : super(HomeLoadingState()) {
    on<HomeInitialEvent>(_initial);
    on<SeeMoreEvent>(_seeMore);
    on<SeeLessEvent>(_seeLess);
    on<SearchEvent>(_search);
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _initial(HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      QuerySnapshot snapshot = await firestore.collection('Songs').get();

      if (snapshot.docs.isNotEmpty) {
        List<Song> songs = snapshot.docs
            .map((doc) => Song.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
        songs.shuffle();

        emit(HomeLoadedState(songs: songs, filteredSongs: songs, showSeeMore: false));
      } else {
        emit(HomeLoadedState(songs: [], filteredSongs: [], showSeeMore: false));
      }
    } catch (e) {
      emit(HomeErrorState(message: "Unable to fetch songs. Please try again later."));
    }
  }

  void _seeMore(SeeMoreEvent event, Emitter<HomeState> emit) {
    if (!state.showSeeMore) {
      emit(state.copyWith(showSeeMore: true));
    }
  }

  void _seeLess(SeeLessEvent event, Emitter<HomeState> emit) {
    if (state.showSeeMore) {
      emit(state.copyWith(showSeeMore: false));
    }
  }

  void _search(SearchEvent event, Emitter<HomeState> emit) {
    final query = event.query.toLowerCase();
    final filteredSongs = state.songs?.where((song) {
      final title = song.title.toLowerCase();
      final artist = song.artist.toLowerCase();
      return title.contains(query) || artist.contains(query);
    }).toList();

    emit(state.copyWith(filteredSongs: filteredSongs ?? []));
  }
}
