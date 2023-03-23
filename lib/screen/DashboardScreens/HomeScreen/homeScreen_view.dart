// ignore_for_file: import_of_legacy_library_into_null_safe, file_names

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_fonts.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/model/exerciseModel.dart';
import 'package:bandapp/model/graphModel.dart';
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
  Widget build(BuildContext context) => GetBuilder<HomeScreenController>(
        builder: (controller) => Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(AppDimensions.seventy), // here the desired height
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: AppDimensions.zero,
                title:const CustomHeader(),
              )),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: AppDimensions.twenty),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppDimensions.fifTeen),
                    WorkoutHeading(exerciseListName: controller.exerciseList),
                    SizedBox(height: AppDimensions.thirty),
                    CenterButtonArrowClass(onTap: (p0) {
                      AppRouteMaps.goToDashbaordScreen("2");
                    }, buttonText: AppStrings.viewSessionText),
                    
                    SizedBox(height: AppDimensions.forty),
                   const CycleHeading(),
                    SizedBox(height: AppDimensions.thirty),
                    ProgressBar(barList: controller.exerciseList),
                    SizedBox(height: AppDimensions.thirty),
                    OverallGraph(graphTextList: controller.exerciseList),
                    SizedBox(height: AppDimensions.fifty),
                  ]),
            ),
          ),
        ),
      );
}


// Workout class
class WorkoutHeading extends StatelessWidget {
  const WorkoutHeading({
    Key? key,
    required this.exerciseListName,
  }) : super(key: key);

  final List<AddExerciseModel> exerciseListName;
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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(right: AppDimensions.twenty,top: AppDimensions.five),
              child: Text(
                "Next session",
                style: TextStyle(
                    fontSize: AppDimensions.sixTeen,
                    fontFamily: AppFonts.robotoFlex,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    color: Colors.black),
              ),
            ),
            Expanded(
                child: Text(
              "Wednesday",
              style: TextStyle(
                  fontSize: AppDimensions.twentyTwo,
                  fontFamily: AppFonts.plusSansMedium,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.0,
                  color: Colors.black),
            )),
          ],
        ),
        SizedBox(height: AppDimensions.thirty),
        ListView.builder(
          physics:const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: exerciseListName.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: AppDimensions.twenty),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    margin: EdgeInsets.only(right: AppDimensions.twenty),
                    child: Text(
                      exerciseListName[index].bodyName!,
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
                      exerciseListName[index].exerciseName!,
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
  const CycleHeading({super.key});

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
              "Week 4 of 6",
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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppDimensions.ten),
      height: AppDimensions.thirty,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: barLightList,
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
  const ProgressBar({
    Key? key,
    required this.barList,
  }) : super(key: key);

  final List<AddExerciseModel> barList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: barList.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: AppDimensions.fifTeen),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  barList[index].bodyName!,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: AppDimensions.sixTeen,
                      fontFamily: AppFonts.robotoFlex,
                      fontWeight: FontWeight.w500,
                      color: AppColors.thirdTextColor),
                ),
              ),
              Expanded(child: Common(barLightList: barList[index].value!)),
              Expanded(
                child: Text(
                  "+${barList[index].value.toString()}",
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
List<GraphData> data = [
  GraphData('w1', 18),
  GraphData('w2', 20),
  GraphData('w3', 28),
  GraphData('w4', 30),
];

class OverallGraph extends StatelessWidget {
  const OverallGraph({
    Key? key,
    required this.graphTextList,
  }) : super(key: key);

  final List<AddExerciseModel> graphTextList;

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
          itemCount: graphTextList.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: AppDimensions.twenty, bottom: AppDimensions.fifTeen,top: AppDimensions.fifty),
                  child: Text(
                    graphTextList[index].bodyName!,
                    style: TextStyle(
                        fontSize: AppDimensions.sixTeen,
                        fontFamily: AppFonts.plusSansBold,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                        color: AppColors.secondaryTextColor),
                  ),
                ),
              const  SimpleLineChart()
              ],
            );
          },
        )
      ],
    );
  }
}

class SimpleLineChart extends StatelessWidget {
  static const myData = [
    ["W1", " 18"],
    ["W2", " 20"],
    ["W3", " 28"],
    ["W4", " 30"],
  ];

  const SimpleLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: LineChart(
        lines: [
          Line<List<String>, String, String>(
            data: myData,
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
            xFn: (datum) => datum[0],
            yFn: (datum) => datum[1],
            xAxis: ChartAxis(
                hideTickNotch: true,
                paint: PaintOptions.fill(
                    color: AppColors.lineGraphColor,
                    strokeCap: StrokeCap.round,
                    strokeWidth: AppDimensions.two)),
            yAxis: ChartAxis(
                opposite: true,
                hideTickNotch: true,
                paint: PaintOptions.fill(
                    color: AppColors.lineGraphColor,
                    strokeCap: StrokeCap.round,
                    strokeWidth: AppDimensions.two)),
          ),
        ],
      ),
    );
  }
}
