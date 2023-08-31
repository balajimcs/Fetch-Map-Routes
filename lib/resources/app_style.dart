import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_dimen.dart';
import 'app_font.dart';

class AppStyles {
  // Light Theme
  static ThemeData lightTheme() {
    final ThemeData base = ThemeData.light();
    Map<int, Color> color = {
      50: const Color.fromRGBO(136, 14, 79, .1),
      100: const Color.fromRGBO(136, 14, 79, .2),
      200: const Color.fromRGBO(136, 14, 79, .3),
      300: const Color.fromRGBO(136, 14, 79, .4),
      400: const Color.fromRGBO(136, 14, 79, .5),
      500: const Color.fromRGBO(136, 14, 79, .6),
      600: const Color.fromRGBO(136, 14, 79, .7),
      700: const Color.fromRGBO(136, 14, 79, .8),
      800: const Color.fromRGBO(136, 14, 79, .9),
      900: const Color.fromRGBO(136, 14, 79, 1),
    };
    return base.copyWith(
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: MaterialColor(0xFF000000, color)),
        primaryColor: AppColors.primaryColor,
        brightness: Brightness.dark,
        primaryColorLight: AppColors.primaryColor,
        primaryColorDark: AppColors.primaryColor,
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        textTheme: base.textTheme
            .apply(bodyColor: AppColors.textColor, fontFamily: 'Poppins'),
        appBarTheme: const AppBarTheme(
          color: Colors.black,
          titleTextStyle: TextStyle(
              fontSize: AppDimen.screenPadding,
              fontFamily: AppFont.font,
              fontWeight: FontWeight.w500,
              color: Colors.white),
          toolbarTextStyle: TextStyle(
              fontSize: AppDimen.screenPadding,
              fontFamily: AppFont.font,
              fontWeight: FontWeight.w500,
              color: Colors.white),
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        snackBarTheme: const SnackBarThemeData(
            contentTextStyle: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.w600,
          fontFamily: AppFont.font,
        )),
        dialogTheme: const DialogTheme(
          contentTextStyle: TextStyle(
            fontFamily: AppFont.font,
            color: AppColors.primaryColor,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(
              color: AppColors.hintTextColor,
              fontWeight: FontWeight.w300,
              fontFamily: AppFont.font),
          labelStyle: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontFamily: AppFont.font),
          errorStyle: TextStyle(
              color: AppColors.red,
              fontWeight: FontWeight.w300,
              fontFamily: AppFont.font),
        ),
        buttonTheme: const ButtonThemeData(buttonColor: Colors.white));
  }

}
