// ignore_for_file: file_names, avoid_print, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_fonts.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/appstyle/assetbase.dart';
import 'package:bandapp/navigation/app_route_maps.dart';
import 'package:bandapp/screen/selectdayandTraining/selectTrainingDay/selectDayScreen_controller.dart';
import 'package:bandapp/widgets/buttonBackground.dart';
import 'package:bandapp/widgets/customBackButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class SelectDayScreenView extends StatefulWidget {
  const SelectDayScreenView({super.key});

  @override
  State<SelectDayScreenView> createState() => _SelectDayScreenViewState();
}

class _SelectDayScreenViewState extends State<SelectDayScreenView> {
  var dsh = Get.isRegistered<SelectDayScreenController>()
      ? Get.find<SelectDayScreenController>()
      : Get.put(SelectDayScreenController());

  @override
  Widget build(BuildContext context) => GetBuilder<SelectDayScreenController>(
      builder: (controller) => Scaffold(
              body: SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: AppDimensions.twenty),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppDimensions.ten),
                  const CustomWithoutTraining(),
                  SizedBox(height: AppDimensions.forty),
                  Text(
                    AppStrings.selectDay,
                    style: TextStyle(
                        fontSize: AppDimensions.twentyEight,
                        fontFamily: AppFonts.plusSansExtraBold,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: AppDimensions.fifTeen),
                  Text(
                    AppStrings.pickWhichDay,
                    style: TextStyle(
                        fontSize: AppDimensions.sixTeen,
                        fontFamily: AppFonts.robotoRegular,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.0,
                        color: AppColors.secondaryTextColor),
                  ),
                  SizedBox(height: AppDimensions.thirty),
                  ListView.builder(
                    itemCount: controller.weekList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return (controller.count < 2)
                          ? GestureDetector(
                              onTap: () {
                                if (controller.count == 2) {
                                  print("next");
                                } else {
                                  if (controller
                                              .weekList[index].isSelectedWeek ==
                                          false &&
                                      controller.count < 2) {
                                    controller.weekList[index].isSelectedWeek =
                                        true;
                                    controller.count++;
                                  } else {
                                    controller.weekList[index].isSelectedWeek =
                                        false;
                                    if (controller.count > 0) {
                                      controller.count--;
                                    }
                                  }
                                  if (controller.count < 2) {
                                    if (index >= 4) {
                                      for (int i = 0;
                                          i < controller.weekList.length;
                                          i++) {
                                        if ((index == 4 &&
                                                (i == 0 || i == 1)) ||
                                            (index == 5 &&
                                                (i == 1 || i == 2)) ||
                                            (index == 6 &&
                                                (i == 2 || i == 3))) {
                                          controller.weekList[i].isVisible =
                                              true;
                                        } else {
                                          if (controller
                                                  .weekList[i].isSelectedWeek ==
                                              false) {
                                            controller.weekList[i].isVisible =
                                                false;
                                          }
                                        }
                                      }
                                    } else {
                                      for (int i = 0;
                                          i < controller.weekList.length;
                                          i++) {
                                        var indexCount;
                                        if (index < 4) {
                                          indexCount = index + 2;
                                          if (i > indexCount) {
                                            if ((i == 5 || i == 6) &&
                                                index == 0) {
                                              if (controller.weekList[i]
                                                      .isSelectedWeek ==
                                                  false) {
                                                controller.weekList[i]
                                                    .isVisible = false;
                                              }
                                            } else if (i == 6 && index == 1) {
                                              if (controller.weekList[i]
                                                      .isSelectedWeek ==
                                                  false) {
                                                controller.weekList[i]
                                                    .isVisible = false;
                                              }
                                            } else {
                                              controller.weekList[i].isVisible =
                                                  true;
                                            }
                                          } else {
                                            if (controller.weekList[i]
                                                    .isSelectedWeek ==
                                                false) {
                                              controller.weekList[i].isVisible =
                                                  false;
                                            }
                                          }
                                        } else {
                                          if (controller
                                                  .weekList[i].isSelectedWeek ==
                                              false) {
                                            controller.weekList[i].isVisible =
                                                false;
                                          }
                                        }
                                      }
                                    }
                                  }

                                  controller.update();
                                }
                              },
                              child: (controller.weekList[index].isVisible ==
                                      true)
                                  ? Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: AppDimensions.eight),
                                      alignment: Alignment.center,
                                      child: (controller.weekList[index]
                                                  .isSelectedWeek !=
                                              true)
                                          ? Container(
                                              alignment: Alignment.center,
                                              height: AppDimensions.sixty,
                                              width: AppDimensions.twoSixty,
                                              decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                      image: Svg(AssetsBase
                                                          .cornerImage),
                                                      fit: BoxFit.cover)),
                                              child: Text(
                                                  controller
                                                      .weekList[index].name!,
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .checkBoxBorderColor,
                                                      fontSize: AppDimensions
                                                          .eighteen,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: AppFonts
                                                          .plusSansBold)),
                                            )
                                          : Column(children: [
                                              TraininDay("Training day"),
                                              SelectDay(controller, index),
                                            ]),
                                    )
                                  : Container(),
                            )
                          : controller.weekList[index].isSelectedWeek == true
                              ? Column(children: [
                                  TraininDay("Training day"),
                                  SelectDay(controller, index),
                                ])
                              : Container();
                    },
                  ),
                  controller.count == 2
                      ? ButtonCommonArrowClass(
                          onTap: (p0) {
                            controller.getNameList.clear();
                            for (int i = 0;
                                i < controller.weekList.length;
                                i++) {
                              if (controller.weekList[i].isSelectedWeek ==
                                  true) {
                                print(controller.weekList[i].isSelectedWeek);
                                print(controller.weekList[i].name);
                                controller.getNameList
                                    .add(controller.weekList[i].name);

                                print("first ==>${controller.getNameList}");
                              }
                            }
                            if (controller.getNameList.isNotEmpty) {
                              controller.getFirstDay = '';
                              controller.getSecondDay = '';
                              controller.getFirstDay =
                                  controller.getNameList[0];
                              controller.getSecondDay =
                                  controller.getNameList[1];
                                  controller.userSelectDayApi(context, controller.getFirstDay, controller.getSecondDay);
                              print("seco ==>${controller.getFirstDay}");
                              print("secon ==>${controller.getSecondDay}");
                            }

                            // AppRouteMaps.goToDashbaordScreen("1");
                          },
                          buttonText: AppStrings.confirmText,
                          isMargin: false)
                      : Container(),
                  SizedBox(height: AppDimensions.forty),
                ],
              ),
            ),
          )));

  Widget SelectDay(SelectDayScreenController controller, int index) {
    var weekList = controller.weekList[index];
    return Container(
      margin:
          EdgeInsets.only(top: AppDimensions.twenty, bottom: AppDimensions.ten),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            weekList.name!,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.sixTextColor,
                fontSize: AppDimensions.twentyTwo,
                fontWeight: FontWeight.w600,
                fontFamily: AppFonts.plusSansMedium),
          ),
          SizedBox(width: AppDimensions.twenty),
          GestureDetector(
              onTap: () {
                if (controller.count == 1) {
                  controller.weekList[index].isSelectedWeek = false;
                  for (int i = 0; i < controller.weekList.length; i++) {
                    controller.weekList[i].isVisible = true;
                    controller.weekList[i].isSelectedWeek = false;
                  }
                } else if (controller.count == 2) {
                  controller.weekList[index].isSelectedWeek = false;
                  controller.weekList[index].isVisible = true;
                  controller.update();
                  var selectedIndex;
                  for (int i = 0; i < controller.weekList.length; i++) {
                    if (controller.weekList[i].isSelectedWeek == true)
                      selectedIndex = i;
                  }

                  if (selectedIndex >= 4) {
                    for (int i = 0; i < controller.weekList.length; i++) {
                      if ((selectedIndex == 4 && (i == 0 || i == 1)) ||
                          (selectedIndex == 5 && (i == 1 || i == 2)) ||
                          (selectedIndex == 6 && (i == 2 || i == 3))) {
                        controller.weekList[i].isVisible = true;
                      } else if (controller.weekList[i].isSelectedWeek ==
                          false) {
                        controller.weekList[i].isVisible = false;
                      }
                    }
                  } else {
                    for (int i = 0; i < controller.weekList.length; i++) {
                      var indexCount;
                      if (selectedIndex < 4) {
                        indexCount = selectedIndex + 2;
                        if (i > indexCount) {
                          if (((i == 5 || i == 6) && selectedIndex == 0) ||
                              (i == 6 && selectedIndex == 1)) {
                            if (controller.weekList[i].isSelectedWeek ==
                                false) {
                              controller.weekList[i].isVisible = false;
                            }
                          } else {
                            controller.weekList[i].isVisible = true;
                          }
                        } else {
                          if (controller.weekList[i].isSelectedWeek == false) {
                            controller.weekList[i].isVisible = false;
                          }
                        }
                      } else if (controller.weekList[i].isSelectedWeek ==
                          false) {
                        controller.weekList[i].isVisible = false;
                      }
                    }
                  }
                }
                if (controller.count > 0) controller.count--;
                controller.update();
              },
              child: Text(
                "Edit",
                style: AppThemeStyle.robotoflex16,
              ))
        ],
      ),
    );
  }

  Widget TraininDay(String showName) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: AppDimensions.thirty),
      child: Text(
        showName,
        style: TextStyle(
            color: AppColors.secondaryTextColor,
            fontSize: AppDimensions.eighteen,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.plusSansBold),
      ),
    );
  }
}
