// ignore_for_file: file_names, must_be_immutable

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/screen/DashboardScreens/CycleScreen/cycleData/cycleWeekData/weekCycleData.dart';
import 'package:bandapp/screen/DashboardScreens/CycleScreen/cycleScreen_controller.dart';
import 'package:bandapp/utility/sharePrefs/shared_pref_key.dart';
import 'package:bandapp/utility/sharePrefs/shared_prefs.dart';
import 'package:bandapp/widgets/customBackButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:intl/intl.dart';

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
  Widget build(BuildContext context) {
    dsh.onInit();
    return GetBuilder<WeekCycleController>(
        builder: (controller) => Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(
                      AppDimensions.seventy), // here the desired height
                  child: AppBar(
                      backgroundColor: Colors.white,
                      elevation: AppDimensions.zero,
                      title: CustomWithTextHeader(
                        getHeadingText: AppStrings.cycle,
                        isBackAllow: false,
                        navigateBack: () {
                          Navigator.pop(context);
                        },
                      ))),
              body: controller.isLoading
                  ? Container()
                  : SingleChildScrollView(
                      child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: AppDimensions.twenty),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: AppDimensions.fifTeen),
                          Text(
                            AppStrings.thisyearText,
                            style: AppThemeStyle.heading28Bold,
                          ),
                          controller.yearlyCycleList.isNotEmpty
                              ? SizedBox(height: AppDimensions.twenty)
                              : SizedBox(height: AppDimensions.twohunDredten),
                          controller.yearlyCycleList.isNotEmpty
                              ? RotatedBoxList(controller1: controller)
                              : Center(
                                  child: Text(
                                    "No data found",
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
  RotatedBoxList({super.key, required this.controller1});
  WeekCycleController controller1;
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
        quarterTurns: -1,
        child: ListView.builder(
          itemCount: controller1.yearlyCycleList.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            String dateString =
                controller1.yearlyCycleList[index].month.toString();
            List<String> dateParts = dateString.split("-");
            DateTime storeFirstDate = DateTime.parse(
                "${dateParts[0]}-${dateParts[1]}-${dateParts[2]}");
            DateTime storeEndDate = DateTime.parse(
                "${dateParts[3]}-${dateParts[4]}-${dateParts[5]}");

            String getMonthAbbreviation(int month) {
              List<String> months = [
                "Jan",
                "Feb",
                "Mar",
                "Apr",
                "May",
                "Jun",
                "Jul",
                "Aug",
                "Sep",
                "Oct",
                "Nov",
                "Dec"
              ];
              return months[month - 1];
            }

            String combinedDate =
                "${storeFirstDate.day.toString().padLeft(2, '0')}   ${getMonthAbbreviation(storeFirstDate.month)}";
            combinedDate +=
                " - ${storeEndDate.day.toString().padLeft(2, '0')}   ${getMonthAbbreviation(storeEndDate.month)}";

            return Column(
              children: [
                GestureDetector(
                    onTap: () {
                      pushNewScreen(context,
                          screen: WeekDataView(), withNavBar: true);
                    },
                    child: Text(
                        index == controller1.yearlyCycleList.length - 1
                            ? "This"
                            : combinedDate,
                        style: AppThemeStyle.bandProgess)),
                SizedBox(height: AppDimensions.ten),
                Container(
                  height: AppDimensions.ten,
                  width: AppDimensions.oneSixty,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppDimensions.fifty),
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
                      var firstDateForm =
                          DateFormat('yyyy-MM-dd').format(storeFirstDate);
                      var endDateForm =
                          DateFormat('yyyy-MM-dd').format(storeEndDate);
                      SharedPrefs.saveStringInPrefs(
                          SharedPrefKeys.firstDate, firstDateForm.toString());
                      SharedPrefs.saveStringInPrefs(
                              SharedPrefKeys.secondDate, endDateForm.toString())
                          .then((value) {
                        pushNewScreen(context,
                            screen: WeekDataView(), withNavBar: true);
                      });
                    },
                    child: ListView.builder(
                      itemCount:
                          controller1.yearlyCycleList[index].data!.length,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index1) {
                        return index1 !=
                                controller1
                                        .yearlyCycleList[index].data!.length -
                                    1
                            ? Container(
                                margin:
                                    EdgeInsets.only(bottom: AppDimensions.five),
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
                                    Text(
                                        controller1.yearlyCycleList[index]
                                            .data![index1].exercise
                                            .toString(),
                                        style: AppThemeStyle.cycleContainer),
                                    Text(
                                        controller1.yearlyCycleList[index]
                                            .data![index1].power
                                            .toString(),
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
                                            controller1.yearlyCycleList[index]
                                                .data![index1].exercise
                                                .toString(),
                                            style:
                                                AppThemeStyle.cycleContainer),
                                        Text(
                                            controller1.yearlyCycleList[index]
                                                .data![index1].power
                                                .toString(),
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
                                        vertical: AppDimensions.fifTeen,
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
