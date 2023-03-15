// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ch10_random_dice/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SettingsScreen extends StatefulWidget {
  final double threshold; // silder 현재값
  final ValueChanged<double> onThresholdChange;

  const SettingsScreen({
    Key? key,
    required this.threshold,
    required this.onThresholdChange,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool showAccelometer = false;
  bool showUserAccelometer = false;
  bool showGyroscope = false;
  String logText = "";

  @override
  void initState() {
    super.initState();

    debugAccelerometor();
    debugUserAccelerometor();
    debugGyroscope();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Text(
                '민감도',
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
        Slider(
          value: widget.threshold,
          onChanged: widget.onThresholdChange,
          min: 0.1,
          max: 10.0,
          divisions: 101,
          label: widget.threshold.toStringAsFixed(1),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: Column(
            children: [
              Row(
                children: [
                  Switch.adaptive(
                    value: showAccelometer,
                    onChanged: onAccelormeter,
                  ),
                  const Text(
                    '중력 반영 가속도 보이기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Switch.adaptive(
                    value: showUserAccelometer,
                    onChanged: onUserAccelormeter,
                  ),
                  const Text(
                    '사용자 중력 반영 가속도 보이기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Switch.adaptive(
                    value: showGyroscope,
                    onChanged: onGyroscope,
                  ),
                  const Text(
                    'Gyroscope 보이기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Text(
          logText,
          softWrap: true,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  void onAccelormeter(bool value) {
    setState(() {
      showAccelometer = value;
      logText = "";
    });
  }

  void onUserAccelormeter(bool value) {
    setState(() {
      showUserAccelometer = value;
      logText = "";
    });
  }

  void onGyroscope(bool value) {
    setState(() {
      showGyroscope = value;
      logText = "";
    });
  }

  void debugAccelerometor() {
    // 중력을 반영한 가속도계 값
    accelerometerEvents.listen((event) {
      if (showAccelometer) {
        // setState(() {
        logText += 'x: ${event.x}, y: ${event.y}, z: ${event.z}\n';
        // });
      }
    });
  }

  void debugUserAccelerometor() {
    // 중력을 반영하지 않은 순수 사용자의 힘에 의한 가속도계 값
    userAccelerometerEvents.listen((event) {
      if (showUserAccelometer) {
        // setState(() {
        logText += 'x: ${event.x}, y: ${event.y}, z: ${event.z}\n';
        // });
      }
    });
  }

  void debugGyroscope() {
    // 자이로스코프 가속도계 값
    gyroscopeEvents.listen((event) {
      if (showGyroscope) {
        // setState(() {
        logText += 'x: ${event.x}, y: ${event.y}, z: ${event.z}\n';
        // });
      }
    });
  }
}
