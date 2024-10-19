import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore paketini içe aktar
import 'package:spotify_clone_app/app/views/view_home/view_model/home_event.dart';
import 'package:spotify_clone_app/app/views/view_home/view_model/home_state.dart';

class HomeViewModel extends Bloc<HomeEvent, HomeState> {
  HomeViewModel() : super(HomeInitialState(songs: [])) {
    on<HomeInitialEvent>(_initial);
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance; // Firestore referansı

  Future<FutureOr<void>> _initial(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    try {
      // Firestore'dan 'Songs' koleksiyonunu al
      QuerySnapshot snapshot = await firestore.collection('Songs').get();

      if (snapshot.docs.isNotEmpty) {
        // Şarkıları Map formatında al ve listeye dönüştür
        List<Map<String, dynamic>> songs = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
        print("Fetched Songs: $songs");  // Veriyi kontrol için yazdır
        songs.shuffle(); // Şarkıları karıştır
        emit(HomeInitialState(songs: songs)); // Şarkıları emit et
      } else {
        print("No songs found.");
        emit(HomeInitialState(songs: [])); // Boş liste emit et
      }
    } on FirebaseException catch (e) {
      // Firestore'a özel hataları yakalayın
      print("FirebaseException: ${e.message}"); // Hata mesajını yazdır
      emit(HomeInitialState(songs: [])); // Hata durumunda boş liste emit et
    } catch (e, stackTrace) {
      // Diğer genel hataları yakalayın
      print("General Error: ${e.toString()}");
      print("Stack Trace: $stackTrace");  // Stack trace'i yazdır
      emit(HomeInitialState(songs: [])); // Hata durumunda boş liste emit et
    }
  }
}
