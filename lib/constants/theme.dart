import 'package:errandbuddy/constants/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    primaryColor: AppColors.primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundLight,
      foregroundColor: AppColors.darkTeal,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: AppColors.secondaryText),
    ),

    cardColor: AppColors.cardColor,
    iconTheme: const IconThemeData(color: AppColors.darkTeal),
  );

//  check need of dark theme 
  // static final ThemeData dark = ThemeData(
  //   brightness: Brightness.dark,
  //   scaffoldBackgroundColor: AppColors.backgroundLight,
  //   primaryColor: AppColors.darkTeal,
  //   appBarTheme: const AppBarTheme(
  //     backgroundColor: AppColors.darkTeal,
  //     foregroundColor: Colors.white,
  //     elevation: 0,
  //   ),
  //   textTheme: const TextTheme(
  //     bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
  //   ),
  //   cardColor: AppColors.cardColor,
  //   iconTheme: const IconThemeData(color: Colors.white),
  // );
}
