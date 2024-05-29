import 'package:flutter/material.dart';

import 'hello_widget.dart';
import 'home_widget.dart';
import 'star_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const _title = 'Flutter SketchApp';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final _pageController = PageController();
  int _selectedIndex = 0;

  // static const optionStyle = TextStyle(
  //   fontSize: 30,
  //   fontWeight: FontWeight.bold,
  // );

  static final List<Widget> _widgetOptions = <Widget>[
    HomeWidget(),
    const HelloWidget(),
    StarWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Sketch Application'),
        ),
        body: PageView(
          controller: _pageController,
          children: [
            Scaffold(
              body: Center(
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.wb_cloudy),
                    label: 'Hello',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.star),
                    label: 'Star',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.white,
                backgroundColor: Colors.blueAccent,
                onTap: _onItemTapped,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}


/*
 * REFERENCES
 * 
 * https://api.flutter.dev/flutter/widgets/PageController-class.html
 * https://api.flutter.dev/flutter/widgets/PageView-class.html
 * https://api.flutter.dev/flutter/widgets/BottomNavigationBarItem-class.html
 * https://api.flutter.dev/flutter/material/TextButton-class.html
 * https://api.flutter.dev/flutter/material/AlertDialog-class.html
 * https://api.flutter.dev/flutter/material/showDialog.html
 */
