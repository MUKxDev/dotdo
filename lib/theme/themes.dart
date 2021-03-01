import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './colors.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    textTheme: GoogleFonts.assistantTextTheme().apply(
      bodyColor: AppColors.darkBackground,
      displayColor: AppColors.darkBackground,
    ),
    brightness: Brightness.light,
    primaryColor: AppColors.lightGray,
    accentColor: AppColors.lightPurple,
    scaffoldBackgroundColor: AppColors.white,
    textSelectionHandleColor: AppColors.lightGreen,
    cursorColor: AppColors.lightGreen,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightGray,
      labelStyle: TextStyle(color: AppColors.lightPurple),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        borderSide: BorderSide(
          color: AppColors.lightPurple,
          width: 2,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        borderSide: BorderSide.none,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    textTheme: GoogleFonts.assistantTextTheme().apply(
      bodyColor: AppColors.white,
      displayColor: AppColors.white,
    ),
    brightness: Brightness.dark,
    primaryColor: AppColors.darkGray,
    accentColor: AppColors.darkPurple,
    scaffoldBackgroundColor: AppColors.darkBackground,
    textSelectionHandleColor: AppColors.darkGreen,
    cursorColor: AppColors.darkGreen,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkGray,
      labelStyle: TextStyle(color: AppColors.darkPurple),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        borderSide: BorderSide(
          color: AppColors.darkPurple,
          width: 2,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
