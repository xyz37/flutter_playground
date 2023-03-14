import 'package:ch09_u_and_i/screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'sunflower',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: Colors.white,
          fontSize: 80,
          fontWeight: FontWeight.w700,
          fontFamily: 'parisienne',
        ),
        displayMedium: TextStyle(
          color: Colors.white,
          fontSize: 50,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: TextStyle(
          color: Colors.white,
          fontSize: 50,
        ),
        bodyMedium: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    ),
    home: const HomeScreen(),
  ));
}
