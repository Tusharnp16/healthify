import 'package:flutter/material.dart';

final ThemeData myTheme = ThemeData(
  primarySwatch: Colors.purple,
  backgroundColor: Colors.white,
  hintColor: Colors.green,
  textTheme:  TextTheme(
    titleLarge: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    bodyText2: const TextStyle(fontSize: 16.0),
  ),
);