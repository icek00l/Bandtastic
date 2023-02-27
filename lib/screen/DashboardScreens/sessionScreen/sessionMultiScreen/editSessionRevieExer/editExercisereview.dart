// ignore_for_file: must_be_immutable, file_names

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_fonts.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/appstyle/assetbase.dart';
import 'package:bandapp/model/bandsModel.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/sessionMultiScreen/editSessionRevieExer/editExerciseReview_controller.dart';
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
      {super.key, required this.name, required this.number});
  String name = '', number = '';
  @override
  State<EditReviewSessionExerView> createState() =>
      _EditReviewSessionExerViewState();
}

class _EditReviewSessionExerViewState extends State<EditReviewSessionExerView> {
  var dsh = Get.isRegistered<EditReviewSessionController>()
      ? Get.find<EditReviewSessionController>()
      : Get.put(EditReviewSessionController());
  @override
  Widget build(BuildContext context) => GetBuilder<EditReviewSessionController>(
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
                  getHeadingText: "Wk 1 OF 6 | MON",
                  getSubHeadText: "Session: 15:07",
                  isBackAllow: true,
                  isStyleChange: true,
                ),
              )),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: AppDimensions.twenty),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppDimensions.fifTeen),
                    ExerciseNameVideo(
                        exerName: widget.name, exerNumber: widget.number),
                    SizedBox(height: AppDimensions.twentyFive),
                    LastSessionClass(controller2: controller),
                  ]),
            ),
          ),
        ),
      );
}

class ExerciseNameVideo extends StatelessWidget {
  ExerciseNameVideo(
      {Key? key, required this.exerName, required this.exerNumber})
      : super(key: key);
  String exerName = '', exerNumber = '';
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
            Container(
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
        Container(
            height: AppDimensions.seventy,
            width: AppDimensions.hunDred,
            color: AppColors.gradientColor1,
            alignment: Alignment.center,
            child: SvgPicture.asset(AssetsBase.playVideoSvgIcon))
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
        SizedBox(height: AppDimensions.twentyFive),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: EdgeInsets.only(
                   right: AppDimensions.five),
              width: AppDimensions.hunDred,
              child: Text(
                AppStrings.notesText.toUpperCase(),
                textAlign: TextAlign.end,
                style: AppThemeStyle.robotoMedium13,
              ),
            ),
            SizedBox(
              width: AppDimensions.oneFifty,
              height: AppDimensions.forty,
              child: TextFormField(
                // controller: controller.nameController,
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
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.borderColorThree),
                    borderRadius: BorderRadius.zero,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.borderColorThree),
                    borderRadius: BorderRadius.zero,

                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.borderColorThree),
                    borderRadius: BorderRadius.zero,

                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.borderColorThree),
                    borderRadius: BorderRadius.zero,

                  ),

                  // errorText: controller.nameErrorText,
                  errorStyle: TextStyle(
                      color: AppColors.errorColor,
                      fontSize: AppDimensions.thirteen),
                ),
                onChanged: (String value) {},
              ),
            ),
            SvgPicture.asset(AssetsBase.micButtonSvgIcon)
          ],
        ),
        SizedBox(height: AppDimensions.fifTeen),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: AppDimensions.hunDred,
              margin: EdgeInsets.only(
                  right: AppDimensions.five, top: AppDimensions.twenty),
              child: Text("BAND/S",
                  textAlign: TextAlign.end,
                  style: AppThemeStyle.robotoMedium13),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "BAND 1",
                  style: AppThemeStyle.robotoMedium13,
                ),
                SizedBox(height: AppDimensions.ten),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: AppDimensions.ten),
                  height: AppDimensions.forty,
                  decoration: BoxDecoration(
                    color: Colors.white38,
                    border: Border.all(color: AppColors.borderColorThree),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      underline: Container(
                        height: 0.8,
                        color: const Color.fromRGBO(185, 191, 214, 1),
                      ),
                      style: TextStyle(
                          fontSize: AppDimensions.sixTeen, color: Colors.black),
                      icon: Visibility(
                          visible: true,
                          child: Icon(Icons.arrow_drop_down,
                              color: AppColors.borderColorThree,
                              size: AppDimensions.thirty)),
                      value: controller2.getValue.isNotEmpty
                          ? controller2.getValue
                          : controller2.bandName,
                      iconEnabledColor: const Color.fromRGBO(76, 73, 73, 0.6),
                      items: <String>[
                        'Select one',
                        'Band 1',
                        'Band 2',
                        'Band 3'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text("$value   "),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller2.getValue = value!;
                        controller2.update();
                      },
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: AppDimensions.fifty),
                  child: Text(
                    AppStrings.cancelText,
                    style: AppThemeStyle.robotoMedium13,
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(height: AppDimensions.eleven),
        GestureDetector(
          onTap: () {
            pushNewScreen(context,
                screen: const ProgressionList(), withNavBar: true);
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
                left: AppDimensions.sixty,
                bottom: AppDimensions.ten,
                top: AppDimensions.ten),
            child: Text(
              AppStrings.bandProgList,
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: AppColors.buttonColor,
                  fontSize: AppDimensions.sixTeen,
                  fontFamily: AppFonts.robotoFlex,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        SizedBox(height: AppDimensions.eleven),
        PostionAll(
            thisSessionName: controller2.thisSesstionList,
            exerController3: controller2),
        const NotesAndTotal()
      ],
    );
  }
}

class PostionAll extends StatelessWidget {
  PostionAll(
      {super.key,
      required this.thisSessionName,
      required this.exerController3});
  List<ThisSessionData> thisSessionName;
  EditReviewSessionController exerController3;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: thisSessionName.length,
      itemBuilder: (context, index) {
        return Container(
            margin: EdgeInsets.only(bottom: AppDimensions.seventeen),
            child: Row(
              children: [
                Container(
                  width: AppDimensions.onehunDredten,
                  margin: EdgeInsets.only(right: AppDimensions.twenty),
                  child: Text(thisSessionName[index].names.toString(),
                      textAlign: TextAlign.end,
                      style: AppThemeStyle.robotoMedium13),
                ),
                index == 0 || index == 1
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: AppDimensions.ten),
                        height: AppDimensions.forty,
                        decoration: BoxDecoration(
                          color: Colors.white38,
                          border: Border.all(color: AppColors.borderColorThree),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            underline: Container(
                              height: 0.8,
                              color: const Color.fromRGBO(185, 191, 214, 1),
                            ),
                            style: TextStyle(
                                fontSize: AppDimensions.sixTeen,
                                color: Colors.black),
                            icon: Visibility(
                                visible: true,
                                child: Icon(Icons.arrow_drop_down,
                                    color: AppColors.borderColorThree,
                                    size: AppDimensions.thirty)),
                            value: "Select one",
                            iconEnabledColor:
                                const Color.fromRGBO(76, 73, 73, 0.6),
                            items: <String>[
                              'Select one',
                              'Band 1',
                              'Band 2',
                              'Band 3'
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text("$value   "),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (index == 0) {
                                exerController3.getBandPosition = value!;
                              } else if (index == 1) {
                                exerController3.getMat = value!;
                              }
                              exerController3.update();
                            },
                          ),
                        ),
                      )
                    : Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: AppDimensions.ten),
                        height: AppDimensions.forty,
                        decoration: BoxDecoration(
                          color: Colors.white38,
                          border: Border.all(color: AppColors.borderColorThree),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            underline: Container(
                              height: 0.8,
                              color: const Color.fromRGBO(185, 191, 214, 1),
                            ),
                            style: TextStyle(
                                fontSize: AppDimensions.sixTeen,
                                color: Colors.black),
                            icon: Visibility(
                                visible: true,
                                child: Icon(Icons.arrow_drop_down,
                                    color: AppColors.borderColorThree,
                                    size: AppDimensions.thirty)),
                            value: "",
                            iconEnabledColor:
                                const Color.fromRGBO(76, 73, 73, 0.6),
                            items: <String>['', 'Band 1', 'Band 2', 'Band 3']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text("$value   "),
                              );
                            }).toList(),
                            onChanged: (value) {},
                          ),
                        ),
                      ),
              ],
            ));
      },
    );
  }
}

class NotesAndTotal extends StatelessWidget {
  const NotesAndTotal({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
                Row(
          children: [
            Container(
              width: AppDimensions.onehunDredten,
              margin: EdgeInsets.only(
                  right: AppDimensions.twenty, top: AppDimensions.twenty),
              child: Text("POWER \nINCREASE",
                  textAlign: TextAlign.end,
                  style: AppThemeStyle.robotoMedium13),
            ),
            Text("+3! :)",
                style: TextStyle(
                    fontSize: AppDimensions.twenty,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.robotoFlex,
                    color: AppColors.textButtonColor)),
            SizedBox(width: AppDimensions.fifty),
            Text("TOTAL", style: AppThemeStyle.robotoMedium13),
            SizedBox(width: AppDimensions.twenty),
            Text("50",
                style: TextStyle(
                    fontSize: AppDimensions.twenty,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.robotoFlex,
                    color: AppColors.textButtonColor)),
          ],
        ),
        SizedBox(height: AppDimensions.fifty),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TwoButtonClass(
                onTap: (p0) {
                  
                }, firstText: AppStrings.cancelText.toUpperCase(),isChangeBack: true),
            TwoButtonClass(
                onTap: (p0) {}, firstText: AppStrings.saveText.toUpperCase(),isChangeBack: false),
          ],
        ),
        SizedBox(height: AppDimensions.thirty),
      ],
    );
  }
}
