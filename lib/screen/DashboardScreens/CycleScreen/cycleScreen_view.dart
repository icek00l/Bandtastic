// ignore_for_file: file_names, must_be_immutable

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/model/cycleModel.dart';
import 'package:bandapp/screen/DashboardScreens/CycleScreen/cycleData/cycleWeekData/weekCycleData.dart';
import 'package:bandapp/screen/DashboardScreens/CycleScreen/cycleScreen_controller.dart';
import 'package:bandapp/widgets/customBackButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class WeekCycleView extends StatefulWidget {
  const WeekCycleView({super.key});

  @override
  State<WeekCycleView> createState() => _WeekCycleViewState();
}

class _WeekCycleViewState extends State<WeekCycleView> {
  var dsh = Get.isRegistered<WeekCycleController>()
      ? Get.find<WeekCycleController>()
      : Get.put(WeekCycleController());
  @override
  Widget build(BuildContext context) => GetBuilder<WeekCycleController>(
      builder: (controller) => Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(
                    AppDimensions.seventy), // here the desired height
                child: AppBar(
                    backgroundColor: Colors.white,
                    elevation: AppDimensions.zero,
                    title: CustomWithTextHeader(
                        getHeadingText: AppStrings.cycle, isBackAllow: false))),
            body: SingleChildScrollView(
                child: Container(
              margin: EdgeInsets.symmetric(horizontal: AppDimensions.twenty),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppDimensions.fifTeen),
                  Text(
                    AppStrings.thisyearText,
                    style: AppThemeStyle.heading28Bold,
                  ),
                  SizedBox(height: AppDimensions.twenty),
                  RotatedBoxList(getBoxdata: controller.cycleDataList),
                  SizedBox(height: AppDimensions.fifty),
                ],
              ),
            )),
          ));
}

class RotatedBoxList extends StatelessWidget {
  RotatedBoxList({super.key, required this.getBoxdata});
  List<CycleModel> getBoxdata;
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
        quarterTurns: -1,
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              children: [
                GestureDetector(
                    onTap: () {
                      pushNewScreen(context,
                          screen: const WeekDataView(), withNavBar: true);
                    },
                    child:
                        Text("THIS CYCLE", style: AppThemeStyle.bandProgess)),
                SizedBox(height: AppDimensions.ten),
                Container(
                  height: AppDimensions.ten,
                  width: AppDimensions.oneSixty,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppDimensions.fifty),
                      color: AppColors.buttonColor),
                ),
                SizedBox(height: AppDimensions.five)
          ,                Container(
                  margin: EdgeInsets.only(
                      left: AppDimensions.thirty,
                      right: AppDimensions.thirty,
                    ),
                  width: AppDimensions.oneSixty,
                  height: MediaQuery.of(context).size.height/2.8,
                  child: GestureDetector(
                    onTap: () {
                       pushNewScreen(context,
                      screen: const WeekDataView(), withNavBar: true);
                    },
                    child: ListView.builder(
                      itemCount: getBoxdata.length,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index1) {
                        return index1 != 5
                            ? Container(
                                margin: EdgeInsets.only(bottom: AppDimensions.five),
                                padding: EdgeInsets.symmetric(
                                    vertical: AppDimensions.ten,
                                    horizontal: AppDimensions.ten),
                                decoration: BoxDecoration(
                                    color: AppColors.buttonColor,
                                    borderRadius: BorderRadius.circular(
                                        AppDimensions.four)),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(getBoxdata[index1].exerName.toString(),
                                        style: AppThemeStyle.cycleContainer),
                                    Text(getBoxdata[index1].value.toString(),
                                        style: AppThemeStyle.cycleContainer)
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.zero,
                                    padding: EdgeInsets.symmetric(
                                        vertical: AppDimensions.thirteen,
                                        horizontal: AppDimensions.ten),
                                    decoration: BoxDecoration(
                                        color: AppColors.buttonColor,
                                        borderRadius: BorderRadius.circular(
                                            AppDimensions.four)),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            getBoxdata[index1]
                                                .exerName
                                                .toString(),
                                            style: AppThemeStyle.cycleContainer),
                                        Text(getBoxdata[index1].value.toString(),
                                            style: AppThemeStyle.cycleContainer)
                                      ],
                                    ),
                                  ),
                                  ClipPath(
                                    clipper: TriangleClipper(),
                                    child: Container(
                                      margin: EdgeInsets.zero,
                                      color: AppColors.buttonColor,
                                      padding: EdgeInsets.symmetric(
                                        vertical: AppDimensions.twenty,
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
        ));
  }
}
