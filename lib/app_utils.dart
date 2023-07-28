import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppUtils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text) {
    if (text == null) return;
    final snackBar = SnackBar(
        content: Text(
          text,
        ),
        backgroundColor: Colors.teal);

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
