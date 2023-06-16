
import 'dart:async';

import 'package:bandapp/utility/Utility.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class TrainIntroController extends GetxController {
  late VideoPlayerController videoController;
  dynamic argumentData = Get.arguments;
  String getVideoUrl = '';
  bool finishedPlaying = false;
  @override
  void onInit() async {
    if (argumentData != null) {
      getVideoUrl = '';
      getVideoUrl = argumentData['videoUrl'];
      print(getVideoUrl);
    }
    if (getVideoUrl.isNotEmpty) {
      Utility.closeDialog();
      videoController = VideoPlayerController.network(getVideoUrl)
        ..initialize().then((_) {
          videoController.addListener(() {
            if (videoController.value.position ==
                videoController.value.duration) {
              print("enter");
              Timer(const Duration(milliseconds: 100), () => Get.back());
            } else {
             

              print("end video ");

            }
          });
        });
    } else {
      Utility.onLoading();
    }

    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
    print("off");
  }
}
