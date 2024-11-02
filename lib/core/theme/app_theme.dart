import 'package:flutter/material.dart';
import 'package:spotify_clone_app/core/constants/color_constants.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: false,
      backgroundColor: AppColors.lightBackground,
      unselectedIconTheme: IconThemeData(color: AppColors.darkBackground),
      selectedIconTheme: IconThemeData(
        color: AppColors.primary,
        size: 36,
      ),
    ),

    drawerTheme:
        const DrawerThemeData(backgroundColor: AppColors.lightBackground),
    dividerColor: AppColors.darkBackground,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    brightness: Brightness.light,
    sliderTheme: SliderThemeData(overlayShape: SliderComponentShape.noOverlay),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(30),
      hintStyle: const TextStyle(
        color: Color(0xff383838),
        fontWeight: FontWeight.w500,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.white, width: 0.4),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.black, width: 0.4),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        elevation: 0,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.darkGrey, 
      ),
    ),
  );

  static final darkTheme = ThemeData(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        showSelectedLabels: false,
        backgroundColor: AppColors.darkBackground,
        unselectedIconTheme: IconThemeData(color: AppColors.lightBackground),
        selectedIconTheme: IconThemeData(color: AppColors.primary, size: 36)),
    drawerTheme:
        const DrawerThemeData(backgroundColor: AppColors.darkBackground),
    dividerColor: Colors.white,
    primaryColor: AppColors.darkBackground,
    scaffoldBackgroundColor: AppColors.darkBackground,
    brightness: Brightness.dark,
    fontFamily: 'Satoshi',
    sliderTheme: SliderThemeData(
      overlayShape: SliderComponentShape.noOverlay,
      activeTrackColor: const Color(0xffB7B7B7),
      inactiveTrackColor: Colors.grey.withOpacity(0.3),
      thumbColor: const Color(0xffB7B7B7),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      hintStyle: const TextStyle(
        color: Color(0xffA7A7A7),
        fontWeight: FontWeight.w500,
      ),
      contentPadding: const EdgeInsets.all(30),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.white, width: 0.4),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.white, width: 0.4),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: AppColors.lightBackground,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
    
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.white, 
      ),
    ),
  );
}
