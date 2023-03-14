import 'package:ch09_u_and_i/screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MaterialApp(
    // flutter_localizations 패키지 추가 후 아래 지원 언어까지 설정
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      DefaultCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('ko', 'KR'), // Korean, no Country code
      Locale('en', 'US'), // English
      // ... other locales the app supports
    ],
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
