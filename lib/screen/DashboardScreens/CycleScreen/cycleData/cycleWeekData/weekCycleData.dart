// ignore_for_file: file_names, must_be_immutable

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/model/weeklyCycleModal.dart';
import 'package:bandapp/screen/DashboardScreens/CycleScreen/cycleData/cycleExerData/exerCycleData.dart';
import 'package:bandapp/screen/DashboardScreens/CycleScreen/cycleData/cycleWeekData/weekCycle_controller.dart';
import 'package:bandapp/widgets/customBackButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class WeekDataView extends StatelessWidget {
  const WeekDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeekDataController>(
        init: WeekDataController(),
        builder: (controller) => Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(
                      AppDimensions.seventy), // here the desired height
                  child: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    elevation: AppDimensions.zero,
                    title: CustomWithTextHeader(
                      getHeadingText: AppStrings.cycle,
                      isBackAllow: true,
                      navigateBack: () {
                        Navigator.pop(context);
                        Get.delete<WeekDataController>();
                      },
                    ),
                  )),
              body: SingleChildScrollView(
                  child: Container(
                margin: EdgeInsets.symmetric(horizontal: AppDimensions.twenty),
                child: controller.cycleDataList.weeklyData == null
                    ? Container()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          controller.cycleDataList.weeklyData!.isNotEmpty
                              ? SizedBox(height: AppDimensions.fifTeen)
                              : SizedBox(height: AppDimensions.twohunDredten),
                          controller.cycleDataList.weeklyData!.isNotEmpty
                              ? RotatedBoxList(
                                  weekTextGet: "Sessions",
                                  getBoxdata: controller.cycleDataList,
                                  controller1: controller,
                                )
                              : Center(
                                  child: Text(
                                    "No data found for current session",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: AppDimensions.forteen),
                                  ),
                                ),
                          SizedBox(height: AppDimensions.fifty),
                        ],
                      ),
              )),
            ));
  }
}

class RotatedBoxList extends StatelessWidget {
  RotatedBoxList(
      {super.key,
      required this.weekTextGet,
      required this.getBoxdata,
      required this.controller1});
  String weekTextGet = '';
  WeeklyCycleModal getBoxdata;
  WeekDataController controller1;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          weekTextGet,
          style: AppThemeStyle.heading28Bold,
        ),
        RotatedBox(
            quarterTurns: -1,
            child: ListView.builder(
              itemCount: getBoxdata.weeklyData!.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return getBoxdata.weeklyData![index].data!.isEmpty
                    ? const IgnorePointer()
                    : Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                pushNewScreen(context,
                                    screen: ExerDataView(
                                      name: getBoxdata
                                          .weeklyData![index].session
                                          ??"",
                                      sessionID: getBoxdata
                                          .weeklyData![index].sessionId
                                          .toString(),
                                    ),
                                    withNavBar: true);
                              },
                              child: Text(
                                  getBoxdata.weeklyData![index].session
                                      .toString(),
                                  style: AppThemeStyle.bandProgess)),
                          SizedBox(height: AppDimensions.ten),
                          Container(
                            height: AppDimensions.ten,
                            width: AppDimensions.oneSixty,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppDimensions.fifty),
                                color: AppColors.buttonColor),
                          ),
                          SizedBox(height: AppDimensions.five),
                          Container(
                            margin: EdgeInsets.only(
                              left: AppDimensions.thirty,
                              right: AppDimensions.thirty,
                            ),
                            width: AppDimensions.oneSixty,
                            height: MediaQuery.of(context).size.height / 2.8,
                            child: GestureDetector(
                              onTap: () {
                                pushNewScreen(context,
                                    screen: ExerDataView(
                                      name: getBoxdata
                                          .weeklyData![index].session
                                          .toString(),
                                      sessionID: getBoxdata
                                          .weeklyData![index].sessionId
                                          .toString(),
                                    ),
                                    withNavBar: true);
                              },
                              child: ListView.builder(
                                itemCount:
                                    getBoxdata.weeklyData![index].data!.length,
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index1) {
                                  double powerParsedValue = double.parse(
                                      getBoxdata.weeklyData![index]
                                          .data![index1].power
                                          .toString());

                                  int powerValue = powerParsedValue.toInt();
                                  return index1 != 5
                                      ? Container(
                                          margin: EdgeInsets.only(
                                              bottom: AppDimensions.five),
                                          padding: EdgeInsets.symmetric(
                                              vertical: AppDimensions.ten,
                                              horizontal: AppDimensions.five),
                                          decoration: BoxDecoration(
                                              color: AppColors.buttonColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppDimensions.four)),
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: AppDimensions.hunDred,
                                                child: Text(
                                                    getBoxdata
                                                                .weeklyData![
                                                                    index]
                                                                .data![index1]
                                                                .exerciseType
                                                                .toString()
                                                                .length >
                                                            11
                                                        ? "${getBoxdata.weeklyData![index].data![index1].exerciseType.toString().substring(0, 11)}..."
                                                        : getBoxdata
                                                                .weeklyData![
                                                                    index]
                                                                .data![index1]
                                                                .exerciseType ??
                                                            "",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppThemeStyle
                                                        .cycleContainer),
                                              ),
                                              Expanded(
                                                child: Text(
                                                    powerValue
                                                            .toString()
                                                            .startsWith('-')
                                                        ? powerValue.toString()
                                                        : "+$powerValue",
                                                        textAlign: TextAlign.end,
                                                        overflow: TextOverflow.ellipsis,
                                                    style: AppThemeStyle
                                                        .cycleContainer),
                                              )
                                            ],
                                          ),
                                        )
                                      : Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.zero,
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      AppDimensions.thirteen,
                                                  horizontal:
                                                      AppDimensions.ten),
                                              decoration: BoxDecoration(
                                                  color: AppColors.buttonColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppDimensions.four)),
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        AppDimensions.hunDred,
                                                    child: Text(
                                                        getBoxdata
                                                                    .weeklyData![
                                                                        index]
                                                                    .data![
                                                                        index1]
                                                                    .exerciseType
                                                                    .toString()
                                                                    .length >
                                                                11
                                                            ? "${getBoxdata.weeklyData![index].data![index1].exerciseType.toString().substring(0, 11)}..."
                                                            : getBoxdata
                                                                .weeklyData![
                                                                    index]
                                                                .data![index1]
                                                                .exerciseType
                                                                .toString(),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: AppThemeStyle
                                                            .cycleContainer),
                                                  ),
                                                  Text(powerValue.toString(),
                                                      style: AppThemeStyle
                                                          .cycleContainer)
                                                ],
                                              ),
                                            ),
                                            ClipPath(
                                              clipper: TriangleClipper(),
                                              child: Container(
                                                margin: EdgeInsets.zero,
                                                color: AppColors.buttonColor,
                                                padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      AppDimensions.fifTeen,
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                },
                              ),
                            ),
                          )
                        ],
                      );
              },
            )),
      ],
    );
  }
}
