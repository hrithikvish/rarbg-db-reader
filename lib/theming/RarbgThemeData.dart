import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.black)),
  chipTheme: ChipThemeData(
    backgroundColor: Colors.white,
    checkmarkColor: Colors.white,
    selectedColor: Colors.black,
    labelStyle: TextStyle(color: Colors.black),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all(Colors.white),
    trackColor: WidgetStateProperty.all(Colors.black),
    trackOutlineColor: WidgetStateProperty.all(Colors.black)
  ),
  scaffoldBackgroundColor: Colors.white,
  cardColor: Colors.grey.shade100,
).copyWith(
  colorScheme: ThemeData.light().colorScheme.copyWith(
    onSurface: Colors.white,
    onPrimary: Colors.black
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.white)),
  chipTheme: ChipThemeData(
    backgroundColor: Colors.black,
    checkmarkColor: Colors.black,
    selectedColor: Colors.white,
    labelStyle: TextStyle(color: Colors.white),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all(Colors.black),
    trackColor: WidgetStateProperty.all(Colors.white),
    trackOutlineColor: WidgetStateProperty.all(Colors.white)
  ),
  scaffoldBackgroundColor: Colors.black,
  cardColor: Colors.grey.shade900,
).copyWith(
  colorScheme: ThemeData.light().colorScheme.copyWith(
    onSurface: Colors.black
  ),
);
