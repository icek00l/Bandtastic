// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class TrainIntroController extends GetxController {
  late VideoPlayerController videoController;
  bool finishedPlaying = false;
  @override
  void onInit() async {
    videoController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
      });
     
    
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
print("off");
  }
}
