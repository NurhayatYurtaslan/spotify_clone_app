import 'package:flavor/flavor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spotify_clone_app/app/app.dart';


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
  
  runApp(const App());
}