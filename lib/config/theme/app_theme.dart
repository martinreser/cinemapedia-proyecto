import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
          brightness: Brightness.dark,
          background: Color.fromARGB(255, 5, 23, 32),
          primary: Colors.white,
          secondary: Color.fromARGB(255, 225, 177, 32)),
      fontFamily: 'Jost',
      scaffoldBackgroundColor: const Color.fromARGB(255, 5, 23, 32),
      appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 7, 31, 44),
          surfaceTintColor: Color.fromARGB(255, 7, 31, 44)));
}
