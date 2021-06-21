import 'package:flutter/material.dart';

class Themes {
  final defaultTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.black,
    accentColor: Colors.black,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0xFF000000)),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: const Color(0xFF000000).withOpacity(.3),
      selectionHandleColor: const Color(0xFF000000).withOpacity(.3),
    ),
  );
}
