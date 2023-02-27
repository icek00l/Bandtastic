// ignore_for_file: file_names, must_be_immutable

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/model/cycleModel.dart';
import 'package:bandapp/screen/DashboardScreens/CycleScreen/cycleData/cycleExerData/exerCycleData.dart';
import 'package:bandapp/screen/DashboardScreens/CycleScreen/cycleData/cycleWeekData/weekCycle_controller.dart';
import 'package:bandapp/widgets/customBackButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class WeekDataView extends StatefulWidget {
  const WeekDataView({super.key});

  @override
  State<WeekDataView> createState() => _WeekDataViewState();
}

class _WeekDataViewState extends State<WeekDataView> {
  var dsh = Get.isRegistered<WeekDataController>()
      ? Get.find<WeekDataController>()
      : Get.put(WeekDataController());
  @override
  Widget build(BuildContext context) => GetBuilder<WeekDataController>(
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
                  ),
                )),
            body: SingleChildScrollView(
                child: Container(
              margin: EdgeInsets.symmetric(horizontal: AppDimensions.twenty),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppDimensions.fifTeen),
                  Text(
                    AppStrings.thisweekText,
                    style: AppThemeStyle.heading28Bold,
                  ),
                  SizedBox(height: AppDimensions.twenty),
                  RotatedBoxList(
                      getBoxdata: controller.cycleDataList,
                      weekNames: controller.weekNameList),
                  SizedBox(height: AppDimensions.fifty),
                ],
              ),
            )),
          ));
}

class RotatedBoxList extends StatelessWidget {
  RotatedBoxList(
      {super.key, required this.getBoxdata, required this.weekNames});
  List<CycleModel> getBoxdata;
  List<WeekName> weekNames;
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
        quarterTurns: -1,
        
        child: ListView.builder(
          itemCount: weekNames.length,
          scrollDirection: Axis.horizontal,
shrinkWrap: true,
          
          itemBuilder: (context, index) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                  pushNewScreen(context,
                      screen: ExerDataView(
                       name: weekNames[index].weekName.toString().toUpperCase(),
                      ),
                      withNavBar: true);
                  },
                    child: Text(
                        weekNames[index].weekName.toString().toUpperCase(),
                        style: AppThemeStyle.bandProgess)),
                SizedBox(height: AppDimensions.twenty),
                Container(
                  height: AppDimensions.ten,
                  width: AppDimensions.oneSixty,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppDimensions.fifty),
                      color: AppColors.buttonColor),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: AppDimensions.thirty,
                      right: AppDimensions.thirty,
                      top: AppDimensions.five),
                  width: AppDimensions.oneSixty,
                  height: MediaQuery.of(context).size.height / 3,
                  child: ListView.builder(
                    itemCount: getBoxdata.length,
         physics: const BouncingScrollPhysics(),
shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index1) {
                      return index1 != 5
                          ? Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: AppDimensions.five),
                              padding: EdgeInsets.symmetric(
                                  vertical: AppDimensions.twelve,
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
                                  SizedBox(
                                    width: AppDimensions.eightyPx,
                                    child: Text(
                                        getBoxdata[index1].exerName.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: AppThemeStyle.cycleContainer),
                                  ),
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
                                      vertical: AppDimensions.twelve,
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
                                      SizedBox(
                                        width: AppDimensions.eightyPx,
                                        child: Text(
                                            getBoxdata[index1]
                                                .exerName
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                AppThemeStyle.cycleContainer),
                                      ),
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
                )
              ],
            );
          },
        ));
  }
}
