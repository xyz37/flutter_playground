import 'dart:math';

import 'package:ch10_random_dice/screen/home_screen.dart';
import 'package:ch10_random_dice/screen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
/*
  TickerProviderStateMixin 은 애니메이션 효율을 담당
  플러터는 기기가 지원하는대로 60FPS ~ 120FPS를 지원하는데 TickerProviderStateMixin 를 사용하면
  정확히 한 틱 (1PFS) 마다 애니메이션을 실행
  간혹 애니메이션 코드가 실제 화면에 그리는 주기보다 더 자주 렌더링을 하는데
  이럴 경우 TickerProviderStateMixin를 사용하면 비효율 상황을 막아준다.
  TabController도 마찬가지로 vsync에 TickerProviderStateMixin를 제공함으로써 렌터링 효율을 좋게 한다.
*/
  late final TabController tabController;
  late final ShakeDetector shakeDetector;
  double threshold = 2.7; //민감도 기본값 설정
  int number = 1;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    // TabBarView 에서 인텍스가 변경되면 BottomNavigationBar를 다시 그려서 어떤탭이 보여지는지 표시 한다.
    tabController.addListener(
        tabListener); // 이 콜백함수에서 setState가 호출되게 하여 build를 재실행 하도록 한다.
    shakeDetector = ShakeDetector.autoStart(
      onPhoneShake: onPhoneShake,
      shakeSlopTimeMS: 100, // 감지 주기,
      shakeThresholdGravity: threshold, // 감지 민감도
    );
  }

  @override
  void dispose() {
    tabController.removeListener(tabListener);
    tabController.dispose();
    shakeDetector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: renderChildren(),
      ),
      bottomNavigationBar: renderBotomNavigation(),
    );
  }

  List<Widget> renderChildren() {
    return [
      HomeScreen(number: number),
      SettingsScreen(threshold: threshold, onThresholdChange: onThresholdChange)
    ];
  }

  BottomNavigationBar renderBotomNavigation() {
    return BottomNavigationBar(
        currentIndex: tabController.index,
        onTap: (index) {
          setState(() {
            tabController.animateTo(
              index,
            );
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.edgesensor_high_outlined,
            ),
            label: '주사위',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: '설정',
          ),
        ]);
  }

  void tabListener() {
    setState(() {});
  }

  void onThresholdChange(double value) {
    setState(() {
      threshold = value;
    });
  }

  void onPhoneShake() {
    final rand = Random();

    setState(() {
      number = rand.nextInt(5) + 1;
    });
  }
}
