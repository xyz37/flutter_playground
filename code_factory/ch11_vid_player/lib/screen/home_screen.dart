// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ch11_vid_player/screen/custom_video_player.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video; // image_picker 에서 반환함

  @override
  void initState() {
    super.initState();
  }

  renderEmpty() {
    var now = DateTime.now();
    debugPrint('date: ${DateFormat('mm:ss').format(now)}');

    return Container(
      width: MediaQuery.of(context).size.height,
      decoration: getBoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(onTap: onNewVideoPressed),
          const SizedBox(height: 30),
          const _AppName(),
        ],
      ),
    );
  }

  renderVideo() {
    return Center(
      child: CustomVideoPlayer(
        video: video!,
      ),
    );
  }

  getBoxDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Color(0xFF2A3A7C),
            Color(0xFF000118),
          ]),
    );
  }

  void onNewVideoPressed() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (video != null) {
      setState(() {
        this.video = video;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: video == null ? renderEmpty() : renderVideo(),
    );
  }
}

class _Logo extends StatelessWidget {
  final GestureTapCallback onTap;

  const _Logo({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset('assets/images/logo.png'),
    );
  }
}

class _AppName extends StatelessWidget {
  final textStyle = const TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.w300,
  );

  const _AppName();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'VIDEO',
          style: textStyle,
        ),
        Text(
          'PLAYER',
          style: textStyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
