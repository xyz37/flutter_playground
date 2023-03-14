import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/services/system_chrome.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // debugPrint('UI: ${SystemChrome.latestStyle?.toString()}');
    // 상태바가 이미 흰색 이면 dark, 아니면 light
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
        body: PageView(
      children: List.generate(5, (i) => i + 1)
          .map(
            (e) => Image.asset(
              'assets/images/image_$e.jpeg',
              fit: BoxFit.cover,
            ),
          )
          .toList(),
    ));
  }
}
