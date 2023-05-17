import 'package:flutter/material.dart';

class CustomTheme {
  static const Map<int, Color> colour = {
    50: Color.fromRGBO(30, 52, 86, .1),
    100: Color.fromRGBO(30, 52, 86, .2),
    200: Color.fromRGBO(30, 52, 86, .3),
    300: Color.fromRGBO(30, 52, 86, .4),
    400: Color.fromRGBO(30, 52, 86, .5),
    500: Color.fromRGBO(30, 52, 86, .6),
    600: Color.fromRGBO(30, 52, 86, .7),
    700: Color.fromRGBO(30, 52, 86, .8),
    800: Color.fromRGBO(30, 52, 86, .9),
    900: Color.fromRGBO(30, 52, 86, 1),
  };

  static MaterialColor colorCustom = const MaterialColor(0xFF1e3456, colour);

  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: colorCustom,
      brightness: Brightness.light,
    );
  }
}

  // colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(30, 52, 86, 10),primary: Color.fromRGBO(30, 52, 86, 10)),
  //  colorSchemeSeed:Color.fromRGBO(30, 52, 86, 10),
  //  useMaterial3: true,
    // theme: ThemeData(
            //   colorScheme: ColorScheme.fromSwatch().copyWith(
            //     primary: Colors.amber,
            //     secondary: Colors.green,
            //   ),
            //   // textTheme:
            //   //     const TextTheme(bodyMedium: TextStyle(color: Colors.green)),
            // ),
