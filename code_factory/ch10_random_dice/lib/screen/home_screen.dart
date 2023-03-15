// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ch10_random_dice/const/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final int number;

  const HomeScreen({
    Key? key,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset('assets/images/$number.png'),
        ),
        const SizedBox(height: 32),
        Text(
          '행운의 숫자',
          style: TextStyle(
            color: secondaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          number.toString(),
          style: const TextStyle(
            color: primaryColor,
            fontSize: 60,
            fontWeight: FontWeight.w200,
          ),
        ),
      ],
    );
  }
}
