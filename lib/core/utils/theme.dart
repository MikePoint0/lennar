
import 'package:lennar/core/utils/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightThemeData (){
    return ThemeData(
      textSelectionTheme:
      TextSelectionThemeData(cursorColor: Colors.indigoAccent),
      fontFamily: 'Avenir',
      primaryColor: Colors.white,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      // scaffoldBackgroundColor: AppColors.background,
      focusColor: Colors.indigoAccent,
      hintColor: Colors.black,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      dividerColor: Colors.transparent,
    );
  }
}
