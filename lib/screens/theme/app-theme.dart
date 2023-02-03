import 'package:flutter/material.dart';
import '../../util/constants/constants.dart';

class AppTheme {

  AppTheme._();

  static ThemeData themeData = ThemeData(
    colorScheme: _colorScheme,
    textTheme: _textTheme(_colorScheme),
    // toggleableActiveColor: primaryColor,
    primaryColor: primaryColor,
    fontFamily: 'Gilroy',
    highlightColor: Colors.transparent,
    scaffoldBackgroundColor: backgroundColor,
    dialogTheme: _dialogTheme,
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(whiteColor),
      fillColor: MaterialStateProperty.all(primaryColor),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.6)),
      side:  BorderSide(
        width: 0.9,
        color: const Color(0xFF000000).withOpacity(0.4),
      ),
    ),
    sliderTheme: SliderThemeData(
      trackHeight: 1.2,
      thumbColor: primaryColor,
      activeTrackColor: primaryColor,
      overlayColor: primaryColor.withOpacity(0.1),
      thumbShape: const RoundSliderThumbShape(
        disabledThumbRadius: 5.5,
        enabledThumbRadius: 5.5,
      ),
      valueIndicatorColor: primaryColor,
      valueIndicatorTextStyle: const TextStyle(
        fontWeight: FontWeight.w500, fontSize: 13, color: whiteColor),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: whiteColor,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: neutralColor,
      ),
    ),
  );

  static const ColorScheme _colorScheme = ColorScheme(
    primary: primaryColor,
    background: backgroundColor,
    brightness: Brightness.light,
    secondary: neutralColor,
    surface: primaryColor,
    onBackground: backgroundColor,
    onError: errorColor,
    onPrimary: primaryColor,
    onSecondary: neutralColor,
    onSurface: primaryColor,
    error: errorColor,
  );

  static TextTheme _textTheme(ColorScheme colorScheme) => const TextTheme(
    headlineMedium: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: neutralColor,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: neutralColor,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: neutralColor,
    ),
    titleMedium: TextStyle(
      color: neutralColor,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: TextStyle(
      fontSize: 14,
      color: neutralColor,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: neutralColor,
    ),
    labelLarge: TextStyle(
      fontSize: 18,
      color: neutralColor,
      fontWeight: FontWeight.w600
    ),
  );

  static const DialogTheme _dialogTheme = DialogTheme(
    backgroundColor: Colors.black87,
  );

}
