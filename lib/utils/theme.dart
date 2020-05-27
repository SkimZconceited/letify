import 'package:flutter/material.dart';

ThemeData _themeData = ThemeData.light();

ThemeData buildTheme() {
  return _themeData.copyWith(
      primaryColor: letifyWhite,
      textTheme: _textTheme,
      buttonTheme: ButtonThemeData(),
      buttonColor: letifyPink,
      scaffoldBackgroundColor: letifyWhite,
      iconTheme: IconThemeData(color: letifyBlack, size: 24.0));
}

TextTheme _textTheme = _themeData.textTheme.copyWith(
  headline5: TextStyle(color: letifyGreen),
);
//red button theme
ButtonThemeData redButtonData = ButtonThemeData(
    buttonColor: letifyGreen,
    shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(10))));
//app colors
const Color letifyWhite = const Color(0xFFFFFFFF);
const Color letifyBlack = const Color(0xFF000000);
const Color letifyPink = const Color(0xFFFC5185);
const Color letifyGreen = const Color(0xFF1DB38C);
