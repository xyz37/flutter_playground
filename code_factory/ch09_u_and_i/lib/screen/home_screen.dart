import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            _DDay(),
            _CoupleImage(),
          ],
        ),
      ),
    );
  }
}

class _DDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          'U & I',
          style: theme.displayLarge,
        ),
        const SizedBox(height: 16),
        Text(
          '두번째 만난날',
          style: theme.bodyLarge,
        ),
        const SizedBox(height: 16),
        Text(
          '2002.02.22',
          style: theme.bodyMedium,
        ),
        const SizedBox(height: 16),
        IconButton(
          icon: const Icon(
            Icons.favorite,
            color: Colors.redAccent,
          ),
          iconSize: 60,
          onPressed: () {},
        ),
        const SizedBox(height: 16),
        Text(
          'D+365',
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
