// ignore_for_file: import_of_legacy_library_into_null_safe, file_names, must_be_immutable

import 'dart:convert';
import 'dart:math';
import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_fonts.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/model/exerciseModel.dart';
import 'package:bandapp/navigation/app_route_maps.dart';
import 'package:bandapp/screen/DashboardScreens/HomeScreen/homeScreen_controller.dart';
import 'package:bandapp/widgets/buttonBackground.dart';
import 'package:bandapp/widgets/customBackButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:fcharts/fcharts.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  var dsh = Get.isRegistered<HomeScreenController>()
      ? Get.find<HomeScreenController>()
      : Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
        builder: (controller) => Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(
                    AppDimensions.seventy), // here the desired height
                child: AppBar(
                  backgroundColor: Colors.white,
                  elevation: AppDimensions.zero,
                  title: const CustomHeader(),
                )),
            body:
                controller.isLoading.value
                    ? SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: AppDimensions.twenty),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: AppDimensions.fifTeen),
                                WorkoutHeading(
                                    exerciseListName: controller.exerciseList,
                                    controller2: controller),
                                SizedBox(height: AppDimensions.thirty),
                                CenterButtonArrowClass(
                                    onTap: (p0) {
                                      AppRouteMaps.goToDashbaordScreen("2");
                                    },
                                    buttonText: AppStrings.viewSessionText),
                                SizedBox(height: AppDimensions.forty),
                                CycleHeading(controller3: controller),
                                SizedBox(height: AppDimensions.thirty),
                                ProgressBar(controller1: controller),
                                SizedBox(height: AppDimensions.thirty),
                                OverallGraph(controller4: controller),
                                SizedBox(height: AppDimensions.fifty),
                              ]),
                        ),
                      ):Container()
                   ),
      );
}
}

// Workout class
class WorkoutHeading extends StatelessWidget {
  WorkoutHeading(
      {Key? key, required this.exerciseListName, required this.controller2})
      : super(key: key);

  final List<AddExerciseModel> exerciseListName;
  HomeScreenController controller2;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.workout,
          style: AppThemeStyle.heading28Bold,
        ),
        SizedBox(height: AppDimensions.twentyFive),
        
        Align(
          alignment: Alignment.center,
            child: Text(
          controller2.getSessionDay.isNotEmpty
              ? controller2.getSessionDay
              : "",
          style: TextStyle(
              fontSize: AppDimensions.twentyTwo,
              fontFamily: AppFonts.plusSansMedium,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.0,
              color: Colors.black),
        )),
        SizedBox(height: AppDimensions.thirty),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller2.homeDataList.exerciseInfo!.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: AppDimensions.twenty),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    margin: EdgeInsets.only(right: AppDimensions.twenty),
                    child: Text(
                      controller2.homeDataList.exerciseInfo == null &&
                              controller2
                                      .homeDataList.exerciseInfo![index].name ==
                                  null
                          ? ""
                          : controller2.homeDataList.exerciseInfo![index].name
                              .toString(),
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: AppDimensions.sixTeen,
                          fontFamily: AppFonts.robotoFlex,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.0,
                          color: AppColors.thirdTextColor),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      controller2.homeDataList.exerciseInfo![index]
                              .exerciseType!.exerciseTypeInfo!.name ??
                          "",
                      style: TextStyle(
                          fontSize: AppDimensions.eighteen,
                          fontFamily: AppFonts.robotoFlex,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.0,
                          color: Colors.black),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

// cycle class
class CycleHeading extends StatelessWidget {
  CycleHeading({super.key, required this.controller3});
  HomeScreenController controller3;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.cycle,
          style: TextStyle(
              fontSize: AppDimensions.twentyFour,
              fontFamily: AppFonts.plusSansBold,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.0,
              color: AppColors.secondaryTextColor),
        ),
        SizedBox(height: AppDimensions.thirty),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: Container(
                    margin: EdgeInsets.only(left: AppDimensions.twenty),
                    child: Text(
                      "This cycle",
                      style: TextStyle(
                          fontSize: AppDimensions.sixTeen,
                          fontFamily: AppFonts.robotoFlex,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          color: Colors.black),
                    ))),
            Expanded(
                child: Text(
              "Week ${controller3.weekNumberstore} of 4",
              style: TextStyle(
                  fontSize: AppDimensions.twentyTwo,
                  fontFamily: AppFonts.plusSansMedium,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.0,
                  color: Colors.black),
            )),
          ],
        ),
      ],
    );
  }
}

class Common extends StatelessWidget {
  const Common({
    Key? key,
    required this.barLightList,
  }) : super(key: key);

  final int barLightList;
  @override
  Widget build(BuildContext context) {
    var storeValue = 0;
    if (barLightList > 5) {
      storeValue = 10;
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppDimensions.ten),
      height: AppDimensions.thirty,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: storeValue,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Container(
                height: AppDimensions.forty,
                width: AppDimensions.twelve,
                margin: EdgeInsets.symmetric(horizontal: AppDimensions.one),
                decoration: BoxDecoration(
                    color: AppColors.buttonColor,
                    borderRadius: BorderRadius.circular(AppDimensions.three)),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  ProgressBar({
    Key? key,
    required this.controller1,
  }) : super(key: key);
  HomeScreenController controller1;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller1.cycleListData.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: AppDimensions.fifTeen),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  controller1.cycleListData[index].name!,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: AppDimensions.sixTeen,
                      fontFamily: AppFonts.robotoFlex,
                      fontWeight: FontWeight.w500,
                      color: AppColors.thirdTextColor),
                ),
              ),
              Expanded(
                  child: Common(
                      barLightList: controller1.cycleListData[index].power!)),
              Expanded(
                child: Text(
                  "+${controller1.cycleListData[index].power.toString()}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: AppDimensions.sixTeen,
                      fontFamily: AppFonts.robotoFlex,
                      fontWeight: FontWeight.w500,
                      // fontStyle: FontStyle.italic,
                      color: AppColors.thirdTextColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// overallGraph

class OverallGraph extends StatelessWidget {
  OverallGraph({
    Key? key,
    required this.controller4,
  }) : super(key: key);

  HomeScreenController controller4;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.overall,
          style: TextStyle(
              fontSize: AppDimensions.twentyFour,
              fontFamily: AppFonts.plusSansBold,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.0,
              color: AppColors.secondaryTextColor),
        ),
        SizedBox(height: AppDimensions.forty),
        ListView.builder(
          itemCount: controller4.graphListData.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final span = DoubleSpan(-30, 300);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: AppDimensions.twenty,
                      bottom: AppDimensions.fifTeen,
                      top: AppDimensions.fifty),
                  child: Text(
                    controller4.graphListData[index].exercise!,
                    style: TextStyle(
                        fontSize: AppDimensions.sixTeen,
                        fontFamily: AppFonts.plusSansBold,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                        color: AppColors.secondaryTextColor),
                  ),
                ),
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: LineChart(
                    lines: [
                      Line(
                        data: controller4.graphListData[index].data,
                        curve: LineCurves.cardinalSpline,
                        marker: const MarkerOptions(
                            paint: PaintOptions.fill(
                          color: AppColors.buttonColor,
                          strokeCap: StrokeCap.round,
                        )),
                        stroke: PaintOptions.stroke(
                          color: AppColors.buttonColor,
                          strokeWidth: AppDimensions.three,
                        ),
                        xFn: (datum) => datum.name,
                        yFn: (datum) => datum.value,
                        xAxis: ChartAxis(
                            hideTickNotch: true,
                            opposite: false,
                            paint: PaintOptions.fill(
                                color: AppColors.lineGraphColor,
                                strokeCap: StrokeCap.round,
                                strokeWidth: AppDimensions.two)),
                        yAxis: ChartAxis(
                            opposite: true,
                            hideTickNotch: true,
                            span: span,
                            offset: -5,
                            paint: PaintOptions.fill(
                                color: AppColors.lineGraphColor,
                                strokeCap: StrokeCap.round,
                                strokeWidth: AppDimensions.two)),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
