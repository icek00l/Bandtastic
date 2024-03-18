// ignore_for_file: file_names

import 'dart:convert';

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/model/generalDatamodel.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';


class WalkThroughController extends GetxController {
GeneralDataModel generalData = GeneralDataModel();
    int courrentIndex=0;
  ChewieController? chewieController;
  VideoPlayerController? videoController;
    
 late PageController pageController;
  @override
  void onInit() async {
    getGenerealData();
   pageController=PageController(initialPage: 0);
    super.onInit();
  }
   @override
     void dispose() {
    pageController.dispose();
    super.dispose();
  }

  initVideoPlayer(index) async {

    try {
      final videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(generalData.data!.welcomeScreens![index].video ?? ""));
      await videoPlayerController.initialize();
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        allowFullScreen: true,
        showControls: false,
        looping: true,
        cupertinoProgressColors: ChewieProgressColors(
          playedColor: AppColors.buttonColor,
          handleColor: AppColors.buttonColor,
          bufferedColor: AppColors.buttonColor,
          backgroundColor: Colors.grey.withOpacity(0.5),
        ),
        aspectRatio: 0.75,
        startAt: const Duration(seconds: 2),
      );

      update();
    } catch (e) {
      print('Error initializing video player: $e');
    }
  }
getGenerealData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map<String, dynamic> userMap =
        jsonDecode(preferences.getString("generalData") ?? '');
    generalData = GeneralDataModel.fromJson(userMap);
initVideoPlayer(courrentIndex);

    update();
  }
  
  InkWell buildDot(
    int index, BuildContext context, WalkThroughController controller) {
  return InkWell(
    onTap: () {
      controller.pageController.nextPage(
          duration: const Duration(milliseconds: 1000), curve: Curves.linearToEaseOut);
    },
    child: Container(
      height: AppDimensions.forteen,
      width: controller.courrentIndex == index
          ? AppDimensions.fifty
          : AppDimensions.forteen,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: controller.courrentIndex == index
            ? Colors.green.shade600
            : Colors.grey,
      ),
    ),
  );
}

}
