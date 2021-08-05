import 'package:flutter/material.dart';

ButtonStyle simpleButtonStyle(Color color) {
  return ButtonStyle(
    textStyle: MaterialStateProperty.all(TextStyle(color: color)),
    overlayColor: MaterialStateProperty.all(color.withOpacity(.2)),
  );
}

class Themes {
  final defaultTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.black,
    accentColor: Colors.black,
    primarySwatch: Colors.grey,
    hoverColor: Colors.grey.shade300,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle:
            MaterialStateProperty.all(const TextStyle(color: Colors.white)),
        backgroundColor: MaterialStateProperty.all(const Color(0xFF000000)),
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: const Color(0xFF000000).withOpacity(.3),
      selectionHandleColor: const Color(0xFF000000).withOpacity(.3),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          const TextStyle(color: Colors.white),
        ),
        overlayColor: MaterialStateProperty.all(
          const Color(0xFF000000).withOpacity(.3),
        ),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      backgroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
      headline2: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      headline3: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      headline4: TextStyle(color: Colors.black),
      headline5: TextStyle(color: Colors.black),
      headline6: TextStyle(color: Colors.black),
      button: TextStyle(color: Colors.white),
    ),
    primaryTextTheme: const TextTheme(
      headline6: TextStyle(color: Colors.black),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
      actionsIconTheme: IconThemeData(color: Colors.black),
    ),
  );

  final dark = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF141414),
    brightness: Brightness.dark,
    primaryColor: Colors.white,
    accentColor: Colors.white,
    primarySwatch: Colors.grey,
    hoverColor: Colors.grey.shade900,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle:
            MaterialStateProperty.all(const TextStyle(color: Colors.black)),
        backgroundColor: MaterialStateProperty.all(const Color(0xFFFFFFFF)),
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.white,
      selectionColor: const Color(0xFFFFFFFF).withOpacity(.3),
      selectionHandleColor: const Color(0xFFFFFFFF).withOpacity(.3),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(Colors.white),
      checkColor: MaterialStateProperty.all(Colors.black),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          const TextStyle(color: Colors.white),
        ),
        overlayColor: MaterialStateProperty.all(
          const Color(0xFF000000).withOpacity(.3),
        ),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      backgroundColor: Colors.grey.shade900,
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
      headline2: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      headline3: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      headline4: TextStyle(color: Colors.white),
      headline5: TextStyle(color: Colors.white),
      headline6: TextStyle(color: Colors.white),
      button: TextStyle(color: Colors.black),
    ),
    primaryTextTheme: const TextTheme(
      headline6: TextStyle(color: Colors.white),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
      actionsIconTheme: IconThemeData(color: Colors.white),
    ),
  );
}
