//
// This source code is distributed under the terms of Bad Code License.
// You are forbidden from distributing software containing this code to
// end users, because it is bad.
//

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
    buttonColor: const Color(0xffFF6347),
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
    buttonColor: const Color(0xffFF6347),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
      actionsIconTheme: IconThemeData(color: Colors.white),
    ),
  );

  // A special edition theme. Which was deisgned first when app idea had come.
  // See for additional information about minimalist theme - https://github.com/theiskaa/Visual-Time/issues/32
  final minimalist = ThemeData(
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
    buttonColor: Colors.black,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
      actionsIconTheme: IconThemeData(color: Colors.black),
    ),
  );
}

class DayChartColorPalettes {
  final darkPalette = <Color>[
    Colors.grey.shade900,
    Colors.red,
    Colors.purple.shade400,
    const Color.fromRGBO(246, 114, 128, 1),
    const Color.fromRGBO(248, 177, 149, 1),
    const Color.fromRGBO(116, 180, 155, 1),
    const Color.fromRGBO(0, 168, 181, 1),
    const Color.fromRGBO(73, 76, 162, 1),
    const Color.fromRGBO(255, 205, 96, 1),
    const Color.fromRGBO(255, 240, 219, 1),
    const Color.fromRGBO(238, 238, 238, 1)
  ];

  final lightPalette = <Color>[
    Colors.grey.shade300,
    Colors.red.shade400,
    const Color.fromRGBO(192, 108, 132, 1),
    const Color.fromRGBO(246, 114, 128, 1),
    const Color.fromRGBO(248, 177, 149, 1),
    const Color.fromRGBO(116, 180, 155, 1),
    const Color.fromRGBO(0, 168, 181, 1),
    const Color.fromRGBO(73, 76, 162, 1),
    const Color.fromRGBO(255, 205, 96, 1),
    const Color.fromRGBO(255, 240, 219, 1),
    const Color.fromRGBO(238, 238, 238, 1)
  ];

  static const s2Palette = <Color>[
    Color(0xFF858585),
    Color(0xFF1B1B1B),
    Color(0xFF303030),
    Color(0xFF474747),
    Color(0xFF2C2C2C),
    Color(0xFF5E5E5E),
    Color(0xFF1D1D1D),
    Color(0xFF777777),
    Color(0xFF777777),
    Color(0xFF919191),
    Color(0xFF383838),
    Color(0xFF1D1D1D),
  ];
}
