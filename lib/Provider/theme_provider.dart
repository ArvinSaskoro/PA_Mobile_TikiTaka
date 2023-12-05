import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  ThemeData getTheme() {
    return _isDarkMode ? darkTheme : lightTheme;
  }
}

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue, // Ganti dengan warna primer untuk light mode
  hintColor: Colors.orange, // Ganti dengan warna aksen untuk light mode
  // Tambahkan atribut lain yang diperlukan untuk light theme
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.teal, // Ganti dengan warna primer untuk dark mode
  hintColor: Colors.amber, // Ganti dengan warna aksen untuk dark mode
  // Tambahkan atribut lain yang diperlukan untuk dark theme
);
