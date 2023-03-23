// ignore_for_file: file_names, must_be_immutable, avoid_print

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_fonts.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/appstyle/assetbase.dart';
import 'package:bandapp/model/bandsModel.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/sessionMultiScreen/sessionTabbarScreen/exerciseLog_controller.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/sessionMultiScreen/sessionTabbarScreen/progress_view.dart';
import 'package:bandapp/widgets/buttonBackground.dart';
import 'package:bandapp/widgets/customBackButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ExerciseLogBandView extends StatefulWidget {
  String? getExerName = '', getNumber = '';
  ExerciseLogBandView({
    super.key,
    this.getExerName,
    this.getNumber,
  });

  @override
  State<ExerciseLogBandView> createState() => _ExerciseLogBandViewState();
}

class _ExerciseLogBandViewState extends State<ExerciseLogBandView> {
  var dsh = Get.isRegistered<ExerciseLogController>()
      ? Get.find<ExerciseLogController>()
      : Get.put(ExerciseLogController());
  @override
  Widget build(BuildContext context) => GetBuilder<ExerciseLogController>(
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
                  getHeadingText: "Wednesday Session",
                  isBackAllow: true,
                ),
              )),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: AppDimensions.ten),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppDimensions.fifTeen),
                    ExerciseNameVideo(
                        name: widget.getExerName.toString(),
                        number: widget.getNumber.toString()),
                    SizedBox(height: AppDimensions.thirtyfive),
                    LastSessionClass(
                        prepData: controller.selectSet == "Magic Set"
                            ? controller.magicDataList
                            : controller.prepDataList,
                        getControl: controller),
                    SizedBox(height: AppDimensions.seventy),
                    ThisSessionClass(
                      exerController: controller,
                    )
                  ]),
            ),
          ),
        ),
      );
}

class ExerciseNameVideo extends StatelessWidget {
  ExerciseNameVideo({Key? key, required this.name, required this.number})
      : super(key: key);
  String name, number;
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
  LastSessionClass({Key? key, required this.prepData, required this.getControl})
      : super(key: key);
  final List<LastSessionPrepData> prepData;
  ExerciseLogController getControl;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
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
        SizedBox(height: AppDimensions.thirty),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                getControl.selectSet = '';
                getControl.chooseSelectSet("Prep Set");
              },
              child: Column(
                children: [
                  Container(
                    height: getControl.selectSet == "Magic Set"
                        ? AppDimensions.thirty6
                        : AppDimensions.thirty,
                    width: AppDimensions.oneThirty,
                    margin: EdgeInsets.only(right: AppDimensions.ten),
                    alignment: Alignment.center,
                    decoration: getControl.selectSet == "Magic Set"
                        ? BoxDecoration(
                            color: AppColors.gradientColor1,
                            borderRadius:
                                BorderRadius.circular(AppDimensions.four))
                        : BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: AppColors.buttonColor,
                            ),
                            borderRadius:
                                BorderRadius.circular(AppDimensions.zero)),
                    child: Text(
                      AppStrings.prepSet.toUpperCase(),
                      style: getControl.selectSet == "Magic Set"
                          ? AppThemeStyle.robotoflex13Medium
                          : AppThemeStyle.robotoflexbold,
                    ),
                  ),
                  getControl.selectSet == "Magic Set"
                      ? Container()
                      : Container(
                          height: AppDimensions.six,
                          decoration: BoxDecoration(
                              color: AppColors.buttonColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(AppDimensions.six),
                                  bottomRight:
                                      Radius.circular(AppDimensions.six))),
                          width: AppDimensions.oneThirty,
                          margin: EdgeInsets.only(right: AppDimensions.ten),
                        )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                print("sdff");
                getControl.selectSet = '';

                getControl.chooseSelectSet("Magic Set");
              },
              child: Column(
                children: [
                  Container(
                    height: getControl.selectSet == "Prep Set"
                        ? AppDimensions.thirty6
                        : AppDimensions.thirty,
                    width: AppDimensions.oneThirty,
                    alignment: Alignment.center,
                    decoration: getControl.selectSet == "Prep Set"
                        ? BoxDecoration(
                            color: AppColors.gradientColor1,
                            borderRadius:
                                BorderRadius.circular(AppDimensions.four))
                        : BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: AppColors.buttonColor,
                            ),
                            borderRadius:
                                BorderRadius.circular(AppDimensions.zero)),
                    child: Text(
                      AppStrings.magicSet.toUpperCase(),
                      style: getControl.selectSet == "Prep Set"
                          ? AppThemeStyle.robotoflex13Medium
                          : AppThemeStyle.robotoflexbold,
                    ),
                  ),
                  getControl.selectSet == "Prep Set"
                      ? Container()
                      : Container(
                          height: AppDimensions.six,
                          decoration: BoxDecoration(
                              color: AppColors.buttonColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(AppDimensions.six),
                                  bottomRight:
                                      Radius.circular(AppDimensions.six))),
                          width: AppDimensions.oneThirty,
                        )
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: AppDimensions.twentyFive),
        ListView.builder(
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
                        : EdgeInsets.symmetric(vertical: AppDimensions.two),
                    decoration: BoxDecoration(
                        color: index == 1
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
                          color: index == 1
                              ? Colors.white
                              : AppColors.textButtonColor),
                    ),
                  )
                ],
              ),
            );
          },
        ),
        SizedBox(height: AppDimensions.forty),
        Text(
          AppStrings.letsmashText,
          style: TextStyle(
              fontSize: AppDimensions.twentyFour,
              fontFamily: AppFonts.plusSansMedium,
              fontWeight: FontWeight.w600,
              color: AppColors.secondaryTextColor),
        ),
      ],
    );
  }
}

class ThisSessionClass extends StatelessWidget {
  ThisSessionClass({Key? key, required this.exerController}) : super(key: key);
  ExerciseLogController exerController;
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                exerController.thisSelectSet = '';
                exerController.thisChooseSelectSet("Prep Set");
              },
              child: Column(
                children: [
                  Container(
                    height: exerController.thisSelectSet == "Magic Set"
                        ? AppDimensions.thirty6
                        : AppDimensions.thirty,
                    width: AppDimensions.oneThirty,
                    margin: EdgeInsets.only(right: AppDimensions.ten),
                    alignment: Alignment.center,
                    decoration: exerController.thisSelectSet == "Magic Set"
                        ? BoxDecoration(
                            color: AppColors.gradientColor1,
                            borderRadius:
                                BorderRadius.circular(AppDimensions.four))
                        : BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: AppColors.buttonColor,
                            ),
                            borderRadius:
                                BorderRadius.circular(AppDimensions.zero)),
                    child: Text(
                      AppStrings.prepSet.toUpperCase(),
                      style: exerController.thisSelectSet == "Magic Set"
                          ? AppThemeStyle.robotoflex13Medium
                          : AppThemeStyle.robotoflexbold,
                    ),
                  ),
                  exerController.thisSelectSet == "Magic Set"
                      ? Container()
                      : Container(
                          height: AppDimensions.six,
                          decoration: BoxDecoration(
                              color: AppColors.buttonColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(AppDimensions.six),
                                  bottomRight:
                                      Radius.circular(AppDimensions.six))),
                          width: AppDimensions.oneThirty,
                          margin: EdgeInsets.only(right: AppDimensions.ten),
                        )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                print("sdff");
                exerController.thisSelectSet = '';

                exerController.thisChooseSelectSet("Magic Set");
              },
              child: Column(
                children: [
                  Container(
                    height: exerController.thisSelectSet == "Prep Set"
                        ? AppDimensions.thirty6
                        : AppDimensions.thirty,
                    width: AppDimensions.oneThirty,
                    alignment: Alignment.center,
                    decoration: exerController.thisSelectSet == "Prep Set"
                        ? BoxDecoration(
                            color: AppColors.gradientColor1,
                            borderRadius:
                                BorderRadius.circular(AppDimensions.four))
                        : BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: AppColors.buttonColor,
                            ),
                            borderRadius:
                                BorderRadius.circular(AppDimensions.zero)),
                    child: Text(
                      AppStrings.magicSet.toUpperCase(),
                      style: exerController.thisSelectSet == "Prep Set"
                          ? AppThemeStyle.robotoflex13Medium
                          : AppThemeStyle.robotoflexbold,
                    ),
                  ),
                  exerController.thisSelectSet == "Prep Set"
                      ? Container()
                      : Container(
                          height: AppDimensions.six,
                          decoration: BoxDecoration(
                              color: AppColors.buttonColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(AppDimensions.six),
                                  bottomRight:
                                      Radius.circular(AppDimensions.six))),
                          width: AppDimensions.oneThirty,
                        )
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: AppDimensions.twentyFive),
        SizedBox(height: AppDimensions.eleven),
        PostionAll(
            thisSessionName: exerController.thisSesstionList,
            exerController1: exerController),
        SizedBox(height: AppDimensions.eleven),
        const NotesAndTotal()
      ],
    );
  }
}

class PostionAll extends StatelessWidget {
  PostionAll(
      {super.key,
      required this.thisSessionName,
      required this.exerController1});
  List<ThisSessionData> thisSessionName;
  ExerciseLogController exerController1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: thisSessionName.length,
      itemBuilder: (context, index) {
        return Container(
            margin: EdgeInsets.only(
                bottom:
                    index == 2 ? AppDimensions.zero : AppDimensions.seventeen),
            child: index == 0
                ? Padding(
                    padding: EdgeInsets.only(right: AppDimensions.twenty),
                    child: Row(
                      children: [
                        Expanded(child: Container()),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "BAND 1",
                                textAlign: TextAlign.end,
                                style: AppThemeStyle.robotoMedium13,
                              ),
                              

                              Text(
                                exerController1.count == 1
                                    ? "==========="
                                    : "===========",
                                textAlign: TextAlign.end,
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                exerController1.count == 1
                                    ? "BAND 2"
                                    : "CANCEL",
                                textAlign: TextAlign.end,
                                style: AppThemeStyle.robotoMedium13,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : index == 1
                    ? Padding(
                        padding: EdgeInsets.only(right: AppDimensions.twenty),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: AppDimensions.thirty),
                                child: Text("BAND/S",
                                    textAlign: TextAlign.end,
                                    style: AppThemeStyle.robotoMedium13),
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
                                    decoration: BoxDecoration(
                                      color: Colors.white38,
                                      border: Border.all(
                                          color: AppColors.borderColorThree),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        underline: Container(
                                          height: 0.8,
                                          color: const Color.fromRGBO(
                                              185, 191, 214, 1),
                                        ),
                                        style: TextStyle(
                                            fontSize: AppDimensions.sixTeen,
                                            color: Colors.black),
                                        icon: Visibility(
                                            visible: true,
                                            child: Icon(Icons.arrow_drop_down,
                                                color:
                                                    AppColors.borderColorThree,
                                                size: AppDimensions.thirty)),
                                        value:
                                            exerController1.getValue.isNotEmpty
                                                ? exerController1.getValue
                                                : exerController1.bandName,
                                        iconEnabledColor: const Color.fromRGBO(
                                            76, 73, 73, 0.6),
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
                                          exerController1.getValue = value!;
                                          exerController1.update();
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: AppDimensions.fifTeen),
                                  GestureDetector(
                                      onTap: () {
                                        if (exerController1.count == 1) {
                                          exerController1.count++;

                                          exerController1.addBandList.add(
                                              LastSessionPrepData(
                                                  names: "BAND",
                                                  value:
                                                      "${exerController1.count}"));
                                          print(
                                              "${exerController1.addBandList.length}");
                                          print(exerController1.count);
                                        } else {
                                          if (exerController1.count != 1) {
                                            exerController1.count = 1;
                                          }
                                          exerController1.addBandList.clear();
                                          print(exerController1.count);
                                        }
                                        exerController1.update();
                                      },
                                      child: SvgPicture.asset(
                                          exerController1.count == 1
                                              ? AssetsBase.addButtonSvgIcon
                                              : AssetsBase.removeSvgIcon)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : index == 2
                        ? exerController1.addBandList.isNotEmpty
                            ? ListView.builder(
                                itemCount: exerController1.addBandList.length,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        right: AppDimensions.twenty,
                                        bottom: AppDimensions.fifTeen),
                                    child: Row(
                                      children: [
                                        Expanded(child: Container()),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "BAND ${exerController1.addBandList[index].value}",
                                                    textAlign: TextAlign.end,
                                                    style: AppThemeStyle
                                                        .robotoMedium13,
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          AppDimensions.ten),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                AppDimensions
                                                                    .five),
                                                    height: AppDimensions.forty,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white38,
                                                      border: Border.all(
                                                          color: AppColors
                                                              .borderColorThree),
                                                    ),
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child: DropdownButton<
                                                          String>(
                                                        underline: Container(
                                                          height: 0.8,
                                                          color: const Color
                                                                  .fromRGBO(
                                                              185, 191, 214, 1),
                                                        ),
                                                        style: TextStyle(
                                                            fontSize:
                                                                AppDimensions
                                                                    .sixTeen,
                                                            color:
                                                                Colors.black),
                                                        icon: Visibility(
                                                            visible: true,
                                                            child: Icon(
                                                                Icons
                                                                    .arrow_drop_down,
                                                                color: AppColors
                                                                    .borderColorThree,
                                                                size: AppDimensions
                                                                    .thirty)),
                                                        value: exerController1
                                                                .getValue
                                                                .isNotEmpty
                                                            ? exerController1
                                                                .getValue
                                                            : exerController1
                                                                .bandName,
                                                        iconEnabledColor:
                                                            const Color
                                                                    .fromRGBO(
                                                                76,
                                                                73,
                                                                73,
                                                                0.6),
                                                        items: <String>[
                                                          'Select one',
                                                          'Band 1',
                                                          'Band 2',
                                                          'Band 3'
                                                        ].map((String value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(
                                                                "$value   "),
                                                          );
                                                        }).toList(),
                                                        onChanged: (value) {
                                                          exerController1
                                                                  .getValue =
                                                              value!;
                                                          exerController1
                                                              .update();
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                  width: AppDimensions.eighteen),
                                              GestureDetector(
                                                  onTap: () {},
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "BAND 3",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: AppThemeStyle
                                                            .robotoMedium13,
                                                      ),
                                                      SizedBox(
                                                          height: AppDimensions
                                                              .ten),
                                                      SvgPicture.asset(AssetsBase
                                                          .addButtonSvgIcon),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : Container()
                        : index == 3
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
                                            decoration:
                                                TextDecoration.underline,
                                            color: AppColors.buttonColor,
                                            fontSize: AppDimensions.sixTeen,
                                            fontFamily: AppFonts.robotoFlex,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: AppDimensions.twenty)
                                ],
                              )
                            : index == 7
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        right: AppDimensions.twenty),
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: AppDimensions.oneThirty,
                                                  height: AppDimensions.forty,
                                                  child: TextFormField(
                                                    style: TextStyle(
                                                      fontSize: AppDimensions
                                                          .forteen,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    textInputAction:
                                                        TextInputAction.done,
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
                                                    onChanged:
                                                        (String value) {},
                                                  )),
                                              SizedBox(
                                                  width: AppDimensions.fifTeen),
                                              GestureDetector(
                                                  onTap: () {},
                                                  child: SvgPicture.asset(
                                                      AssetsBase
                                                          .micButtonSvgIcon)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : index == 8
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            top: AppDimensions.twenty,
                                            right: AppDimensions.thirty),
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
                                                  Text("+3!  🙂",
                                                      style: TextStyle(
                                                          fontSize:
                                                              AppDimensions
                                                                  .twenty,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: AppFonts
                                                              .robotoFlex,
                                                          color: AppColors
                                                              .textButtonColor)),
                                                  Text("TOTAL",
                                                      style: AppThemeStyle
                                                          .robotoMedium13),
                                                  Text("50",
                                                      style: TextStyle(
                                                          fontSize:
                                                              AppDimensions
                                                                  .twenty,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: AppFonts
                                                              .robotoFlex,
                                                          color: AppColors
                                                              .textButtonColor)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            right: AppDimensions.twenty),
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
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                AppDimensions
                                                                    .five),
                                                    height: AppDimensions.forty,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white38,
                                                      border: Border.all(
                                                          color: AppColors
                                                              .borderColorThree),
                                                    ),
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child: DropdownButton<
                                                          String>(
                                                        underline: Container(
                                                          height: 0.8,
                                                          color: const Color
                                                                  .fromRGBO(
                                                              185, 191, 214, 1),
                                                        ),
                                                        style: TextStyle(
                                                            fontSize:
                                                                AppDimensions
                                                                    .sixTeen,
                                                            color:
                                                                Colors.black),
                                                        icon: Visibility(
                                                            visible: true,
                                                            child: Icon(
                                                                Icons
                                                                    .arrow_drop_down,
                                                                color: AppColors
                                                                    .borderColorThree,
                                                                size: AppDimensions
                                                                    .thirty)),
                                                        value: exerController1
                                                                .getValue
                                                                .isNotEmpty
                                                            ? exerController1
                                                                .getValue
                                                            : index == 4
                                                                ? exerController1
                                                                    .bandName
                                                                : "",
                                                        iconEnabledColor:
                                                            const Color
                                                                    .fromRGBO(
                                                                76,
                                                                73,
                                                                73,
                                                                0.6),
                                                        items: <String>[
                                                          index == 4
                                                              ? 'Select one'
                                                              : "",
                                                          'Band 1',
                                                          'Band 2',
                                                          'Band 3'
                                                        ].map((String value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(
                                                                "$value   "),
                                                          );
                                                        }).toList(),
                                                        onChanged: (value) {
                                                          exerController1
                                                                  .getValue =
                                                              value!;
                                                          exerController1
                                                              .update();
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width: AppDimensions.ten),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
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
        SizedBox(height: AppDimensions.fifty),
        CenterButtonArrowClass(onTap: (p0) {}, buttonText: AppStrings.nextUP),
        SizedBox(height: AppDimensions.thirty),
      ],
    );
  }
}
