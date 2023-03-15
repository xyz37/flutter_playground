import 'package:ch10_random_dice/const/colors.dart';
import 'package:ch10_random_dice/screen/root_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      sliderTheme: SliderThemeData(
        thumbColor: primaryColor,
        activeTickMarkColor: primaryColor,
        inactiveTrackColor: primaryColor.withOpacity(0.3),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryColor,
        unselectedItemColor: secondaryColor,
        backgroundColor: backgroundColor,
      ),
    ),
    home: const RootScreen(),
  ));
}
