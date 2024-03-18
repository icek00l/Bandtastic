// ignore_for_file: file_names

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_fonts.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/appstyle/assetbase.dart';
import 'package:bandapp/screen/login/login_welcome.dart';
import 'package:bandapp/screen/walkthroughScreen/walkThrough_controller.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../appstyle/app_dimensions.dart';

class WalkThroughView extends StatefulWidget {
  const WalkThroughView({Key? key}) : super(key: key);

  @override
  State<WalkThroughView> createState() => _WalkThroughViewState();
}

class _WalkThroughViewState extends State<WalkThroughView> {
  @override
  Widget build(BuildContext context) => GetBuilder<WalkThroughController>(
      init: WalkThroughController(),
      builder: (controller) => Scaffold(
            body: controller.generalData.data == null
                ? const IgnorePointer()
                : Column(
                    children: [
                      Expanded(
                        child: PageView.builder(
                          controller: controller.pageController,
                          itemCount: controller
                              .generalData.data!.welcomeScreens!.length,
                          onPageChanged: (int index) {
                            controller.initVideoPlayer(index);
                            controller.courrentIndex = index;
                            controller.update();
                          },
                          itemBuilder: (_, i) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipPath(
                                    clipper: DiagonalPathClipperOne(),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.6,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            AppColors.gradientColor1,
                                            AppColors.gradientColor2
                                          ],
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: controller.chewieController == null
                                          ? const IgnorePointer()
                                          : Chewie(
                                              controller:
                                                  controller.chewieController!,
                                            ),
                                    )),
                               
                                Container(
                                  margin: EdgeInsets.only(
                                      left: AppDimensions.twenty,
                                      top: AppDimensions.ten,
                                      bottom: AppDimensions.twenty),
                                  child: Text(
                                    controller.generalData.data!
                                            .welcomeScreens![i].title ??
                                        "",
                                    style: TextStyle(
                                        fontSize: AppDimensions.twentyEight,
                                        fontFamily: AppFonts.plusSansBold,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.only(
                                      left: AppDimensions.twenty,
                                      right: AppDimensions.twenty),
                                  child: Text(
                                    controller.generalData.data!
                                            .welcomeScreens![i].subtitle ??
                                        "",
                                    style: AppThemeStyle.descriptionText300,
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: AppDimensions.twenty,
                            bottom: AppDimensions.twentyFive),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: AppDimensions.ten,
                                  right: AppDimensions.ten),
                              child: GestureDetector(
                                onTap: () {
                                  Get.offAll(() => const LoginWelcomeView());
                                },
                                child: Text(
                                  AppStrings.skip,
                                  style: TextStyle(
                                    fontFamily: AppFonts.robotoFlex,
                                    fontSize: AppDimensions.sixTeen,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                                children: List.generate(
                                    controller.generalData.data!.welcomeScreens!
                                        .length,
                                    (index) => controller.buildDot(
                                        index, context, controller))),
                            MaterialButton(
                                onPressed: () {
                                  if (controller.courrentIndex ==
                                      controller.generalData.data!
                                              .welcomeScreens!.length -
                                          1) {
                                    Get.offAll(const LoginWelcomeView());
                                  }
                                  controller.pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 1000),
                                      curve: Curves.linearToEaseOut);
                                },
                                child:
                                    SvgPicture.asset(AssetsBase.nextButtonSvg)),
                          ],
                        ),
                      )
                    ],
                  ),
          ));
}
