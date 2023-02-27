// ignore_for_file: file_names, must_be_immutable

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_fonts.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/screen/DashboardScreens/CycleScreen/cycleData/cycleExerData/exerCycle_controller.dart';
import 'package:bandapp/utility/custom_UI.dart';
import 'package:bandapp/widgets/customBackButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class ExerDataView extends StatefulWidget {
  ExerDataView({super.key, required this.name});
  String name = '';
  @override
  State<ExerDataView> createState() => _ExerDataViewState();
}

class _ExerDataViewState extends State<ExerDataView> {
  var dsh = Get.isRegistered<ExerDataController>()
      ? Get.find<ExerDataController>()
      : Get.put(ExerDataController());
  @override
  Widget build(BuildContext context) => GetBuilder<ExerDataController>(
      builder: (controller) => Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(
                    AppDimensions.seventy), // here the desired height
                child: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  elevation: AppDimensions.zero,
                  title: CustomWithNewHeader(
                    getHeadingText: "Wk 1 OF 6 | ${widget.name}",
                    getSubHeadText: AppStrings.cycle,
                    isBackAllow: true,isStyleChange: false,
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
                  UserExerciseDetail(controller2: controller),
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
      itemCount: controller2.cycleDataList.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(controller2.cycleDataList[index].exerName.toString(),
                style: AppThemeStyle.semi22Bold),
            SizedBox(height: AppDimensions.twenty),
            //week list
            weekListView(context),
            SizedBox(height: AppDimensions.twenty),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.symmetric(
                              vertical: AppDimensions.eight,
                              horizontal: AppDimensions.forty),
                          decoration: BoxDecoration(
                              color: AppColors.buttonColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(AppDimensions.four),
                                  topRight: Radius.circular(AppDimensions.four),
                                  bottomLeft:
                                      Radius.circular(AppDimensions.eight),
                                  bottomRight:
                                      Radius.circular(AppDimensions.eight))),
                          alignment: Alignment.center,
                          child: Text(AppStrings.showGraphText,
                              style: TextStyle(
                                  fontSize: AppDimensions.sixTeen,
                                  fontFamily: AppFonts.plusSansBold,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                      ClipPath(
                        clipper: TriangleClipper(),
                        child: Container(
                          margin: EdgeInsets.zero,
                          color: AppColors.buttonColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: AppDimensions.eightyPx,
                            vertical: AppDimensions.ten,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: AppDimensions.ten),
                  child: Row(
                    children: [
                      Text("Total".toUpperCase(),style: AppThemeStyle.robotovblackflex12bold,),
                      Container(
                          margin: EdgeInsets.only(left: AppDimensions.ten),
                          width: AppDimensions.sixtyFive,
                          height: AppDimensions.fifty,
                          decoration: BoxDecoration(
                              color: AppColors.backgColorOne,
                              borderRadius:
                                  BorderRadius.circular(AppDimensions.four)),
                          alignment: Alignment.center,
                          child: Text(
                              controller2.cycleDataList[index].value.toString(),
                              style: AppThemeStyle.bold24)),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: AppDimensions.twenty),
            const CustomCenterLine(),
            SizedBox(height: AppDimensions.thirty),
          ],
        );
      },
    );
  }

  Widget weekListView(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: AppDimensions.hunDred,
      child: ListView.builder(
        itemCount: controller2.weekWiseData.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        controller: controller2.scrollControl,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(
              right: AppDimensions.fifTeen,
            ),
            child: Column(
              children: [
                Text(
                  controller2.weekWiseData[index].weekDay.toString(),
                  style: TextStyle(
                      fontSize: AppDimensions.forteen,
                      fontWeight: FontWeight.w300,
                      fontFamily: AppFonts.robotoFlex),
                ),
                Container(
                    margin: EdgeInsets.only(
                        top: AppDimensions.five, bottom: AppDimensions.five),
                    width: AppDimensions.fortyFive,
                    height: AppDimensions.fifty,
                    decoration: BoxDecoration(
                        color: AppColors.backgColorOne,
                        borderRadius:
                            BorderRadius.circular(AppDimensions.four)),
                    child: Column(
                      mainAxisAlignment: index == 0
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      children: [
                        index == 0
                            ? Text(
                                "Power",
                                style: TextStyle(fontSize: AppDimensions.ten),
                              )
                            : Container(),
                        Text(controller2.weekWiseData[index].power.toString(),
                            style: AppThemeStyle.bold24),
                      ],
                    )),
                Text(
                  controller2.weekWiseData[index].value.toString(),
                  style: TextStyle(
                      fontSize: AppDimensions.forteen,
                      fontFamily: AppFonts.robotoFlex,
                      fontWeight: FontWeight.w600,
                      color: index == 0 ? Colors.black : AppColors.buttonColor),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
