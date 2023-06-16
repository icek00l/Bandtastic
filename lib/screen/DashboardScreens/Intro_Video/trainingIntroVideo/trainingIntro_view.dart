// ignore_for_file: file_names

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/assetbase.dart';
import 'package:bandapp/screen/DashboardScreens/Intro_Video/trainingIntroVideo/trainingIntro_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:video_player/video_player.dart';

class TrainIntroView extends StatefulWidget {
  const TrainIntroView({super.key});

  @override
  State<TrainIntroView> createState() => _TrainIntroViewState();
}

class _TrainIntroViewState extends State<TrainIntroView> {
  var dsh = Get.isRegistered<TrainIntroController>()
      ? Get.find<TrainIntroController>()
      : Get.put(TrainIntroController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrainIntroController>(
        builder: (controller) {
    controller.videoController.initialize();
          return Scaffold(
              body: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  VideoPlayer(controller.videoController),
                  Positioned(
                    top: AppDimensions.fifty,
                    left: AppDimensions.twenty,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Get.delete<TrainIntroController>();
                      },
                      child: SvgPicture.asset(AssetsBase.backButtonSvg,
                          height: AppDimensions.thirty),
                    ),
                  ),
                  Positioned(
                      child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.sixTeen),
                      color: AppColors.containerColor,
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: AppDimensions.twenty,
                        horizontal: AppDimensions.thirty),
                    margin: EdgeInsets.only(
                        left: AppDimensions.forty,
                        right: AppDimensions.forty,
                        bottom: AppDimensions.twenty),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Image.asset(AssetsBase.backvideo),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.videoController.value.isPlaying == false
                                ? controller.videoController.play()
                                : controller.videoController.pause();

                            controller.update();
                          },
                          child: Icon(
                              controller.videoController.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow_rounded,
                              size: AppDimensions.forty,
                              color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Image.asset(AssetsBase.nextvideo),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            );});
  }
}
