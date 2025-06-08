import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeNotifier extends ValueNotifier<ThemeMode> {
  ThemeNotifier(super.value);

  void toggleMode() {
    value = value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}