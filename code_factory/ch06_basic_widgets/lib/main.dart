import 'package:basic_widgets/screen/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const SplashScreen());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              // Flexible의 fit: FlexFit.tight 로 고정하여 상속함
              child: Container(
                color: Colors.blueAccent,
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.redAccent,
              ),
            ),
            Flexible(
              flex: 2, // 남은 공간을 차지할 비율, 기본값 1
              child: Container(
                color: Colors.blueAccent,
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Container(
                color: Colors.redAccent,
              ),
            ),
            Stack(
              children: [
                Container(
                  height: 300,
                  width: 300,
                  color: Colors.red,
                ),
                Container(
                  height: 250,
                  width: 250,
                  color: Colors.yellow,
                ),
                Container(
                  height: 200,
                  width: 200,
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
