// ignore_for_file: file_names, must_be_immutable

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_fonts.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/appstyle/assetbase.dart';
import 'package:bandapp/model/bandsModel.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/sessionMultiScreen/InEndSession/End_controller.dart';
import 'package:bandapp/widgets/buttonBackground.dart';
import 'package:bandapp/widgets/customBackButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class EndSessionOverview extends StatefulWidget {
  const EndSessionOverview({
    super.key,
  });

  @override
  State<EndSessionOverview> createState() => _EndSessionOverviewState();
}

class _EndSessionOverviewState extends State<EndSessionOverview> {
  @override
  Widget build(BuildContext context) => GetBuilder<EndSessionController>(
        init: EndSessionController(),
        builder: (controller) => Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                  AppDimensions.seventy), // here the desired height
              child: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                elevation: AppDimensions.zero,
                title: CustomWithoutTraining(
                  navigateBack: () {
                    Navigator.pop(context);
                    Get.delete<EndSessionController>();
                  },
                  // getHeadingText: "Wk 1 OF 6 | MON",
                  // getSubHeadText: "Session: 15:07",
                  // isBackAllow: true,
                  // isStyleChange: true,
                ),
              )),
          body: controller.endSessionData.isNotEmpty
              ? SingleChildScrollView(
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: AppDimensions.twenty),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: AppDimensions.fifTeen),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.endSessionData.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(
                                    bottom: AppDimensions.fifTeen),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: AppDimensions.oneThirty,
                                      margin: EdgeInsets.only(
                                          right: AppDimensions.fifTeen,
                                          left: AppDimensions.fifTeen),
                                      child: Text(
                                        controller.endSessionData[index].names!
                                            .toString()
                                            .toUpperCase(),
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: AppDimensions.thirteen,
                                            fontFamily: AppFonts.robotoFlex,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1.0,
                                            color: AppColors.thirdTextColor),
                                      ),
                                    ),
                                    Text(
                                      controller.endSessionData[index].value
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: AppDimensions.sixTeen,
                                        fontFamily: AppFonts.robotoMedium,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.0,
                                        color: AppColors.textButtonColor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: AppDimensions.oneThirty,
                                margin: EdgeInsets.only(
                                    right: AppDimensions.five,
                                    top: AppDimensions.zero),
                                child: Text("NOTES",
                                    textAlign: TextAlign.end,
                                    style: AppThemeStyle.robotoMedium13),
                              ),
                              SizedBox(
                                width: AppDimensions.onetwenty,
                                height: AppDimensions.forty,
                                child: TextFormField(
                                  controller: controller.notesController,
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
                                        borderSide: BorderSide(
                                            color: AppColors.borderColorThree),
                                        borderRadius: BorderRadius.zero),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.borderColorThree),
                                        borderRadius: BorderRadius.zero),
                                    focusedErrorBorder:
                                        const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    AppColors.borderColorThree),
                                            borderRadius: BorderRadius.zero),
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.borderColorThree),
                                        borderRadius: BorderRadius.zero),

                                    // errorText: controller.nameErrorText,
                                    errorStyle: TextStyle(
                                        color: AppColors.errorColor,
                                        fontSize: AppDimensions.thirteen),
                                  ),
                                  onChanged: (String value) {
                                    controller.storeNotes = value;
                                    controller.update();
                                  },
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    if (controller.speech.isListening) {
                                      controller.stopListening();
                                    } else {
                                      controller.startListening();
                                    }
                                  },
                                  child: controller.speech.isListening
                                      ? const CircleAvatar(
                                          backgroundColor:
                                              AppColors.greenTextColor,
                                          child: Icon(Icons.mic_off,
                                              color: Colors.white))
                                      : SvgPicture.asset(
                                          AssetsBase.micButtonSvgIcon))
                            ],
                          ),
                          SizedBox(height: AppDimensions.twentyFive),
                          VideoGridView(
                            getExerciseGrid: controller.exerciseVideo,
                            controller2: controller,
                          )
                        ]),
                  ),
                )
              : Container(),
        ),
      );
}

// video grid
class VideoGridView extends StatelessWidget {
  VideoGridView(
      {Key? key, required this.getExerciseGrid, required this.controller2})
      : super(key: key);
  final List<ExerciseVideoList> getExerciseGrid;
  EndSessionController controller2;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller2.getSessionInfoDataApi.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: AppDimensions.oneseventy,
                crossAxisSpacing: AppDimensions.twenty,
                mainAxisSpacing: AppDimensions.thirty),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  // pushNewScreen(context,
                  //     screen: ReviewExerView(
                  //       name: getExerciseGrid[index].exerciseName.toString(),
                  //       number: getExerciseGrid[index].value.toString(),

                  //     ),
                  //     withNavBar: true);
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      AppDimensions.five,
                      AppDimensions.five,
                      AppDimensions.five,
                      AppDimensions.ten),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryTextColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppDimensions.twenty),
                        topRight: Radius.circular(AppDimensions.five),
                        bottomLeft: Radius.circular(AppDimensions.five),
                        bottomRight: Radius.circular(AppDimensions.twenty)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: AppDimensions.thirtyfive,
                            width: AppDimensions.thirtyfive,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(AppDimensions.fifty)),
                            child: Text(
                              getExerciseGrid[index].value.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: AppDimensions.sixTeen,
                                  fontFamily: AppFonts.robotoMedium),
                            ),
                          ),
                          SizedBox(
                            width: AppDimensions.eightyPx,
                            child: controller2.getSessionInfoDataApi[index]
                                        .isUserExcercise ==
                                    false
                                ? Container()
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: controller2
                                        .getSessionInfoDataApi[index]
                                        .responseDataSession!
                                        .length,
                                    itemBuilder: (context, index1) {
                                      return Container(
                                        margin: EdgeInsets.only(
                                            bottom: AppDimensions.two),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                controller2
                                                    .getSessionInfoDataApi[
                                                        index]
                                                    .responseDataSession![
                                                        index1]
                                                    .name
                                                    .toString(),
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    // backgroundColor:
                                                    //     AppColors.buttonColor,
                                                    fontSize:
                                                        AppDimensions.twelve,
                                                    fontFamily:
                                                        AppFonts.robotoFlex,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            index1 == 0
                                                ? SizedBox(
                                                    width: AppDimensions.five)
                                                : Container(),
                                            index1 == 0
                                                ? Container(
                                                    alignment: Alignment.center,
                                                    height:
                                                        AppDimensions.thirteen,
                                                    width: AppDimensions
                                                        .twentyFive,
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .buttonColor,
                                                        border: Border.all(
                                                            color: AppColors
                                                                .buttonColor,
                                                            width: AppDimensions
                                                                .one)),
                                                    child: Text(
                                                      controller2
                                                          .getSessionInfoDataApi[
                                                              index]
                                                          .responseDataSession![
                                                              index1]
                                                          .value
                                                          .toString()
                                                          .substring(0, 2)
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize:
                                                              AppDimensions
                                                                  .nine,
                                                          fontFamily: AppFonts
                                                              .robotoFlex,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                : Container(
                                                    padding: EdgeInsets.only(
                                                        right:
                                                            AppDimensions.two,
                                                        top: AppDimensions.one,
                                                        bottom:
                                                            AppDimensions.one),
                                                    margin: EdgeInsets.only(
                                                        left:
                                                            AppDimensions.five),
                                                    width: AppDimensions.thirty,
                                                    // color:
                                                    //     AppColors.buttonColor,
                                                    child: Text(
                                                      controller2
                                                          .getSessionInfoDataApi[
                                                              index]
                                                          .responseDataSession![
                                                              index1]
                                                          .value
                                                          .toString(),
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontSize:
                                                              AppDimensions.ten,
                                                          fontFamily: AppFonts
                                                              .robotoFlex,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      );
                                    }),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        padding: EdgeInsets.only(
                            left: AppDimensions.three,
                            right: AppDimensions.three,
                            bottom: AppDimensions.two),
                        child: Text(
                          controller2.getSessionInfoDataApi[index].name ?? "",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 0.1,
                              // backgroundColor: AppColors.buttonColor,
                              fontWeight: FontWeight.w600,
                              fontSize: AppDimensions.forteen,
                              fontFamily: AppFonts.robotoFlex),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
        SizedBox(height: AppDimensions.thirty),
        CenterButtonArrowClass(
            onTap: (p0) {
              controller2.endSessionApi(context);
            },
            buttonText: AppStrings.saveText.toUpperCase()),
        SizedBox(height: AppDimensions.fifty),
      ],
    );
  }
}
