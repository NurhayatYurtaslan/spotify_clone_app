import 'package:flavor/flavor.dart';
import 'package:flutter/material.dart';
import 'package:spotify_clone_app/starter.dart';

Future<void> main(List<String> args) async {


  Flavor.create(
    Environment.dev,
    name: "Dev",
    color: Colors.orange,
  );
  launchApp();
}
