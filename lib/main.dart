import 'package:flutter/material.dart';
import 'package:rarbg_reader/pages/db_viewer/db_viewer.dart';
import 'package:rarbg_reader/theming/ThemeNotifier.dart';

import 'theming/RarbgThemeData.dart';

void main() {
  final themeNotifier = ThemeNotifier(ThemeMode.system);
  runApp(MyApp(themeNotifier: themeNotifier));
}

class MyApp extends StatelessWidget {
  final ThemeNotifier themeNotifier;

  const MyApp({super.key, required this.themeNotifier});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeNotifier,
      builder: (context, currentTheme, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: currentTheme,
          home: DbViewer(themeNotifier: themeNotifier),
        );
      }
    );
  }
}