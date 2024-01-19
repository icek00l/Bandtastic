// ignore_for_file: file_names, must_be_immutable

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_fonts.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/appstyle/assetbase.dart';
import 'package:bandapp/screen/DashboardScreens/CycleScreen/cycleData/cycleExerData/exerCycle_controller.dart';
import 'package:bandapp/screen/DashboardScreens/CycleScreen/cycleData/cycleExerData/showGraph_view.dart';
import 'package:bandapp/utility/custom_UI.dart';
import 'package:bandapp/widgets/customBackButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ExerDataView extends StatefulWidget {
  ExerDataView({
    super.key,
    required this.name,
    required this.sessionID,
  });
  String name = '', sessionID = '';
  @override
  State<ExerDataView> createState() => _ExerDataViewState();
}

class _ExerDataViewState extends State<ExerDataView> {
  @override
  Widget build(BuildContext context) => GetBuilder<ExerDataController>(
      init: ExerDataController(
        sessionIDGet: widget.sessionID,
      ),
      builder: (controller) => Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(
                    AppDimensions.eightyPx), // here the desired height
                child: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  elevation: AppDimensions.zero,
                  title: CustomWithNewHeader(
                    getHeadingText: widget.name.toUpperCase(),
                    getSubHeadText: AppStrings.cycle,
                    isBackAllow: true,
                    isStyleChange: true,
                  ),
                )),
            body: SingleChildScrollView(
                child: Container(
              margin: EdgeInsets.symmetric(horizontal: AppDimensions.twenty),
              child: controller.isLoading
                  ? Center(
                                  child: Text(
                                    "No data found for current session",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: AppDimensions.forteen),
                                  ),
                                )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: AppDimensions.ten),
                        SizedBox(height: AppDimensions.twenty),
                        controller.dayReviewExerData.exerciseData == null
                            ? Container(
                                alignment: Alignment.center,
                                child: Text(
                                    "You have not done any exercise please complete your exercise",
                                    style: AppThemeStyle.semi22Bold),
                              )
                            : UserExerciseDetail(controller2: controller),
                        SizedBox(height: AppDimensions.fifty),
                      ],
                    ),
            )),
          ));
}

class UserExerciseDetail extends StatelessWidget {
  UserExerciseDetail({super.key, required this.controller2});
  ExerDataController controller2;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller2.dayReviewExerData.exerciseData!.length,
      itemBuilder: (context, index) {
        return controller2.dayReviewExerData.exerciseData![index].data!.isEmpty
            ? const IgnorePointer()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      controller2.dayReviewExerData.exerciseData![index]
                              .exercise ??
                          "",
                      style: AppThemeStyle.semi22Bold),
                  SizedBox(height: AppDimensions.twenty),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: AppDimensions.hunDred,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ListView.builder(
                          itemCount: controller2.dayReviewExerData
                              .exerciseData![index].data!.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index1) {
                            double powerParsedValue = double.parse(controller2
                                .dayReviewExerData
                                .exerciseData![index]
                                .data![index1]
                                .totalPower
                                .toString());

                            int powervalue = powerParsedValue.toInt();

                            print(
                                'powervalue down value using toInt(): $powervalue');
                            return Container(
                              margin: EdgeInsets.only(
                                right: AppDimensions.twenty,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    controller2
                                            .dayReviewExerData
                                            .exerciseData![index]
                                            .data![index1]
                                            .name ??
                                        "",
                                    style: TextStyle(
                                        fontSize: AppDimensions.forteen,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: AppFonts.robotoFlex),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: AppDimensions.five,
                                          bottom: AppDimensions.five),
                                      height: AppDimensions.fifty,
                                      width: AppDimensions.fifty,
                                      decoration: BoxDecoration(
                                          color: AppColors.backgColorOne,
                                          borderRadius: BorderRadius.circular(
                                              AppDimensions.four)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            index1 == 0 ? "Power" : "",
                                            style: TextStyle(
                                                fontSize: AppDimensions.ten,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(
                                            child: Text("$powervalue",
                                            overflow:powervalue.toString().length < 4 ? TextOverflow.visible: TextOverflow.ellipsis,
                                                style: AppThemeStyle.bold24),
                                          ),
                                        ],
                                      )),
                                  Text(
                                    index1 == 0
                                        ? "Change"
                                        : controller2
                                                .dayReviewExerData
                                                .exerciseData![index]
                                                .data![index1]
                                                .value
                                                .toString(),
                                                
                                    style: TextStyle(
                                        fontSize: AppDimensions.forteen,
                                        fontFamily: AppFonts.robotoFlex,
                                        fontWeight: FontWeight.w300,
                                        color: index1 == 0
                                            ? Colors.black
                                            : AppColors.buttonColor),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Column(
                          children: [
                            Text(
                              "Total".toUpperCase(),
                              style: AppThemeStyle.robotovblackflex12bold
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.4),
                            ),
                            SizedBox(height: AppDimensions.five),
                            Container(
                                width: AppDimensions.sixtyFive,
                                height: AppDimensions.fiftyFive,
                                decoration: BoxDecoration(
                                    color: AppColors.buttonColor,
                                    borderRadius: BorderRadius.circular(
                                        AppDimensions.four)),
                                alignment: Alignment.center,
                                child: Text(
                                    controller2
                                            .dayReviewExerData
                                            .exerciseData![index]
                                            .overallTotal.toString(),
                                            
                                    style: AppThemeStyle.bold24
                                        .copyWith(color: Colors.white,fontSize: AppDimensions.eighteen))),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: AppDimensions.twenty),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        pushNewScreen(context,
                            screen: ShowGraphView(
                              getName: controller2.dayReviewExerData
                                      .exerciseData![index].exercise ??
                                  "",
                              getGraphPoints: controller2
                                  .dayReviewExerData.exerciseData![index].data!,
                            ),
                            withNavBar: true);
                      },
                      child: SvgPicture.asset(AssetsBase.showGraphSvg),
                    ),
                  ),
                  SizedBox(height: AppDimensions.twenty),
                  const CustomCenterLine(),
                  SizedBox(height: AppDimensions.thirty),
                ],
              );
      },
    );
  }
}
