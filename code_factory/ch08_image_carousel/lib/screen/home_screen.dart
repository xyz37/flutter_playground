import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/src/services/system_chrome.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController controller;
  late final List<Image> _pages;

  @override
  void initState() {
    super.initState();
    controller = PageController();
    _pages = List.generate(5, (i) => i + 1)
        .map(
          (e) => Image.asset(
            'assets/images/image_$e.jpeg',
            fit: BoxFit.cover,
          ),
        )
        .toList();

    Timer.periodic(const Duration(seconds: 3), (timer) {
      var page = getRotatedPage(controller.page, _pages.length);

      controller.animateToPage(page,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint('UI: ${SystemChrome.latestStyle?.toString()}');
    // 상태바가 이미 흰색 이면 dark, 아니면 light
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
        body: PageView(
      controller: controller,
      children: _pages,
    ));
  }

  int getRotatedPage(double? page, int length) {
    var currentPage = page!.toInt();

    return ++currentPage >= length ? 0 : currentPage;
  }
}
