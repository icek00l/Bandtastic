// ignore_for_file: file_names

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_fonts.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/appstyle/assetbase.dart';
import 'package:bandapp/navigation/app_route_maps.dart';
import 'package:bandapp/screen/selectdayandTraining/trainingExplanation/howWorlModel.dart';
import 'package:bandapp/screen/selectdayandTraining/trainingExplanation/trainingScreen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TrainingScreenView extends StatefulWidget {
  const TrainingScreenView({super.key});

  @override
  State<TrainingScreenView> createState() => _TrainingScreenViewState();
}

class _TrainingScreenViewState extends State<TrainingScreenView> {
  @override
  Widget build(BuildContext context) => GetBuilder<TrainingController>(
      builder: (controller) => Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    itemCount: howWorkModel.length,
                    onPageChanged: (int index) {
                      controller.courrentIndex = index;
                      controller.update();
                    },
                    itemBuilder: (_, i) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image.asset(contents[i].image!,height:MediaQuery.of(context).size.height /1.7,width: double.infinity,fit: BoxFit.cover,),
                          ClipPath(
                              clipper: DiagonalPathClipperOne(),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.6,
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
                                child:
                                    SvgPicture.asset(AssetsBase.playCircleSvg),
                              )),
                          Container(
                            margin: EdgeInsets.only(
                              left: AppDimensions.twenty,
                            ),
                            child: Text(howWorkModel[i].name!,
                                style: TextStyle(
                                    fontSize: AppDimensions.sixTeen,
                                    fontFamily: AppFonts.robotoRegular,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 3.0,
                                    color: AppColors.primaryTextColor)),
                          ),

                          Container(
                            margin: EdgeInsets.only(
                                left: AppDimensions.twenty,
                                top: AppDimensions.ten,
                                bottom: AppDimensions.twenty),
                            child: Text(
                              howWorkModel[i].title!,
                              style: TextStyle(
                                  fontSize: AppDimensions.twentyTwo,
                                  fontFamily: AppFonts.plusSansBold,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.secondaryTextColor),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(
                                left: AppDimensions.twenty,
                                right: AppDimensions.twenty),
                            child: Text(
                              howWorkModel[i].des!,
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
                      InkWell(
                        onTap: () {
                          AppRouteMaps.goToSelectExerciseDay();
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
                      Row(
                          children: List.generate(
                              howWorkModel.length,
                              (index) => controller.buildDot(
                                  index, context, controller))),
                      MaterialButton(
                          onPressed: () {
                            if (controller.courrentIndex ==
                                howWorkModel.length - 1) {
                              AppRouteMaps.goToSelectExerciseDay();
                            }
                            controller.pageController.nextPage(
                                duration: const Duration(milliseconds: 100),
                                curve: Curves.bounceIn);
                          },
                          child: SvgPicture.asset(AssetsBase.nextButtonSvg)),
                    ],
                  ),
                )
              ],
            ),
          ));
}



