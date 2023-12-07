  // ignore_for_file: prefer_const_constructors

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
    primaryColor: Color.fromARGB(255, 29, 72, 106),
    hintColor: Color.fromARGB(255, 18, 45, 66),
    // colorScheme: ColorScheme.light(
    //   background: Colors.white, 
    // ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: Colors.black, 
      ),
      bodySmall: TextStyle(
        color: Colors.black, 
      ),
    ),
  );

  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color.fromARGB(255, 29, 72, 106),
    hintColor: Color.fromARGB(255, 41, 179, 173),
    // colorScheme: ColorScheme.light(
    //   background: Colors.white, 
    // ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: Colors.white, 
      ),
      bodySmall: TextStyle(
        color: Colors.white, 
      ),
    ),
  );

  // WARNA TOSCA      29B3AD Color.fromARGB(255, 41, 179, 173)
  // WARNA Biru Muda  1D486A Color.fromARGB(255, 29, 72, 106)
  // WARNA Biru Tua   122D42 Color.fromARGB(255, 18, 45, 66)
  // WARNA Abu cerah  D9D9D9 Color.fromARGB(255, 217, 217, 217)