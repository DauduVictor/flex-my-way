import 'package:flex_my_way/src/content/constants/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData themeData = ThemeData(
    colorScheme: _colorScheme,
    textTheme: _textTheme(_colorScheme),
    iconTheme: _iconTheme(_colorScheme),
    toggleableActiveColor: AppColors.primaryColor,
    fontFamily: 'Gilroy',
    scaffoldBackgroundColor: AppColors.backgroundColor,
    dialogTheme: _dialogTheme,
  );

  static const ColorScheme _colorScheme = ColorScheme(
    primary: AppColors.primaryColor,
    background: AppColors.backgroundColor,
    brightness: Brightness.light,
    primaryVariant: AppColors.primaryColorVariant,
    secondary: AppColors.secondaryColor,
    secondaryVariant: AppColors.secondaryColor,
    surface: AppColors.white,
    onBackground: AppColors.onBackgroundColor,
    onError: AppColors.onErrorColor,
    onPrimary: AppColors.onPrimaryColor,
    onSecondary: AppColors.onSecondaryColor,
    onSurface: AppColors.onSurfaceColor,
    error: AppColors.errorColor,
  );

  static TextTheme _textTheme(ColorScheme colorScheme) => const TextTheme(
        headline4: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.darkTextColor,
        ),
        headline5: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: AppColors.darkTextColor,
        ),
        headline6: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: AppColors.darkTextColor,
        ),
        subtitle1: TextStyle(
          color: AppColors.darkTextColor,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        bodyText1: TextStyle(
          fontSize: 14,
          color: AppColors.darkTextColor,
          fontWeight: FontWeight.w500,
        ),
        bodyText2: TextStyle(
          fontSize: 16,
          color: AppColors.darkTextColor,
        ),
        button: TextStyle(
            fontSize: 18,
            color: AppColors.darkTextColor,
            fontWeight: FontWeight.w600),
      );

  static IconThemeData _iconTheme(ColorScheme _colorScheme) =>
      const IconThemeData(color: AppColors.iconColor, size: 30);

  static const DialogTheme _dialogTheme = DialogTheme(
    backgroundColor: Colors.black87,
  );
}
