import 'package:flutter/material.dart';

final ThemeData myTheme = ThemeData(
  primaryColor: Colors.blue,
  backgroundColor: Colors.white,
  hintColor: Colors.green,
  textTheme:  TextTheme(
    titleLarge: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    bodyText2: const TextStyle(fontSize: 16.0),
  ),
);