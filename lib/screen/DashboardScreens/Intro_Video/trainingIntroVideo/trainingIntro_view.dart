// ignore_for_file: file_names

import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/assetbase.dart';
import 'package:bandapp/screen/DashboardScreens/Intro_Video/trainingIntroVideo/trainingIntro_controller.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class TrainIntroView extends StatelessWidget {
  const TrainIntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrainIntroController>(
        init: TrainIntroController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.grey.withOpacity(0.5),
            body: SafeArea(
              child: WillPopScope(
                onWillPop: () async {
                  if (controller.chewieController != null) {
                    controller.chewieController!.pause();
                    controller.chewieController!.dispose();
                  }

                  Get.delete<TrainIntroController>();

                  return true;
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (controller.chewieController != null) {
                          controller.chewieController!.pause();
                          controller.videoController!.pause();
                          controller.chewieController!.dispose();
                          controller.videoController!.dispose();
                        }
                        Navigator.pop(context);
                        Get.delete<TrainIntroController>();
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: AppDimensions.twelve,
                            vertical: AppDimensions.twelve),
                        child: SvgPicture.asset(AssetsBase.backButtonSvg,
                            height: AppDimensions.thirty),
                      ),
                    ),
                    controller.chewieController == null
                        ? const IgnorePointer()
                        : Expanded(
                            child: Chewie(
                              controller: controller.chewieController!,
                            ),
                          ),
                    // Positioned(
                    //   top: AppDimensions.fifty,
                    //   left: AppDimensions.twenty,
                    //   child:

                    // ),

                    // Positioned(
                    //     child: Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius:
                    //         BorderRadius.circular(AppDimensions.sixTeen),
                    //     color: AppColors.containerColor,
                    //   ),
                    //   padding: EdgeInsets.symmetric(
                    //       vertical: AppDimensions.twenty,
                    //       horizontal: AppDimensions.thirty),
                    //   margin: EdgeInsets.only(
                    //       left: AppDimensions.forty,
                    //       right: AppDimensions.forty,
                    //       bottom: AppDimensions.twenty),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       GestureDetector(
                    //         onTap: () {},
                    //         child: Image.asset(AssetsBase.backvideo),
                    //       ),
                    //       GestureDetector(
                    //         onTap: () {
                    //           controller.videoController!.value.isPlaying ==
                    //                   false
                    //               ? controller.videoController!.play()
                    //               : controller.videoController!.pause();
                    //           controller.update();
                    //         },
                    //         child: Icon(
                    //             controller.chewieController!.isPlaying
                    //                 ? Icons.pause
                    //                 : Icons.play_arrow_rounded,
                    //             size: AppDimensions.forty,
                    //             color: Colors.white),
                    //       ),
                    //       GestureDetector(
                    //         onTap: () {},
                    //         child: Image.asset(AssetsBase.nextvideo),
                    //       ),
                    //     ],
                    //   ),
                    // ))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
