import 'package:firebase_core/firebase_core.dart';
import 'package:flavor/flavor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spotify_clone_app/app/app.dart';
import 'package:spotify_clone_app/firebase_options.dart';

const String logLevelKey = "5";
launchApp() async {
  if (kDebugMode) {
    if (kDebugMode) {
      print('LogLevel set for this flavor:$logLevelKey');
    }
  }

  if (Flavor.I.isDevelopment) {
    if (kDebugMode) {
      debugPrint('Development mode');
    }
  }

  //Hive
  await Hive.initFlutter();
  await Hive.openBox('favorite');
  await Hive.openBox('settings');
  await Hive.openBox('userLocalDB');
  //Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //Remove StatusBar
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(const App());
}
