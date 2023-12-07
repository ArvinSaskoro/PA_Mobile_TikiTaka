import 'package:flutter/material.dart';

class Snackbarup {
  static void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2), // Sesuaikan durasi tampilan Snackbar
      ),
    );
  }
}