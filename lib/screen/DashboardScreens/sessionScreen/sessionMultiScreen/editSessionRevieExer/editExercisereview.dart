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
              margin: EdgeInsets.symmetric(horizontal: AppDimensions.ten),
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
        SizedBox(height: AppDimensions.thirty),

        PostionAll(
            thisSessionName: controller2.thisSesstionList,
            exerController1: controller2),
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
  EditReviewSessionController exerController1;

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
                               const  Text(
                              "===========",
                                textAlign: TextAlign.end,  
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "BAND 2",
                                textAlign: TextAlign.end,
                                style: AppThemeStyle.robotoMedium13,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : index == 2
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
                                        // exerController1.addBandList.add(
                                        //     LastSessionPrepData(
                                        //         names: "BAND",
                                        //         value:
                                        //             "${exerController1.count}"));
                                        // exerController1.update();
                                        // print(exerController1.count);
                                      },
                                      child: SvgPicture.asset(
                                          AssetsBase.addButtonSvgIcon)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
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
                                      decoration: TextDecoration.underline,
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
                        : index == 0
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
                                            width: AppDimensions.oneThirty,
                                              height: AppDimensions.forty,
                                              child: TextFormField(
                                                style: TextStyle(
                                                  fontSize:
                                                      AppDimensions.forteen,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textInputAction:
                                                    TextInputAction.done,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          top: AppDimensions
                                                              .ten,
                                                          right: AppDimensions
                                                              .five,
                                                          left: AppDimensions
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
                                                          BorderRadius.zero),

                                                  // errorText: controller.nameErrorText,
                                                  errorStyle: TextStyle(
                                                      color: AppColors
                                                          .errorColor,
                                                      fontSize: AppDimensions
                                                          .thirteen),
                                                ),
                                                onChanged: (String value) {},
                                              )),
                                  SizedBox(width: AppDimensions.fifTeen),

                                          GestureDetector(
                                              onTap: () {},
                                              child: SvgPicture.asset(
                                                  AssetsBase.micButtonSvgIcon)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : index == 7
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        top: AppDimensions.twenty,
                                        right: AppDimensions.thirty),
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
                                              Text("+3!  🙂",
                                                  style: TextStyle(
                                                      fontSize:
                                                          AppDimensions.twenty,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          AppFonts.robotoFlex,
                                                      color: AppColors
                                                          .textButtonColor)),
                                              Text("TOTAL",
                                                  style: AppThemeStyle
                                                      .robotoMedium13),
                                              Text("50",
                                                  style: TextStyle(
                                                      fontSize:
                                                          AppDimensions.twenty,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          AppFonts.robotoFlex,
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
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        AppDimensions.five),
                                                height: AppDimensions.forty,
                                                decoration: BoxDecoration(
                                                  color: Colors.white38,
                                                  border: Border.all(
                                                      color: AppColors
                                                          .borderColorThree),
                                                ),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton<String>(
                                                    underline: Container(
                                                      height: 0.8,
                                                      color:
                                                          const Color.fromRGBO(
                                                              185, 191, 214, 1),
                                                    ),
                                                    style: TextStyle(
                                                        fontSize: AppDimensions
                                                            .sixTeen,
                                                        color: Colors.black),
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
                                                            .getValue.isNotEmpty
                                                        ? exerController1
                                                            .getValue
                                                        : index == 3
                                                            ? exerController1
                                                                .bandName
                                                            : "",
                                                    iconEnabledColor:
                                                        const Color.fromRGBO(
                                                            76, 73, 73, 0.6),
                                                    items: <String>[
                                                      index == 3
                                                          ? 'Select one'
                                                          : "",
                                                      'Band 1',
                                                      'Band 2',
                                                      'Band 3'
                                                    ].map((String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child:
                                                            Text("$value   "),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      exerController1.getValue =
                                                          value!;
                                                      exerController1.update();
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
        Container(
margin: EdgeInsets.symmetric(horizontal: AppDimensions.twenty),          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TwoButtonClass(
                  onTap: (p0) {},
                  firstText: AppStrings.cancelText.toUpperCase(),
                  isChangeBack: true),
              TwoButtonClass(
                  onTap: (p0) {},
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
