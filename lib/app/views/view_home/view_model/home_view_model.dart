import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_app/app/views/view_home/view_model/home_event.dart';
import 'package:spotify_clone_app/app/views/view_home/view_model/home_state.dart';

class HomeViewModel extends Bloc<HomeEvent, HomeState> {
  HomeViewModel() : super(HomeInitialState(songs: [], showSeeMore: true)) {
    on<HomeInitialEvent>(_initial);
    on<SeeMoreEvent>(_seeMore);
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _initial(HomeInitialEvent event, Emitter<HomeState> emit) async {
    try {
      QuerySnapshot snapshot = await firestore.collection('Songs').get();

      if (snapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> songs = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        print("Fetched Songs: $songs");
        songs.shuffle();
        emit(HomeInitialState(songs: songs, showSeeMore: true)); // Şarkıları emit et
      } else {
        emit(HomeInitialState(songs: [], showSeeMore: false));
      }
    } catch (e) {
      emit(HomeInitialState(songs: [], showSeeMore: false));
    }
  }

  void _seeMore(SeeMoreEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(showSeeMore: false)); // See More'u gizle
  }
}
