// ignore_for_file: must_be_immutable, file_names

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_fonts.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/assetbase.dart';
import 'package:bandapp/navigation/app_route_maps.dart';
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
  ReviewExerView(
      {super.key,
      required this.name,
      required this.number,
      required this.getVideoUrl});
  String name = '', number = '', getVideoUrl = '';
  @override
  State<ReviewExerView> createState() => _ReviewExerViewState();
}

class _ReviewExerViewState extends State<ReviewExerView> {
  var dsh = Get.isRegistered<ReviewExerController>()
      ? Get.find<ReviewExerController>()
      : Get.put(ReviewExerController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewExerController>(
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
                  Navigator.pop(context, true);
                  Get.delete<ReviewExerController>();
                },
              ),
            )),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: AppDimensions.twenty),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: AppDimensions.fifTeen),
            ExerciseNameVideo(
                getName: widget.name,
                getNumber: widget.number,
                getVideoLink: widget.getVideoUrl),
            SizedBox(height: AppDimensions.twentyFive),
            LastSessionClass(controller2: controller),
            ButtonCommonArrowClass(
                isMargin: false,
                onTap: (p0) async {
                  pushNewScreen(context,
                          screen: EditReviewSessionExerView(
                            name: widget.name,
                            number: widget.number,
                          ),
                          withNavBar: true)
                      .then((value) {
                    if (value != null) {
                      controller.getSessionDetailApi(
                          int.parse(controller.getSessionIdSave));
                    }
                  });
                },
                buttonText: AppStrings.editLogText.toUpperCase()),
            SizedBox(height: AppDimensions.thirty),
          ]),
        ),
      ),
    );
  }
}

class ExerciseNameVideo extends StatelessWidget {
  ExerciseNameVideo(
      {Key? key,
      required this.getName,
      required this.getNumber,
      required this.getVideoLink})
      : super(key: key);
  String getName = '', getNumber = '', getVideoLink = '';
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
            SizedBox(
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
        GestureDetector(
          onTap: () {
            AppRouteMaps.goToTrainVideoScreen(getVideoLink);
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
        SizedBox(height: AppDimensions.thirty),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller2.magicDataList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: AppDimensions.fifTeen),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: index == 0
                        ? EdgeInsets.only(
                            bottom: AppDimensions.ten,
                            right: AppDimensions.twenty)
                        : EdgeInsets.only(right: AppDimensions.twenty, top: 5),
                    width: AppDimensions.oneThirty,
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
                  index == 0
                      ? Container(
                          margin: EdgeInsets.only(bottom: AppDimensions.ten),
                          child: Row(
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.only(right: AppDimensions.ten),
                                width: AppDimensions.oneThirty,
                                height: AppDimensions.forty,
                                child: TextFormField(
                                  controller: controller2.notesController,
                                  readOnly: true,
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
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(
                                          color: AppColors.borderColorThree),
                                    ),
                                    focusedErrorBorder:
                                        const OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(
                                          color: AppColors.borderColorThree),
                                    ),
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(
                                          color: AppColors.borderColorThree),
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
                        )
                      : Container(
                          padding: index == 1
                              ? EdgeInsets.symmetric(
                                  vertical: AppDimensions.two,
                                  horizontal: AppDimensions.five)
                              : EdgeInsets.symmetric(
                                  vertical: AppDimensions.two),
                          width: AppDimensions.oneSixty,
                          decoration: BoxDecoration(
                              color: index == 1 ? Colors.white : Colors.white,
                              border: index == 0 || index == 1
                                  ? Border.all(
                                      color: Colors.white,
                                      width: AppDimensions.two)
                                  : Border.all(color: Colors.white),
                              borderRadius:
                                  BorderRadius.circular(AppDimensions.four)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: AppDimensions.hunDred,
                                child: Builder(builder: (context) {
                                  String name = '';
                                  if (index == 1) {
                                    for (var i = 0;
                                        i < controller2.storeAllLastData.length;
                                        i++) {
                                      if (name.isEmpty) {
                                        name = controller2
                                            .storeAllLastData[i].band!.band
                                            .toString();
                                      } else {
                                        name =
                                            '$name / ${controller2.storeAllLastData[i].band?.band}';
                                      }
                                    }
                                  } else {
                                    name = controller2
                                        .magicDataList[index].value
                                        .toString();
                                  }
                                  return Text(
                                    name,
                                    // overflow:controller2.storeAllLastData.length > 1 ? TextOverflow.ellipsis: TextOverflow.visible,
                                    style: TextStyle(
                                        fontSize: AppDimensions.sixTeen,
                                        fontFamily: AppFonts.robotoMedium,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.0,
                                        color: AppColors.textButtonColor),
                                  );
                                }),
                              ),
                              // index == 1
                              //     ? SizedBox(width: AppDimensions.ten)
                              //     : Container(),
                              // index == 1 &&
                              //         controller2.storeAllLastData.length > 1
                              //     ? Text(
                              //         "+ ${ controller2.storeAllLastData.length}",
                              //         style: TextStyle(
                              //             fontSize: AppDimensions.sixTeen,
                              //             fontFamily: AppFonts.robotoMedium,
                              //             fontWeight: FontWeight.w500,
                              //             letterSpacing: 1.0,
                              //             color: index == 1
                              //                 ? Colors.white
                              //                 : AppColors.textButtonColor),
                              //       )
                              //     : Container(),
                            ],
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
