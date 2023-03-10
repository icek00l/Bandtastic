// ignore_for_file: must_be_immutable, file_names

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_fonts.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/appstyle/assetbase.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/sessionMultiScreen/editSessionRevieExer/editExercisereview.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/sessionMultiScreen/exerciseSessionReview/exerciseReview_controller.dart';
import 'package:bandapp/widgets/buttonBackground.dart';
import 'package:bandapp/widgets/customBackButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ReviewExerView extends StatefulWidget {
   ReviewExerView({
    super.key,required this.name,required this.number
  });
String name = '', number = '';
  @override
  State<ReviewExerView> createState() => _ReviewExerViewState();
}

class _ReviewExerViewState extends State<ReviewExerView> {
  var dsh = Get.isRegistered<ReviewExerController>()
      ? Get.find<ReviewExerController>()
      : Get.put(ReviewExerController());
  @override
  Widget build(BuildContext context) => GetBuilder<ReviewExerController>(
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
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: AppDimensions.twenty),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: AppDimensions.fifTeen),
               ExerciseNameVideo(getName: widget.name,getNumber: widget.number),
              SizedBox(height: AppDimensions.twentyFive),
              LastSessionClass(controller2: controller),
              ButtonCommonArrowClass(
                  isMargin: false,
                  onTap: (p0) {
                      pushNewScreen(context,
                      screen:  EditReviewSessionExerView(name: widget.name,number: widget.number,
                     
                      ),
                      withNavBar: true);
                  },
                  buttonText: AppStrings.editLogText.toUpperCase()),
              SizedBox(height: AppDimensions.thirty),
            ]),
          ),
        ),
      );
}

class ExerciseNameVideo extends StatelessWidget {
 ExerciseNameVideo({
    Key? key, required this.getName, required this.getNumber
  }) : super(key: key);
String getName = '', getNumber ='';
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(getNumber,
                style: TextStyle(
                    fontSize: AppDimensions.thirty2,
                    fontFamily: AppFonts.robotoBold,
                    fontWeight: FontWeight.bold,
                    color: AppColors.buttonColor)),
            SizedBox(width: AppDimensions.ten),
            Container(
              width: AppDimensions.oneSixty,
              child: Text(getName,
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
  ReviewExerController controller2;
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
              width: AppDimensions.onetwenty,
              margin: EdgeInsets.only(right: AppDimensions.five),
              child: Text(
                AppStrings.notesText.toUpperCase(),
                textAlign: TextAlign.end,
                style: AppThemeStyle.robotoMedium13,
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: AppDimensions.five),
              width: AppDimensions.oneThirty,
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
                    borderRadius: BorderRadius.zero,

                    borderSide: BorderSide(color: AppColors.borderColorThree),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.zero,

                    borderSide: BorderSide(color: AppColors.borderColorThree),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.zero,

                    borderSide: BorderSide(color: AppColors.borderColorThree),
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
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller2.magicDataList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: AppDimensions.fifTeen),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: AppDimensions.oneThirty,
                    margin: EdgeInsets.only(right: AppDimensions.twenty),
                    child: Text(
                      controller2.magicDataList[index].names.toString(),
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
                    padding: EdgeInsets.symmetric(
                        vertical: AppDimensions.two,
                        horizontal: AppDimensions.ten),
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
                      controller2.magicDataList[index].value.toString(),
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
      ],
    );
  }
}
