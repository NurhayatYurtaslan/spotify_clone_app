import 'package:firebase_core/firebase_core.dart';
import 'package:flavor/flavor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spotify_clone_app/app/app.dart';
import 'package:spotify_clone_app/core/repository/model/songs/songs_model.dart';
import 'package:spotify_clone_app/firebase_options.dart';

const String logLevelKey = "5";

launchApp() async {
  if (kDebugMode) {
    print('LogLevel set for this flavor: $logLevelKey');
  }

  if (Flavor.I.isDevelopment) {
    debugPrint('Development mode');
  }

  // Hive
  await Hive.initFlutter();
  
  // Adapter kaydetme
  Hive.registerAdapter(SongAdapter()); 
  
  // Kutu açmadan önce kontrol et
  if (!Hive.isBoxOpen('favorite')) {
    await Hive.openBox<Song>('favorite'); // Kutu açık değilse aç
  }

  // Diğer kutular
  await Hive.openBox('settings');
  await Hive.openBox('userLocalDB');
  
  // Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  // StatusBar'ı kaldır
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(const App());
}
