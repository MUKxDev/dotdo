import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './colors.dart';

class AppThemes {
  // * lightTheme
  static ThemeData lightTheme = ThemeData(
    textTheme: GoogleFonts.assistantTextTheme().apply(
      bodyColor: AppColors.darkBackground,
      displayColor: AppColors.darkBackground,
    ),
    brightness: Brightness.light,
    primaryColor: AppColors.lightGray,
    accentColor: AppColors.lightPurple,
    colorScheme: ColorScheme.light().copyWith(
      primary: AppColors.lightGreen,
      onPrimary: Colors.white,
    ),
    scaffoldBackgroundColor: AppColors.white,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColors.lightGreen,
      selectionHandleColor: AppColors.lightGreen,
      cursorColor: AppColors.lightGreen,
    ),
    // * Remove this if it went wrong LOL
    cupertinoOverrideTheme: CupertinoThemeData(
      primaryColor: AppColors.lightGreen,
    ),
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
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        borderSide: BorderSide(
          color: AppColors.lightRed,
          width: 2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        borderSide: BorderSide(
          color: AppColors.lightRed.withAlpha(100),
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

  // * darkTheme
  static ThemeData darkTheme = ThemeData(
    // canvasColor: Colors.transparent,
    textTheme: GoogleFonts.assistantTextTheme().apply(
      bodyColor: AppColors.white,
      displayColor: AppColors.white,
    ),
    brightness: Brightness.dark,
    primaryColor: AppColors.darkGray,
    accentColor: AppColors.darkPurple,
    colorScheme: ColorScheme.dark().copyWith(
      primary: AppColors.darkGreen,
      onPrimary: Colors.white,
      surface: AppColors.darkGray,

      // onSurface: AppColors.darkGray,
      // secondary: AppColors.darkGray,
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColors.darkGreen,
      selectionHandleColor: AppColors.darkGreen,
      cursorColor: AppColors.darkGreen,
    ),
    // * Remove this if it went wrong LOL
    cupertinoOverrideTheme: CupertinoThemeData(
      primaryColor: AppColors.darkGreen,
    ),
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
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        borderSide: BorderSide(
          color: AppColors.darkRed,
          width: 2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        borderSide: BorderSide(
          color: AppColors.darkRed.withAlpha(100),
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
