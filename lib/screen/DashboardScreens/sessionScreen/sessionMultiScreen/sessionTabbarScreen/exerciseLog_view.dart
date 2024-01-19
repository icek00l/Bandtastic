// ignore_for_file: file_names, must_be_immutable, avoid_print, unrelated_type_equality_checks

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_fonts.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/appstyle/assetbase.dart';
import 'package:bandapp/model/bandPositionModal.dart';
import 'package:bandapp/model/bandsModel.dart';
import 'package:bandapp/navigation/app_route_maps.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/sessionMultiScreen/sessionTabbarScreen/exerciseLog_controller.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/sessionMultiScreen/sessionTabbarScreen/progress_band_model.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/sessionMultiScreen/sessionTabbarScreen/progress_view.dart';
import 'package:bandapp/utility/Utility.dart';
import 'package:bandapp/widgets/buttonBackground.dart';
import 'package:bandapp/widgets/customBackButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ExerciseLogBandView extends StatefulWidget {
  String? getExerName = '', getNumber = '', getURlHere = '';
  ExerciseLogBandView(
      {super.key, this.getExerName, this.getNumber, this.getURlHere});

  @override
  State<ExerciseLogBandView> createState() => _ExerciseLogBandViewState();
}

class _ExerciseLogBandViewState extends State<ExerciseLogBandView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExerciseLogController>(
      init: ExerciseLogController(),
      builder: (controller) => controller.isLoading.value
          ? Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(
                    AppDimensions.seventy), // here the desired height
                child: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  elevation: AppDimensions.zero,
                  title: CustomWithTextHeader(
                    getHeadingText: "Session",
                    isBackAllow: true,
                    navigateBack: () {
                      Navigator.pop(context, false);
                      Get.delete<ExerciseLogController>();
                    },
                  ),
                ),
              ),
              body: WillPopScope(
                onWillPop: () async {
                  Navigator.pop(context, true);
                  Get.delete<ExerciseLogController>();
                  return true;
                },
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: AppDimensions.ten),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: AppDimensions.fifTeen),
                          ExerciseNameVideo(
                            name: widget.getExerName.toString(),
                            number: widget.getNumber.toString(),
                            getVideoLink: widget.getURlHere.toString(),
                          ),
                          SizedBox(height: AppDimensions.thirtyfive),
                          LastSessionClass(
                              prepData: controller.prepDataList,
                              getControl: controller),
                          SizedBox(height: AppDimensions.seventy),
                          ThisSessionClass(
                            controller2: controller,
                          )
                        ]),
                  ),
                ),
              ),
            )
          : Container(color: Colors.white),
    );
  }
}

class ExerciseNameVideo extends StatelessWidget {
  ExerciseNameVideo({Key? key, required this.name,required this.getVideoLink, required this.number})
      : super(key: key);
  String name, number,getVideoLink;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: AppDimensions.five, right: AppDimensions.five),
              child: Text(number,
                  style: TextStyle(
                      fontSize: AppDimensions.thirty2,
                      fontFamily: AppFonts.robotoBold,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonColor)),
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: AppDimensions.twoTwenty,
              child: Text(name,
                  style: TextStyle(
                      fontSize: AppDimensions.twentyFour,
                      fontFamily: AppFonts.plusSansBold,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondaryTextColor)),
            )
          ],
        ),
        GestureDetector(
          onTap: () {
            if(getVideoLink.isNotEmpty) {
            AppRouteMaps.goToTrainVideoScreen(getVideoLink);

            }else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Sorry no video available for this exercise."),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: AppColors.errorColor,
                        duration: Duration(seconds: 1),
                      ));
                          }
          },
          child: Container(
              height: AppDimensions.seventy,
              width: AppDimensions.hunDred,
              color: AppColors.gradientColor1,
              alignment: Alignment.center,
              child: SvgPicture.asset(AssetsBase.playVideoSvgIcon)),
        )
      ],
    );
  }
}

class LastSessionClass extends StatelessWidget {
  LastSessionClass({Key? key, required this.prepData, required this.getControl})
      : super(key: key);
  final List<LastSessionPrepData> prepData;
  ExerciseLogController getControl;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        prepData.isEmpty
            ? const IgnorePointer()
            : Center(
                child: Text(
                  AppStrings.lastSessionText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: AppDimensions.sixTeen,
                      fontFamily: AppFonts.plusSansExtraBold,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: AppColors.secondaryTextColor),
                ),
              ),
        prepData.isEmpty
            ? const IgnorePointer()
            : SizedBox(height: AppDimensions.thirty),
        prepData.isEmpty
            ? const IgnorePointer()
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: prepData.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: AppDimensions.fifTeen),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(right: AppDimensions.thirty),
                          child: Text(
                            prepData[index].names.toString(),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: AppDimensions.forteen,
                                fontFamily: AppFonts.robotoMedium,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.0,
                                color: AppColors.thirdTextColor),
                          ),
                        ),
                        Container(
                          padding: index == 0 || index == 1
                              ? EdgeInsets.symmetric(
                                  vertical: AppDimensions.two,
                                  horizontal: AppDimensions.ten)
                              : EdgeInsets.symmetric(
                                  vertical: AppDimensions.two),
                          decoration: BoxDecoration(
                              color: index == 0 || index == 1
                                  ? AppColors.greenTextColor
                                  : Colors.white,
                              border: index == 0 || index == 1
                                  ? Border.all(
                                      color: AppColors.greenTextColor,
                                      width: AppDimensions.two)
                                  : Border.all(color: Colors.white),
                              borderRadius:
                                  BorderRadius.circular(AppDimensions.four)),
                          child: Text(
                            prepData[index].value.toString(),
                            style: TextStyle(
                                fontSize: AppDimensions.sixTeen,
                                fontFamily: AppFonts.robotoMedium,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.0,
                                color: index == 0 || index == 1
                                    ? Colors.white
                                    : AppColors.textButtonColor),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
        prepData.isEmpty
            ? const IgnorePointer()
            : SizedBox(height: AppDimensions.forty),
        Center(
          child: Text(
            AppStrings.letsmashText,
            style: TextStyle(
                fontSize: AppDimensions.twentyFour,
                fontFamily: AppFonts.plusSansMedium,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryTextColor),
          ),
        ),
      ],
    );
  }
}

class ThisSessionClass extends StatelessWidget {
  ThisSessionClass({Key? key, required this.controller2}) : super(key: key);
  ExerciseLogController controller2;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            AppStrings.thisSessionText,
            style: TextStyle(
                fontSize: AppDimensions.sixTeen,
                fontFamily: AppFonts.plusSansExtraBold,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: AppColors.secondaryTextColor),
          ),
        ),
        SizedBox(height: AppDimensions.twentyFive),
        SizedBox(height: AppDimensions.eleven),
        PostionAll(
            thisSessionName: controller2.thisSesstionList,
            controller1: controller2),
        SizedBox(height: AppDimensions.eleven),
        NotesAndTotal(
          controller4: controller2,
        )
      ],
    );
  }
}

class PostionAll extends StatelessWidget {
  PostionAll(
      {super.key, required this.thisSessionName, required this.controller1});
  List<ThisSessionData> thisSessionName;
  ExerciseLogController controller1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: thisSessionName.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: AppDimensions.seventeen),
          child: index == 0
              ? controller1.bandList.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: controller1.bandList.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Expanded(
                              child: index == 0
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          right: AppDimensions.thirty,
                                          top: AppDimensions.twenty),
                                      child: Text("*BAND/S",
                                          textAlign: TextAlign.end,
                                          style: AppThemeStyle.robotoMedium13),
                                    )
                                  : const IgnorePointer(),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: index > 0 ? 15 : 0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "BAND ${index + 1}",
                                        textAlign: TextAlign.end,
                                        style: AppThemeStyle.robotoMedium13,
                                      ),
                                      Text(
                                        index == 0
                                            ? controller1.bandList.length > 1
                                                ? "Cancel"
                                                : "BAND ${index + 2}"
                                            : index == 4
                                                ? ""
                                                : "BAND ${index + 2}",
                                        textAlign: TextAlign.end,
                                        style: AppThemeStyle.robotoMedium13,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: AppDimensions.five),
                                        height: AppDimensions.forty,
                                        width: AppDimensions.oneThirty,
                                        decoration: BoxDecoration(
                                          color: Colors.white38,
                                          border: Border.all(
                                              color:
                                                  AppColors.borderColorThree),
                                        ),
                                        child: DropdownButton<BandData>(
                                          isExpanded: true,
                                          underline: const SizedBox(),
                                          style: TextStyle(
                                              fontSize: AppDimensions.sixTeen,
                                              color: Colors.black),
                                          hint: Text(
                                            controller1.bandList[index].names ??
                                                '',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: AppDimensions.sixTeen,
                                                color: Colors.black),
                                          ),
                                          iconEnabledColor:
                                              const Color.fromRGBO(
                                                  76, 73, 73, 0.6),
                                          items: controller1.bandPower
                                              .map((BandData value) {
                                            return DropdownMenuItem<BandData>(
                                              value: value,
                                              child: Text("${value.band}   "),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            controller1.bandList[index].id =
                                                value!.id.toString();
                                            controller1.bandList[index].names =
                                                value.band.toString();
                                            controller1.bandList[index].power =
                                                value.power.toString();
                                            controller1.calculateValue();
                                            controller1.calculateBandPosition();
                                            if (controller1.timeController.text
                                                .isNotEmpty) {
                                              controller1.calculateTimeValue(
                                                  controller1
                                                      .timeController.text);
                                            }
                                            controller1.update();
                                          },
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (controller1.bandList.length ==
                                              5) {
                                            controller1.bandList
                                                .removeAt(index);
                                            controller1.calculateValue();
                                            controller1.calculateBandPosition();
                                            if (controller1.timeController.text
                                                .isNotEmpty) {
                                              controller1.calculateTimeValue(
                                                  controller1
                                                      .timeController.text);
                                            }
                                          } else if (index ==
                                              controller1.bandList.length - 1) {
                                            controller1.bandList.add(
                                                BandDataModel(
                                                    id: controller1
                                                        .bandPower[0].id
                                                        .toString(),
                                                    names: controller1
                                                            .bandPower[0]
                                                            .band ??
                                                        '',
                                                    power: controller1
                                                        .bandPower[0].power
                                                        .toString()));
                                            controller1.calculateValue();
                                            controller1.calculateBandPosition();
                                            if (controller1.timeController.text
                                                .isNotEmpty) {
                                              controller1.calculateTimeValue(
                                                  controller1
                                                      .timeController.text);
                                            }
                                          } else if (index == 0) {
                                            controller1.bandList.clear();
                                            controller1.bandList.add(
                                                BandDataModel(
                                                    id: controller1
                                                        .bandPower[0].id
                                                        .toString(),
                                                    names: controller1
                                                            .bandPower[0]
                                                            .band ??
                                                        '',
                                                    power: controller1
                                                        .bandPower[0].power
                                                        .toString()));
                                            controller1.calculateValue();
                                            controller1.calculateBandPosition();
                                            if (controller1.timeController.text
                                                .isNotEmpty) {
                                              controller1.calculateTimeValue(
                                                  controller1
                                                      .timeController.text);
                                            }
                                          } else {
                                            controller1.bandList
                                                .removeAt(index);
                                            controller1.calculateValue();
                                            controller1.calculateBandPosition();
                                            if (controller1.timeController.text
                                                .isNotEmpty) {
                                              controller1.calculateTimeValue(
                                                  controller1
                                                      .timeController.text);
                                            }
                                          }
                                          controller1.update();
                                        },
                                        child: SvgPicture.asset((controller1
                                                    .bandList.length ==
                                                5)
                                            ? AssetsBase.removeSvgIcon
                                            : index ==
                                                    controller1
                                                            .bandList.length -
                                                        1
                                                ? AssetsBase.addButtonSvgIcon
                                                : AssetsBase.removeSvgIcon),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  : Container()
              : index == 1
                  ? Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        children: [
                          Expanded(child: Container()),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                pushNewScreen(context,
                                    screen: const ProgressionList(),
                                    withNavBar: true);
                              },
                              child: Text(
                                AppStrings.bandProgList,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: AppColors.buttonColor,
                                    fontSize: AppDimensions.sixTeen,
                                    fontFamily: AppFonts.robotoFlex,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          // SizedBox(width: AppDimensions.twenty)
                        ],
                      ),
                    )
                  : index == 6
                      ? Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: AppDimensions.thirty),
                                child: Text(
                                    thisSessionName[index].names.toString(),
                                    textAlign: TextAlign.end,
                                    style: AppThemeStyle.robotoMedium13),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: AppDimensions.oneThirty,
                                      height: AppDimensions.forty,
                                      child: TextFormField(
                                        controller: controller1.notesController,
                                        style: TextStyle(
                                          fontSize: AppDimensions.forteen,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: AppDimensions.ten,
                                              left: AppDimensions.five,
                                              bottom: AppDimensions.ten),
                                          isDense: true,
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppColors
                                                          .borderColorThree),
                                                  borderRadius:
                                                      BorderRadius.zero),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppColors
                                                          .borderColorThree),
                                                  borderRadius:
                                                      BorderRadius.zero),
                                          focusedErrorBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppColors
                                                          .borderColorThree),
                                                  borderRadius:
                                                      BorderRadius.zero),
                                          border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors
                                                      .borderColorThree),
                                              borderRadius: BorderRadius.zero),

                                          // errorText: controller.nameErrorText,
                                          errorStyle: TextStyle(
                                              color: AppColors.errorColor,
                                              fontSize: AppDimensions.thirteen),
                                        ),
                                        onChanged: (String value) {
                                          controller1.getNotes = value;
                                        },
                                      )),
                                  // SizedBox(width: AppDimensions.ten),
                                  GestureDetector(
                                      onTap: () {
                                        if (controller1.speech.isListening) {
                                          controller1.stopListening();
                                        } else {
                                          controller1.startListening();
                                        }
                                      },
                                      child: controller1.speech.isListening
                                          ? const CircleAvatar(
                                              backgroundColor:
                                                  AppColors.greenTextColor,
                                              child: Icon(Icons.mic_off,
                                                  color: Colors.white))
                                          : SvgPicture.asset(
                                              AssetsBase.micButtonSvgIcon))
                                ],
                              ),
                            ),
                          ],
                        )
                      : index == 7
                          ? Padding(
                              padding: EdgeInsets.only(
                                  top: AppDimensions.twenty, right: 0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: AppDimensions.thirty),
                                      child: Text(
                                          thisSessionName[index]
                                              .names
                                              .toString(),
                                          textAlign: TextAlign.end,
                                          style: AppThemeStyle.robotoMedium13),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                              "${controller1.getPowerDiffer} ${controller1.powerEmoji}",
                                              style: TextStyle(
                                                  fontSize:
                                                      AppDimensions.sixTeen,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      AppFonts.robotoFlex,
                                                  color: AppColors
                                                      .textButtonColor)),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text("TOTAL  ",
                                                  style: AppThemeStyle
                                                      .robotoMedium13),
                                              Expanded(
                                                child: Text(
                                                    controller1.getBandPower,
                                                    style: TextStyle(
                                                        fontSize: AppDimensions
                                                            .sixTeen,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            AppFonts.robotoFlex,
                                                        color: AppColors
                                                            .textButtonColor)),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : index == 2
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right: AppDimensions.thirty),
                                          child: Text(
                                              thisSessionName[index]
                                                  .names
                                                  .toString(),
                                              textAlign: TextAlign.end,
                                              style:
                                                  AppThemeStyle.robotoMedium13),
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      AppDimensions.five),
                                              height: AppDimensions.forty,
                                              width: AppDimensions.oneThirty,
                                              decoration: BoxDecoration(
                                                color: Colors.white38,
                                                border: Border.all(
                                                    color: AppColors
                                                        .borderColorThree),
                                              ),
                                              child: DropdownButton<
                                                  BandPositonData>(
                                                isExpanded: true,
                                                underline: const SizedBox(),
                                                style: TextStyle(
                                                    fontSize:
                                                        AppDimensions.sixTeen,
                                                    color: Colors.black),
                                                hint: Text(
                                                  controller1.getBandPosition,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize:
                                                          AppDimensions.sixTeen,
                                                      color: Colors.black),
                                                ),
                                                iconEnabledColor:
                                                    const Color.fromRGBO(
                                                        76, 73, 73, 0.6),
                                                items: controller1
                                                    .bandPositionList
                                                    .map((BandPositonData
                                                        value) {
                                                  return DropdownMenuItem<
                                                      BandPositonData>(
                                                    value: value,
                                                    child: Text(
                                                        "${value.position}   "),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  controller1.getBandPosition =
                                                      value!.position!;
                                                  controller1
                                                          .getBandPositionID =
                                                      value.id!.toString();
                                                  controller1.getBandValue =
                                                      value.value!;
                                                  controller1.calculateValue();
                                                  controller1
                                                      .calculateBandPosition();
                                                  if (controller1.timeController
                                                      .text.isNotEmpty) {
                                                    controller1
                                                        .calculateTimeValue(
                                                            controller1
                                                                .timeController
                                                                .text);
                                                  }

                                                  controller1.update();
                                                },
                                              ),
                                            ),
                                            SizedBox(width: AppDimensions.ten),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : index == 5
                                  ? Padding(
                                      padding: const EdgeInsets.only(right: 0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  right: AppDimensions.thirty),
                                              child: Text(
                                                  thisSessionName[index]
                                                      .names
                                                      .toString(),
                                                  textAlign: TextAlign.end,
                                                  style: AppThemeStyle
                                                      .robotoMedium13),
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          AppDimensions.five),
                                                  height: AppDimensions.forty,
                                                  width:
                                                      AppDimensions.oneThirty,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white38,
                                                    border: Border.all(
                                                        color: AppColors
                                                            .borderColorThree),
                                                  ),
                                                  child:
                                                      DropdownButton<RepsList>(
                                                    isExpanded: true,
                                                    underline: const SizedBox(),
                                                    style: TextStyle(
                                                        fontSize: AppDimensions
                                                            .sixTeen,
                                                        color: Colors.black),
                                                    hint: Text(
                                                      controller1.getReps,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize:
                                                              AppDimensions
                                                                  .sixTeen,
                                                          color: Colors.black),
                                                    ),
                                                    iconEnabledColor:
                                                        const Color.fromRGBO(
                                                            76, 73, 73, 0.6),
                                                    items: controller1
                                                        .repsDataList
                                                        .map((RepsList value) {
                                                      return DropdownMenuItem<
                                                          RepsList>(
                                                        value: value,
                                                        child: Text(
                                                            "${value.names}   "),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      controller1.getReps =
                                                          value!.names!;

                                                      controller1.update();
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: AppDimensions.ten),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : index == 3
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(right: 0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right:
                                                          AppDimensions.thirty),
                                                  child: Text(
                                                      thisSessionName[index]
                                                          .names
                                                          .toString(),
                                                      textAlign: TextAlign.end,
                                                      style: AppThemeStyle
                                                          .robotoMedium13),
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            right: AppDimensions
                                                                .twenty),
                                                        width:
                                                            AppDimensions.forty,
                                                        height:
                                                            AppDimensions.forty,
                                                        child: TextFormField(
                                                          controller: controller1
                                                              .matfromController,
                                                          style: TextStyle(
                                                            fontSize:
                                                                AppDimensions
                                                                    .forteen,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          textInputAction:
                                                              TextInputAction
                                                                  .done,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding: EdgeInsets.only(
                                                                top:
                                                                    AppDimensions
                                                                        .ten,
                                                                left:
                                                                    AppDimensions
                                                                        .five,
                                                                bottom:
                                                                    AppDimensions
                                                                        .ten),
                                                            isDense: true,
                                                            enabledBorder: const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: AppColors
                                                                        .borderColorThree),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .zero),
                                                            focusedBorder: const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: AppColors
                                                                        .borderColorThree),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .zero),
                                                            focusedErrorBorder: const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: AppColors
                                                                        .borderColorThree),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .zero),
                                                            border: const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: AppColors
                                                                        .borderColorThree),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .zero),

                                                            // errorText: controller.nameErrorText,
                                                            errorStyle: TextStyle(
                                                                color: AppColors
                                                                    .errorColor,
                                                                fontSize:
                                                                    AppDimensions
                                                                        .thirteen),
                                                          ),
                                                        )),
                                                    Text("to",
                                                        style: AppThemeStyle
                                                            .robotoMedium13),
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: AppDimensions
                                                                .twenty),
                                                        width:
                                                            AppDimensions.forty,
                                                        height:
                                                            AppDimensions.forty,
                                                        child: TextFormField(
                                                          controller: controller1
                                                              .mattoController,
                                                          style: TextStyle(
                                                            fontSize:
                                                                AppDimensions
                                                                    .forteen,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          textInputAction:
                                                              TextInputAction
                                                                  .done,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding: EdgeInsets.only(
                                                                top:
                                                                    AppDimensions
                                                                        .ten,
                                                                left:
                                                                    AppDimensions
                                                                        .five,
                                                                bottom:
                                                                    AppDimensions
                                                                        .ten),
                                                            isDense: true,
                                                            enabledBorder: const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: AppColors
                                                                        .borderColorThree),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .zero),
                                                            focusedBorder: const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: AppColors
                                                                        .borderColorThree),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .zero),
                                                            focusedErrorBorder: const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: AppColors
                                                                        .borderColorThree),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .zero),
                                                            border: const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: AppColors
                                                                        .borderColorThree),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .zero),

                                                            // errorText: controller.nameErrorText,
                                                            errorStyle: TextStyle(
                                                                color: AppColors
                                                                    .errorColor,
                                                                fontSize:
                                                                    AppDimensions
                                                                        .thirteen),
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(right: 0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right:
                                                          AppDimensions.thirty),
                                                  child: Text(
                                                      thisSessionName[index]
                                                          .names
                                                          .toString(),
                                                      textAlign: TextAlign.end,
                                                      style: AppThemeStyle
                                                          .robotoMedium13),
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                        width: AppDimensions
                                                            .oneThirty,
                                                        height:
                                                            AppDimensions.forty,
                                                        child: TextFormField(
                                                          controller: controller1
                                                              .timeController,
                                                          style: TextStyle(
                                                            fontSize:
                                                                AppDimensions
                                                                    .forteen,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          textInputAction:
                                                              TextInputAction
                                                                  .done,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: [
                                                            LengthLimitingTextInputFormatter(
                                                                5),
                                                            FilteringTextInputFormatter
                                                                .digitsOnly
                                                          ],
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding: EdgeInsets.only(
                                                                top:
                                                                    AppDimensions
                                                                        .ten,
                                                                left:
                                                                    AppDimensions
                                                                        .five,
                                                                bottom:
                                                                    AppDimensions
                                                                        .ten),
                                                            isDense: true,
                                                            enabledBorder: const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: AppColors
                                                                        .borderColorThree),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .zero),
                                                            focusedBorder: const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: AppColors
                                                                        .borderColorThree),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .zero),
                                                            focusedErrorBorder: const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: AppColors
                                                                        .borderColorThree),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .zero),
                                                            border: const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: AppColors
                                                                        .borderColorThree),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .zero),
                                                            errorStyle: TextStyle(
                                                                color: AppColors
                                                                    .errorColor,
                                                                fontSize:
                                                                    AppDimensions
                                                                        .thirteen),
                                                          ),
                                                          onChanged: (value) {
                                                            if (value
                                                                .isNotEmpty) {
                                                              controller1
                                                                  .calculateValue();
                                                              controller1
                                                                  .calculateBandPosition();
                                                              controller1
                                                                  .calculateTimeValue(
                                                                      value);
                                                            } else {
                                                              controller1
                                                                  .calculateValue();
                                                              controller1
                                                                  .calculateBandPosition();
                                                            }
                                                          },
                                                        )),
                                                    SizedBox(
                                                        width:
                                                            AppDimensions.ten),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
        );
      },
    );
  }
}

class NotesAndTotal extends StatelessWidget {
  NotesAndTotal({super.key, required this.controller4});
  ExerciseLogController controller4;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: AppDimensions.fifty),
        CenterButtonArrowClass(
            onTap: (p0) {
              bool isSelectColor = false;
              for (int i = 0; i < controller4.bandList.length; i++) {
                if (controller4.bandList[i].names == "Select one") {
                  isSelectColor = true;
                  controller4.update();
                }
              }
              if (controller4.errorCount == 1) {
                controller4.createExercise(context);
              } else {
                if (isSelectColor == true) {
                  print("object");
                  Utility.showYesNoCommonDialog(
                    'Are you sure you want to progress without entering a Band/s?',
                    () {
                      Navigator.of(Get.context!, rootNavigator: true)
                          .pop('dialog');
                    },
                    () {
                      print("success");
                      Navigator.of(Get.context!, rootNavigator: true)
                          .pop('dialog');
                      controller4.createExercise(context);
                    },
                  );
                  // controller4.errorCount++;
                } else if (controller4.timeController.text.isEmpty) {
                  print("time  empty");

                  Utility.showYesNoCommonDialog(
                    'Are you sure you want to progress without entering a time?',
                    () {
                      Navigator.of(Get.context!, rootNavigator: true)
                          .pop('dialog');
                    },
                    () {
                      print("success");
                      Navigator.of(Get.context!, rootNavigator: true)
                          .pop('dialog');
                      controller4.createExercise(context);
                    },
                  );
                  // controller4.errorCount++;
                } else {
                  controller4.createExercise(context);
                }
              }
            },
            buttonText: AppStrings.nextUP),
        SizedBox(height: AppDimensions.thirty),
      ],
    );
  }
}
