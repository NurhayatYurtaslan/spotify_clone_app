import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spotify_clone_app/app/router/app_router.dart';

@RoutePage()
class NavBarView extends StatelessWidget {
  const NavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        HomeViewRoute(),
        const ExploreViewRoute(),
        const FavoriteViewRoute(),
        const ProfileViewRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          iconSize: 32,
          items: bottomNavItems,
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
        );
      },
    );
  }
}

List<BottomNavigationBarItem> bottomNavItems = <BottomNavigationBarItem>[
  const BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
  const BottomNavigationBarItem(
      icon: Icon(Icons.explore_outlined), label: "Explore"),
  const BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
  const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
];
