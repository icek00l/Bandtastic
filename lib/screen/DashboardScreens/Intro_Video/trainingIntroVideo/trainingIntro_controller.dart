import 'package:bandapp/appstyle/app_colors.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class TrainIntroController extends GetxController {
  VideoPlayerController? videoController;

  dynamic argumentData = Get.arguments;
  String getVideoUrl = '';
  bool finishedPlaying = false;
  ChewieController? chewieController;

  @override
  void onInit() async {
    if (argumentData != null) {
      getVideoUrl = '';
      getVideoUrl = argumentData['videoUrl'];
      if (getVideoUrl.isNotEmpty) {
        initVideoPlayer();
      } else {
        Get.delete<TrainIntroController>();
        Get.back();
      }
    }
    super.onInit();
  }

  initVideoPlayer() async {
    final videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(getVideoUrl));
    await videoPlayerController.initialize();
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        looping: false,
        allowMuting: false,
        allowPlaybackSpeedChanging: false,
        cupertinoProgressColors: ChewieProgressColors(
          playedColor: AppColors.buttonColor,
          handleColor: AppColors.buttonColor,
          bufferedColor: AppColors.buttonColor,
          backgroundColor: Colors.grey.withOpacity(0.5),
        ),
        customControls: const MaterialDesktopControls(),
        aspectRatio: 0.6,
        startAt: const Duration(seconds: 2));
    update();
  }

  @override
  void dispose() {
    super.dispose();
    if (chewieController != null) {
      chewieController!.pause();
      videoController!.pause();
      chewieController!.dispose();
      videoController!.dispose();
      videoController = null;
      chewieController = null;
    }
  }

}
