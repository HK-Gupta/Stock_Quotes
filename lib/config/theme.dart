import 'package:flutter/material.dart';
import 'package:stock_quote_app/config/colors.dart';

var darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,

    appBarTheme: AppBarTheme(),
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      onPrimary: secondaryColor,
      secondary: dividerColor,
      onSecondary: onSecondaryColor,
      background: bgColor,
      primaryContainer: containerColor,
      onPrimaryContainer: labelColor,
      onBackground: fontColor,
    ),

    textTheme: TextTheme(
      headlineMedium: TextStyle(
          fontSize: 30,
          color: fontColor,
          fontWeight: FontWeight.w700
      ),
      bodyLarge: TextStyle(
          fontSize: 24,
          color: fontColor,
          fontWeight: FontWeight.w700
      ),
      bodyMedium: TextStyle(
          fontSize: 20,
          color: fontColor,
          fontWeight: FontWeight.w400
      ),
      bodySmall: TextStyle(
          fontSize: 18,
          color: fontColor,
          fontWeight: FontWeight.w400
      ),
      labelMedium: TextStyle(
          fontSize: 16,
          color: labelColor,
          fontWeight: FontWeight.w400
      ),
      labelSmall: const TextStyle(
        fontSize: 15,
        color: Color(0xFFA9A9A9),
        fontWeight: FontWeight.w400
    ),
    )
);