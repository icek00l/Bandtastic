// ignore_for_file: file_names, avoid_print

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
        videoController.addListener(() {
          if (videoController.value.position ==
              videoController.value.duration) {
            print("enter");
            Get.back();
          } else {
            print("end video");
          }
        });
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
