// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final XFile video;

  const CustomVideoPlayer({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? videoController;

  @override
  void initState() {
    super.initState();
    initializeController();
  }

  void initializeController() async {
    final vController = VideoPlayerController.file(
      File(widget.video.path),
    );

    await vController.initialize();

    setState(() {
      videoController = vController;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (videoController == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return AspectRatio(
      aspectRatio: videoController!.value.aspectRatio,
      child: VideoPlayer(videoController!),
    );

    // return const Center(
    //   child: Text(
    //     'Video player',
    //     style: TextStyle(
    //       color: Colors.white,
    //       fontSize: 60,
    //     ),
    //   ),
    // );
  }
}
