// ignore_for_file: must_be_immutable, file_names, avoid_print, unrelated_type_equality_checks

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_fonts.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/appstyle/assetbase.dart';
import 'package:bandapp/model/bandPositionModal.dart';
import 'package:bandapp/model/bandsModel.dart';
import 'package:bandapp/navigation/app_route_maps.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/sessionMultiScreen/editSessionRevieExer/editExerciseReview_controller.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/sessionMultiScreen/sessionTabbarScreen/progress_band_model.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/sessionMultiScreen/sessionTabbarScreen/progress_view.dart';
import 'package:bandapp/widgets/buttonBackground.dart';
import 'package:bandapp/widgets/customBackButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class EditReviewSessionExerView extends StatefulWidget {
  EditReviewSessionExerView(
      {super.key, required this.name, required this.number,required this.videoURL});
  String name = '', number = '',videoURL = '';
  @override
  State<EditReviewSessionExerView> createState() =>
      _EditReviewSessionExerViewState();
}

class _EditReviewSessionExerViewState extends State<EditReviewSessionExerView> {
  @override
  Widget build(BuildContext context) => GetBuilder<EditReviewSessionController>(
        init: EditReviewSessionController(),
        builder: (controller) => Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(AppDimensions.seventy),
              child: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                elevation: AppDimensions.zero,
                title: CustomWithoutTraining(
                  navigateBack: () {
                    Navigator.pop(context, true);
                    Get.delete<EditReviewSessionController>();
                  },
                ),
              )),
          body: controller.isLoading.value
              ? SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: AppDimensions.ten),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: AppDimensions.fifTeen),
                          ExerciseNameVideo(
                              exerName: widget.name, exerNumber: widget.number,getVideoLink:widget.videoURL),
                          SizedBox(height: AppDimensions.twentyFive),
                          LastSessionClass(controller2: controller),
                        ]),
                  ),
                )
              : Container(),
        ),
      );
}

class ExerciseNameVideo extends StatelessWidget {
  ExerciseNameVideo(
      {Key? key, required this.exerName, required this.exerNumber,required this.getVideoLink})
      : super(key: key);
  String exerName = '', exerNumber = '',getVideoLink = '';
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(exerNumber,
                style: TextStyle(
                    fontSize: AppDimensions.thirty2,
                    fontFamily: AppFonts.robotoBold,
                    fontWeight: FontWeight.bold,
                    color: AppColors.buttonColor)),
            SizedBox(width: AppDimensions.ten),
            SizedBox(
              width: AppDimensions.oneSixty,
              child: Text(exerName,
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

            } else {
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
  LastSessionClass({Key? key, required this.controller2}) : super(key: key);
  EditReviewSessionController controller2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            AppStrings.lastSessionText,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: AppDimensions.twenty,
                fontFamily: AppFonts.plusSansBold,
                fontWeight: FontWeight.w500,
                letterSpacing: 2.0,
                color: AppColors.secondaryTextColor),
          ),
        ),
        SizedBox(height: AppDimensions.thirty),
        PostionAll(
            thisSessionName: controller2.thisSesstionList,
            controller1: controller2),
        NotesAndTotal(controller3: controller2)
      ],
    );
  }
}

class PostionAll extends StatelessWidget {
  PostionAll(
      {super.key, required this.thisSessionName, required this.controller1});
  List<ThisSessionData> thisSessionName;
  EditReviewSessionController controller1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: thisSessionName.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: AppDimensions.seventeen),
          child: index == 1
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
                                      // SizedBox(
                                      //     width: AppDimensions.fifTeen),
                                      GestureDetector(
                                        onTap: () {
                                          if (controller1.bandList.length ==
                                              5) {
                                            controller1.bandList
                                                .removeAt(index);
                                            controller1.calculateValue();
                                            controller1.calculateBandPosition();
                                            if (controller1.timeController
                                                    .text.isNotEmpty) {
                                                  controller1
                                                      .calculateTimeValue(
                                                          controller1
                                                              .timeController
                                                              .text);
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
                                            if (controller1.timeController
                                                    .text.isNotEmpty) {
                                                  controller1
                                                      .calculateTimeValue(
                                                          controller1
                                                              .timeController
                                                              .text);
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
                                            if (controller1.timeController
                                                    .text.isNotEmpty) {
                                                  controller1
                                                      .calculateTimeValue(
                                                          controller1
                                                              .timeController
                                                              .text);
                                                }
                                          } else {
                                            controller1.bandList
                                                .removeAt(index);
                                            controller1.calculateValue();
                                            controller1.calculateBandPosition();
                                            if (controller1.timeController
                                                    .text.isNotEmpty) {
                                                  controller1
                                                      .calculateTimeValue(
                                                          controller1
                                                              .timeController
                                                              .text);
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
              : index == 2
                  ? Row(
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
                      ],
                    )
                  : index == 0
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
                                              right: AppDimensions.five,
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
                                        onChanged: (String value) {},
                                      )),
                                  // SizedBox(width: AppDimensions.fifTeen),
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
                      : index == 6
                          ? Padding(
                              padding:
                                  EdgeInsets.only(top: AppDimensions.twenty),
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
                                              "${controller1.storeAllData.powerDifference} ${controller1.storeAllData.powerDifference.toString().startsWith('-') ? "😔" : "🙂"}",
                                             style: TextStyle(
                                                  fontSize: AppDimensions.sixTeen,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: AppFonts.robotoFlex,
                                                  color:
                                                      AppColors.textButtonColor)),
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
                          : index == 3
                              ? Row(
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
                                                horizontal: AppDimensions.five),
                                            height: AppDimensions.forty,
                                            width: AppDimensions.oneThirty,
                                            decoration: BoxDecoration(
                                              color: Colors.white38,
                                              border: Border.all(
                                                  color: AppColors
                                                      .borderColorThree),
                                            ),
                                            child:
                                                DropdownButton<BandPositonData>(
                                              isExpanded: true,
                                              underline: const SizedBox(),
                                              style: TextStyle(
                                                  fontSize:
                                                      AppDimensions.sixTeen,
                                                  color: Colors.black),
                                              hint: Text(
                                                controller1.getBandPosition,
                                                overflow: TextOverflow.ellipsis,
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
                                                  .map((BandPositonData value) {
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
                                                controller1.getBandPositionID =
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
                                )
                              : index == 4
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
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        right: AppDimensions
                                                            .twenty),
                                                    width: AppDimensions.forty,
                                                    height: AppDimensions.forty,
                                                    child: TextFormField(
                                                      controller: controller1
                                                          .matfromController,
                                                      style: TextStyle(
                                                        fontSize: AppDimensions
                                                            .forteen,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.only(
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
                                                        focusedErrorBorder:
                                                            const OutlineInputBorder(
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
                                                    width: AppDimensions.forty,
                                                    height: AppDimensions.forty,
                                                    child: TextFormField(
                                                      controller: controller1
                                                          .mattoController,
                                                      style: TextStyle(
                                                        fontSize: AppDimensions
                                                            .forteen,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.only(
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
                                                        focusedErrorBorder:
                                                            const OutlineInputBorder(
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
                                  : Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                right: AppDimensions.forty),
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width:
                                                      AppDimensions.oneThirty,
                                                  height: AppDimensions.forty,
                                                  child: TextFormField(
                                                    controller: controller1
                                                        .timeController,
                                                    style: TextStyle(
                                                      fontSize:
                                                          AppDimensions.forteen,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    keyboardType:
                                                        TextInputType.datetime,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              top: AppDimensions
                                                                  .ten,
                                                              left:
                                                                  AppDimensions
                                                                      .five,
                                                              bottom:
                                                                  AppDimensions
                                                                      .ten),
                                                      isDense: true,
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: AppColors
                                                                      .borderColorThree),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .zero),
                                                      focusedBorder:
                                                          const OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: AppColors
                                                                      .borderColorThree),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .zero),
                                                      focusedErrorBorder:
                                                          const OutlineInputBorder(
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
                                                      if (value.isNotEmpty) {
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
                                                  width: AppDimensions.ten),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
        );
      },
    );
  }
}

class NotesAndTotal extends StatelessWidget {
  NotesAndTotal({super.key, required this.controller3});
  EditReviewSessionController controller3;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: AppDimensions.fifty),
        Container(
          margin: EdgeInsets.symmetric(horizontal: AppDimensions.twentyFive),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TwoButtonClass(
                  onTap: () {
                    Navigator.pop(context, false);
                    Get.delete<EditReviewSessionController>();
                  },
                  firstText: AppStrings.cancelText.toUpperCase(),
                  isChangeBack: true),
              TwoButtonClass(
                  onTap: () {
                    controller3.editExerciseApi(context);
                  },
                  firstText: AppStrings.saveText.toUpperCase(),
                  isChangeBack: false),
            ],
          ),
        ),
        SizedBox(height: AppDimensions.thirty),
      ],
    );
  }
}
