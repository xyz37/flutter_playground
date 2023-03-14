// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DateTime firstDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DDay(
              onHeartPressed: () => onHeartPressed(firstDay),
              firstDay: firstDay,
            ),
            _CoupleImage(),
          ],
        ),
      ),
    );
  }

  void onHeartPressed(DateTime initDay) {
    // debugPrint('Heart pressed !!!');

    showCupertinoDialog(
      context: context,
      builder: (context) {
        return Align(
          alignment: Alignment.bottomCenter, // 아래 중간으로 정렬
          child: Container(
            color: Colors.white,
            height: 300,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: initDay,
              maximumDate: DateTime.now(), // 오늘 이후는 선택되지 않도록
              onDateTimeChanged: (date) {
                setState(() {
                  firstDay = date;
                });
              },
            ),
          ),
        );
      },
      barrierDismissible: true, // 외부 탭할 경우 다이얼로그 닫기
    );
  }
}

class _DDay extends StatelessWidget {
  final GestureTapCallback onHeartPressed;
  final DateTime firstDay;

  const _DDay({
    Key? key,
    required this.onHeartPressed,
    required this.firstDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final now = DateTime.now();

    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          'U & I',
          style: theme.displayLarge,
        ),
        const SizedBox(height: 16),
        Text(
          '우리 처음 만난날',
          style: theme.bodyLarge,
        ),
        const SizedBox(height: 16),
        Text(
          '${firstDay.year}.${firstDay.month}.${firstDay.day}',
          style: theme.bodyMedium,
        ),
        const SizedBox(height: 16),
        IconButton(
          icon: const Icon(
            Icons.favorite,
            color: Colors.redAccent,
          ),
          iconSize: 60,
          onPressed: onHeartPressed,
        ),
        const SizedBox(height: 16),
        Text(
          'D+${now.isAfter(firstDay) ? DateTimeRange(start: firstDay, end: now).duration.inDays : 0}',
          style: theme.displayMedium,
        ),
      ],
    );
  }
}

class _CoupleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Image.asset(
          'assets/images/middle_image.png',
          height: MediaQuery.of(context).size.height / 2,
        ),
      ),
    );
  }
}
