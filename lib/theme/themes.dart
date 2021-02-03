import 'package:flutter/material.dart';
import './colors.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightGray,
    accentColor: AppColors.lightRed,
    scaffoldBackgroundColor: AppColors.white,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkGray,
    accentColor: AppColors.darkRed,
    scaffoldBackgroundColor: AppColors.darkBackground,
  );
}
