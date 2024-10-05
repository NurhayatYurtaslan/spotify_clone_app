import 'package:firebase_core/firebase_core.dart';
import 'package:flavor/flavor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotify_clone_app/firebase_options.dart';
import 'package:spotify_clone_app/starter.dart';

Future<void> main(List<String> args) async {
  SystemChrome.setSystemUIOverlayStyle(
      // statusBar kaldırmak için
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  Flavor.create(
    Environment.dev,
    name: "Dev",
    color: Colors.orange,
  );
  launchApp();
}
