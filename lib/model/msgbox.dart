import 'package:flutter/material.dart';

class msgbox {
  Future<bool?> showMessageBox(BuildContext context, String title, String content) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Return true when OK is pressed
              },
              child: Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Return false when Cancel is pressed
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );}
  
}