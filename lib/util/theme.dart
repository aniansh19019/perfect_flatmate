import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static const Color primaryPink = Color(0xFFF65E7E);
  static TextStyle title = const TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
  );
  static TextStyle h1 = const TextStyle(fontSize: 22);
  static TextStyle h2 = const TextStyle(fontSize: 18);
  static TextStyle h3 = const TextStyle(fontSize: 16);
  static TextStyle h4 = const TextStyle(fontSize: 14);

  // static TextStyle appBarTitle = const
  static TextStyle body =
      const TextStyle(fontSize: 12, color: Color(0xFF99A3B0));
  static TextStyle error = const TextStyle(color: Colors.red);
}

//palette.dart

class Palette {
  static const MaterialColor kToDark = const MaterialColor(
    0xFFF65E7E, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xfffa9eb2), //10%
      100: const Color(0xfff98ea5), //20%
      200: const Color(0xfff87e98), //30%
      300: const Color(0xfff76e8b), //40%
      400: const Color(0xfff65e7e), //50%
      500: const Color(0xffdd5571), //60%
      600: const Color(0xffc54b65), //70%
      700: const Color(0xffac4258), //80%
      800: const Color(0xff94384c), //90%
      900: const Color(0xff7b2f3f), //100%
    },
  );
} // you can def
