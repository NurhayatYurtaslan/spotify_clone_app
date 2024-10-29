import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spotify_clone_app/app/router/app_router.dart';
import 'package:spotify_clone_app/core/extensions/context_extension.dart';
import 'package:spotify_clone_app/gen/assets.gen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Image.asset(
                Assets.images.png.drawerImage.path,
                width: context.width * .2,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home Page"),
            onTap: () {
              // ! Set the active tab to Home
              final tabsRouter = AutoTabsRouter.of(context);
              tabsRouter.setActiveIndex(0); // Assuming Home is at index 0
              Navigator.of(context).pop(); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
            onTap: () {
              // ! Set the active tab to Profile
              final tabsRouter = AutoTabsRouter.of(context);
              tabsRouter.setActiveIndex(3); // Assuming Profile is at index 3
              Navigator.of(context).pop(); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {
              context.router.replace(const SettingsViewRoute());
            },
          ),
        ],
      ),
    );
  }
}
