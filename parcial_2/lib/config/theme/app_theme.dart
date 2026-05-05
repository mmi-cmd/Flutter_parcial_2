import 'package:flutter/material.dart';

List<Color> _colorsTheme = [
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.orange,
  Colors.purple,
  Colors.yellow,
  Colors.cyan,
  Colors.pink,
];

class AppTheme {
  int selectColor;
  AppTheme({required this.selectColor});

  Color get colorTheme => _colorsTheme[selectColor];

  ThemeData themeData(int bandera) {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _colorsTheme[selectColor],
      appBarTheme: AppBarTheme(backgroundColor: _colorsTheme[selectColor]),
      brightness: bandera == 0 ? Brightness.light : Brightness.dark,
    );
  }
}
