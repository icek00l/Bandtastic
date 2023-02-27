// ignore_for_file: file_names

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_fonts.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/appstyle/assetbase.dart';
import 'package:bandapp/model/bandsModel.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/sessionMultiScreen/InEndSession/End_controller.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/sessionMultiScreen/exerciseSessionReview/exerciseReview_view.dart';
import 'package:bandapp/widgets/customBackButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class EndSessionOverview extends StatefulWidget {
  const EndSessionOverview({
    super.key,
  });

  @override
  State<EndSessionOverview> createState() => _EndSessionOverviewState();
}

class _EndSessionOverviewState extends State<EndSessionOverview> {
  var dsh = Get.isRegistered<EndSessionController>()
      ? Get.find<EndSessionController>()
      : Get.put(EndSessionController());
  @override
  Widget build(BuildContext context) => GetBuilder<EndSessionController>(
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
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.endSessionData.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin:
                              EdgeInsets.only(bottom: AppDimensions.fifTeen),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: AppDimensions.oneThirty,
                                margin: EdgeInsets.only(
                                    right: AppDimensions.fifTeen,left: AppDimensions.fifTeen),
                                child: Text(
                                  controller.endSessionData[index].names
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
                                    color: AppColors.textButtonColor),
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
              margin: EdgeInsets.only(right: AppDimensions.five, top: AppDimensions.zero),
              child: Text("NOTES",
                  textAlign: TextAlign.end,
                  style: AppThemeStyle.robotoMedium13),
            ),
            SizedBox(
              width: AppDimensions.onetwenty,
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
                    borderRadius: BorderRadius.zero

                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.borderColorThree),
                    borderRadius: BorderRadius.zero

                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.borderColorThree),
                    borderRadius: BorderRadius.zero

                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.borderColorThree),
                    borderRadius: BorderRadius.zero
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
                    SizedBox(height: AppDimensions.twentyFive),
                    VideoGridView(
                        getExerciseGrid: controller.exerciseVideo,
                        getExtraData: controller.extraData)
                  ]),
            ),
          ),
        ),
      );
}

// video grid
class VideoGridView extends StatelessWidget {
  const VideoGridView({
    Key? key,
    required this.getExerciseGrid,
    required this.getExtraData,
  }) : super(key: key);
  final List<ExerciseVideoList> getExerciseGrid;
  final List<ExtraDataList> getExtraData;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: getExerciseGrid.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: AppDimensions.oneSixty,
                crossAxisSpacing: AppDimensions.thirty,
                mainAxisSpacing: AppDimensions.thirtyfive),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  pushNewScreen(context,
                      screen: ReviewExerView(
                        name: getExerciseGrid[index].exerciseName.toString(),
                        number: getExerciseGrid[index].value.toString(),
                      ),
                      withNavBar: true);
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      AppDimensions.five,
                      AppDimensions.five,
                      AppDimensions.five,
                      AppDimensions.ten),
                  decoration: BoxDecoration(
                    color: getExtraData.isNotEmpty
                        ? AppColors.backgColorOne
                        : AppColors.secondaryTextColor,
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
                                color: AppColors.buttonColor,
                                borderRadius:
                                    BorderRadius.circular(AppDimensions.fifty)),
                            child: Text(
                              getExerciseGrid[index].value.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: getExtraData.isNotEmpty
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: AppDimensions.sixTeen,
                                  fontFamily: AppFonts.robotoMedium),
                            ),
                          ),
                          SizedBox(
                            width: AppDimensions.eightyPx,
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: getExtraData.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        bottom: AppDimensions.five),
                                    child: Row(
                                      children: [
                                        Container(
                                            color: AppColors.buttonColor,
                                            width: AppDimensions.fiftyFive,
                                            child: Text(
                                              getExtraData[index]
                                                  .name
                                                  .toString(),
                                              textAlign: TextAlign.end,
                                              style: AppThemeStyle
                                                  .robotoflex12bold,
                                            )),
                                        index == 0
                                            ? SizedBox(
                                                width: AppDimensions.five)
                                            : Container(),
                                        index == 0
                                            ? Container(
                                                alignment: Alignment.center,
                                                height: AppDimensions.thirteen,
                                                width: AppDimensions.twenty,
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppColors.buttonColor,
                                                    border: Border.all(
                                                        color: AppColors
                                                            .buttonColor,
                                                        width:
                                                            AppDimensions.one)),
                                                child: Text(
                                                  getExtraData[index]
                                                      .value
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize:
                                                          AppDimensions.nine,
                                                      fontFamily:
                                                          AppFonts.robotoFlex,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white),
                                                ),
                                              )
                                            : Container(
                                                padding: EdgeInsets.only(
                                                    right: AppDimensions.two),
                                                margin: EdgeInsets.only(
                                                    left: AppDimensions.five),
                                                color: AppColors.buttonColor,
                                                width: AppDimensions.twenty,
                                                child: Text(
                                                  getExtraData[index]
                                                      .value
                                                      .toString(),
                                                  textAlign: TextAlign.end,
                                                  style: AppThemeStyle
                                                      .robotoflex12bold,
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
                        color: AppColors.buttonColor,
                        margin: EdgeInsets.only(
                            right: AppDimensions.ten, left: AppDimensions.ten),
                        alignment: Alignment.bottomRight,
                        child: Text(
                          getExerciseGrid[index].exerciseName.toString(),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 0.1,
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
        SizedBox(height: AppDimensions.fifty)
      ],
    );
  }
}
