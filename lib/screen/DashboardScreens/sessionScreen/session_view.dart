// ignore_for_file: must_be_immutable, avoid_print

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_fonts.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/appstyle/assetbase.dart';
import 'package:bandapp/model/bandsModel.dart';
import 'package:bandapp/model/sessionDetailModal.dart';
import 'package:bandapp/navigation/app_route_maps.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/sessionMultiScreen/InEndSession/End_Session.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/sessionMultiScreen/exerciseSessionReview/exerciseReview_view.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/sessionMultiScreen/sessionTabbarScreen/exerciseLog_view.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/session_controller.dart';
import 'package:bandapp/utility/custom_UI.dart';
import 'package:bandapp/utility/sharePrefs/shared_pref_key.dart';
import 'package:bandapp/utility/sharePrefs/shared_prefs.dart';
import 'package:bandapp/widgets/buttonBackground.dart';
import 'package:bandapp/widgets/customBackButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SessionScreenView extends StatefulWidget {
  const SessionScreenView({super.key});

  @override
  State<SessionScreenView> createState() => _SessionScreenViewState();
}

class _SessionScreenViewState extends State<SessionScreenView> {
  var dsh = Get.isRegistered<SessionController>()
      ? Get.find<SessionController>()
      : Get.put(SessionController());
  @override
  Widget build(BuildContext context) {
    dsh.onInit();

    return GetBuilder<SessionController>(builder: (controller) {
      return controller.getNameDay.isNotEmpty
          ? Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(
                      AppDimensions.seventy), // here the desired height
                  child: AppBar(
                      backgroundColor: Colors.white,
                      elevation: AppDimensions.zero,
                      title: controller.isShowVideo
                          ? CustomWithTextHeader(
                              getHeadingText:
                                  "${controller.getNameDay}  Session",
                              isBackAllow: false,
                              navigateBack: () {
                                Navigator.pop(context);
                              },
                            )
                          : CustomWithNewHeader(
                              getHeadingText:
                                  "Wk 1 OF 6 | ${controller.getNameDay}",
                              // getSubHeadText: "Session: $hours:$minutes:$seconds",
                              getSubHeadText:
                                  "Session: ${controller.formatDuration(controller.durationdf)}",
                              isBackAllow: false,
                              isStyleChange: true,
                            ))),
              body: controller.getSessionInfoDataList.isNotEmpty
                  ? SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: AppDimensions.twenty),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: AppDimensions.fifTeen),
                              VideoReady(controllerGet: controller),
                              SizedBox(height: AppDimensions.ten),
                              PreparationSheet(
                                getSessionValue: controller,
                              ),
                              SizedBox(height: AppDimensions.ten),
                              VideoGridView(
                                  getExerciseGrid: controller.exerciseVideo,
                                  getExtraData: controller.extraData,
                                  controller3: controller),
                            ]),
                      ),
                    )
                  : Center(
                      child: Text(
                        "No Session added for this day",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: AppDimensions.forteen),
                      ),
                    ),
            )
          : Container();
    });
  }
}
// topVideoandText

class VideoReady extends StatelessWidget {
  VideoReady({super.key, required this.controllerGet});
  SessionController controllerGet;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        controllerGet.isShowVideo
            ? GestureDetector(
                onTap: () {
                  controllerGet.getFirstVideoUrl != ""
                      ? AppRouteMaps.goToTrainVideoScreen(
                          controllerGet.getFirstVideoUrl)
                      : Container();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height / 4,
                  width: double.infinity,
                  color: AppColors.gradientColor1,
                  alignment: Alignment.center,
                  child: SvgPicture.asset(AssetsBase.playVideoSvgIcon),
                ),
              )
            : Container(),
        controllerGet.isShowVideo
            ? SizedBox(height: AppDimensions.fifty)
            : Container(),
        Center(
          child: Text(
            AppStrings.areYouReady,
            style: TextStyle(
                fontSize: AppDimensions.twentyFour,
                fontFamily: AppFonts.plusSansMedium,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
                color: AppColors.secondaryTextColor),
          ),
        ),
        SizedBox(height: AppDimensions.fifty),
        // Divider(
        //     thickness: AppDimensions.one,
        //     indent: MediaQuery.of(context).size.width / 4,
        //     height: AppDimensions.one,
        //     color: AppColors.dividerLineColor)
        const CustomStraightLine()
      ],
    );
  }
}

class PreparationSheet extends StatelessWidget {
  PreparationSheet({super.key, required this.getSessionValue});
  SessionController getSessionValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.preparationText,
              style: TextStyle(
                  fontSize: AppDimensions.twentyTwo,
                  letterSpacing: 0.5,
                  fontFamily: AppFonts.plusSansMedium,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondaryTextColor),
            ),
            IconButton(
                onPressed: () {
                  getSessionValue.toggleContainer();
                },
                icon: Icon(
                  getSessionValue.isIconChange
                      ? Icons.add_outlined
                      : Icons.remove_rounded,
                  size: AppDimensions.twentyFive,
                  color: Colors.black,
                ))
          ],
        ),
        SizedBox(height: AppDimensions.ten),
        SizeTransition(
            sizeFactor: getSessionValue.animation,
            axis: Axis.vertical,
            child: bandAnchorsList(context, getSessionValue.bandsList,
                getSessionValue.exerciseVideo, getSessionValue)),
        getSessionValue.isIconChange
            ? SizedBox(height: AppDimensions.zero)
            : SizedBox(
                height: AppDimensions.twenty,
              ),
        getSessionValue.isIconChange
            ? SizedBox(height: AppDimensions.zero)
            : SizedBox(height: AppDimensions.ten),
        const CustomLine(),
      ],
    );
  }

  Widget bandAnchorsList(
      context, bandListhere, videoGridhere, controllerSession) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: BandColorNameList(
                bandList: bandListhere,
              ),
            ),
            Container(
              color: AppColors.dividerLineColor,
              width: AppDimensions.one,
              height: AppDimensions.oneseventy,
            ),
            Expanded(
              child: AnchorsListData(controller4: controllerSession),
            ),
          ],
        ),
        SizedBox(height: AppDimensions.thirty),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Watch the \nfull training".toUpperCase(),
              textAlign: TextAlign.end,
              style: AppThemeStyle.fifteenBoldRoboto,
            ),
            Container(
                margin: EdgeInsets.only(left: AppDimensions.ten),
                height: AppDimensions.seventy,
                width: AppDimensions.hunDred,
                color: AppColors.gradientColor1,
                alignment: Alignment.center,
                child: SvgPicture.asset(AssetsBase.playVideoSvgIcon))
          ],
        )
      ],
    );
  }
}

class BandColorNameList extends StatelessWidget {
  const BandColorNameList({
    Key? key,
    required this.bandList,
  }) : super(key: key);
  final List<BandsModel> bandList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.bandsText,
          style: AppThemeStyle.fifteenBoldRoboto,
        ),
        SizedBox(height: AppDimensions.fifTeen),
        ListView.builder(
          itemCount: bandList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: AppDimensions.five),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: AppDimensions.twenty),
                    child: Text(bandList[index].bandName.toString(),
                        textAlign: TextAlign.end,
                        style: AppThemeStyle.eightBlackBoldRoboto),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: AppDimensions.ten),
                    height: AppDimensions.fifTeen,
                    alignment: Alignment.center,
                    width: AppDimensions.thirty,
                    decoration: BoxDecoration(
                        color: bandList[index].colorValue,
                        borderRadius:
                            BorderRadius.circular(AppDimensions.eight)),
                  ),
                  Expanded(
                    child: Text(
                      bandList[index].colorName.toString(),
                      textAlign: TextAlign.start,
                      style: AppThemeStyle.fifteenMediumRoboto,
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

class AnchorsListData extends StatelessWidget {
  AnchorsListData({super.key, required this.controller4});
  SessionController controller4;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.anchorText,
          style: AppThemeStyle.fifteenBoldRoboto,
        ),
        SizedBox(height: AppDimensions.sixTeen),
        Row(
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: AppDimensions.ten),
                child: controller4.anchorImage == "Head"
                    ? SvgPicture.asset(
                        AssetsBase.headAnchor,
                        color: Colors.black,
                      )
                    : controller4.anchorImage == "Chest"
                        ? SvgPicture.asset(
                            AssetsBase.headAnchor,
                            color: Colors.black,
                          )
                        : controller4.anchorImage == "Button"
                            ? SvgPicture.asset(
                                AssetsBase.headAnchor,
                                color: Colors.black,
                              )
                            : controller4.anchorImage == "Hip"
                                ? SvgPicture.asset(
                                    AssetsBase.headAnchor,
                                    color: Colors.black,
                                  )
                                : controller4.anchorImage == "Feet"
                                    ? SvgPicture.asset(
                                        AssetsBase.headAnchor,
                                        color: Colors.black,
                                      )
                                    : Container()),
          ],
        )
      ],
    );
  }
}

// video grid
class VideoGridView extends StatelessWidget {
  VideoGridView({
    Key? key,
    required this.getExerciseGrid,
    required this.getExtraData,
    required this.controller3,
  }) : super(key: key);
  final List<ExerciseVideoList> getExerciseGrid;
  final List<ResponseSession> getExtraData;
  SessionController controller3;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller3.getSessionInfoDataList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: AppDimensions.oneSixty,
                crossAxisSpacing: AppDimensions.thirty,
                mainAxisSpacing: AppDimensions.thirtyfive),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  if (controller3
                      .getSessionInfoDataList[index].isUserExcercise!) {
                    print(controller3
                        .getSessionInfoDataList[index].userExcercise!.id);
                    SharedPrefs.saveStringInPrefs(
                        SharedPrefKeys.exerciseEditID,
                        controller3
                            .getSessionInfoDataList[index].userExcercise!.id
                            .toString());
                    SharedPrefs.saveStringInPrefs(
                            SharedPrefKeys.exerciseTypeID,
                            controller3.getSessionInfoDataList[index]
                                .userExcercise!.excerciseTypeId
                                .toString())
                        .then((value) {
                      pushNewScreen(context,
                          screen: ReviewExerView(
                            name: controller3.getSessionInfoDataList[index].name
                                .toString(),
                            number: getExerciseGrid[index].value!.toString(),
                            getVideoUrl: controller3
                                .getSessionInfoDataList[index].url
                                .toString(),
                          ),
                          withNavBar: true);
                    }).then((value) {
                      if (value == true) {
                        controller3.getSessionDetailApi(
                            int.parse(controller3.getSessionID));
                      }
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      AppDimensions.five,
                      AppDimensions.five,
                      AppDimensions.five,
                      AppDimensions.ten),
                  decoration: BoxDecoration(
                    color: controller3.getSessionInfoDataList[index]
                                .isUserExcercise ==
                            true
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
                    crossAxisAlignment: CrossAxisAlignment.end,
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
                                  color: Colors.white,
                                  fontSize: AppDimensions.sixTeen,
                                  fontFamily: AppFonts.robotoMedium),
                            ),
                          ),
                          SizedBox(
                            width: AppDimensions.eightyPx,
                            child: controller3.getSessionInfoDataList[index]
                                        .isUserExcercise ==
                                    false
                                ? Container()
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: controller3
                                        .getSessionInfoDataList[index]
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
                                                controller3
                                                    .getSessionInfoDataList[
                                                        index]
                                                    .responseDataSession![
                                                        index1]
                                                    .name
                                                    .toString(),
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    backgroundColor:
                                                        AppColors.buttonColor,
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
                                                    width: AppDimensions.twenty,
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .buttonColor,
                                                        border: Border.all(
                                                            color: AppColors
                                                                .buttonColor,
                                                            width: AppDimensions
                                                                .one)),
                                                    child: Text(
                                                      controller3
                                                              .getSessionInfoDataList[
                                                                  index]
                                                              .responseDataSession![
                                                                  index1]
                                                              .value!
                                                              .isNotEmpty
                                                          ? controller3
                                                              .getSessionInfoDataList[
                                                                  index]
                                                              .responseDataSession![
                                                                  index1]
                                                              .value!
                                                              .substring(0, 2)
                                                              .toString()
                                                          : "NA",
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
                                                            AppDimensions.two),
                                                    margin: EdgeInsets.only(
                                                        left:
                                                            AppDimensions.five),
                                                    width: AppDimensions.twenty,
                                                    color:
                                                        AppColors.buttonColor,
                                                    child: Text(
                                                      controller3
                                                          .getSessionInfoDataList[
                                                              index]
                                                          .responseDataSession![
                                                              index1]
                                                          .value
                                                          .toString(),
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          fontSize:
                                                              AppDimensions
                                                                  .twelve,
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
                        margin: EdgeInsets.only(right: AppDimensions.five),
                        padding: EdgeInsets.only(bottom: AppDimensions.two),
                        child: Text(
                          controller3.getSessionInfoDataList[index].name ?? "",
                          textAlign: TextAlign.end,
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 0.1,
                              backgroundColor: controller3
                                      .getSessionInfoDataList[index]
                                      .isUserExcercise!
                                  ? AppColors.buttonColor
                                  : Colors.transparent,
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
        SizedBox(height: AppDimensions.thirtyfive),
        Container(
          height: AppDimensions.ninty,
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(AppDimensions.five, AppDimensions.five,
              AppDimensions.ten, AppDimensions.ten),
          decoration: BoxDecoration(
            color: AppColors.sixTextColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppDimensions.twenty),
                topRight: Radius.circular(AppDimensions.five),
                bottomLeft: Radius.circular(AppDimensions.five),
                bottomRight: Radius.circular(AppDimensions.twenty)),
          ),
          child: Stack(
            alignment: Alignment.bottomLeft,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: AppDimensions.thirty6),
                      height: AppDimensions.thirtyfive,
                      width: AppDimensions.thirtyfive,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(AppDimensions.fifty)),
                      child: Icon(
                        Icons.add_outlined,
                        color: Colors.black,
                        size: AppDimensions.twenty,
                      )),
                  SizedBox(
                      width: AppDimensions.oneThirty,
                      child: DataAddList(
                        getExtraData: getExtraData,
                      )),
                ],
              ),
              SizedBox(
                width: AppDimensions.hunDred,
                child: Text(
                  " Rotator cuff",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: AppDimensions.forteen,
                      fontFamily: AppFonts.robotoFlex,
                      fontWeight: FontWeight.w600,
                      backgroundColor: AppColors.buttonColor,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppDimensions.fifty),
        Text(
          "${AppStrings.next} :",
          textAlign: TextAlign.end,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: AppDimensions.sixTeen,
              fontFamily: AppFonts.robotoMedium),
        ),
        SizedBox(height: AppDimensions.twenty),
        controller3.endSession == false
            ? CenterButtonArrowClass(
                onTap: (p0) {
                  // if (controller3.getNameDay.toUpperCase() ==
                  //     DateFormat('EEEE').format(DateTime.now()).toUpperCase()) {
                  if (controller3.endSession == false) {
                    controller3.startTimer();

                    for (int i = 0;
                        i < controller3.getSessionInfoDataList.length;
                        i++) {
                      if (controller3
                              .getSessionInfoDataList[i].isUserExcercise ==
                          false) {
                        controller3.value = i.toString();
                        controller3.getNamehere =
                            controller3.getSessionInfoDataList[i].name!;
                        controller3.getNumberhere =
                            getExerciseGrid[i].value.toString();
                        controller3.getExerVideo =
                            controller3.getSessionInfoDataList[i].url!;
                        break;
                      }
                    }
                    if (controller3.getNamehere.isNotEmpty) {
                      pushNewScreen(context,
                              screen: ExerciseLogBandView(
                                getExerName: controller3.getNamehere,
                                getNumber: controller3.getNumberhere,
                                getSessionName: controller3.getNameDay,
                                getURlHere: controller3.getExerVideo,
                              ),
                              withNavBar: true)
                          .then((value) {
                        if (value == true) {
                          controller3.getSessionDetailApi(
                              int.parse(controller3.getSessionID));
                        }
                      });
                    }
                  }
                  // }
                },
                buttonText: controller3.buttonName.isEmpty
                    ? AppStrings.letsmashText.toUpperCase()
                    : controller3.buttonName.toUpperCase())
            : Container(),
        SizedBox(height: AppDimensions.twentyFive),
        controller3.endSession == false
            ? GestureDetector(
                onTap: () {
                  for (int i = 0;
                      i < controller3.getSessionInfoDataList.length;
                      i++) {
                    if (controller3.getSessionInfoDataList[i].isUserExcercise ==
                        true) {
                      controller3.stopTimer();
                      if (controller3.storeTime != null) {
                        SharedPrefs.saveStringInPrefs(SharedPrefKeys.saveTimer,
                                controller3.storeTime.toString())
                            .then((value) {
                          pushNewScreen(context,
                                  screen: const EndSessionOverview(),
                                  withNavBar: true)
                              .then((value) {
                            if (value == true) {
                              controller3.onInit();
                            }
                          });
                        });
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please done at least one exercise"),
                        duration: Duration(milliseconds: 500),
                      ));
                    }
                    break;
                  }
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    AppStrings.endSessionText,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: AppDimensions.seventeen,
                        fontFamily: AppFonts.plusSansBold,
                        fontWeight: FontWeight.bold,
                        color: AppColors.buttonColor),
                  ),
                ),
              )
            : Container(),
        SizedBox(height: AppDimensions.fifty)
      ],
    );
  }
}

class DataAddList extends StatelessWidget {
  const DataAddList({super.key, required this.getExtraData});
  final List<ResponseSession> getExtraData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              children: [
                SizedBox(
                    width: AppDimensions.hunDred,
                    child: Text(
                      "",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: AppDimensions.twelve,
                          fontFamily: AppFonts.robotoFlex,
                          backgroundColor: AppColors.buttonColor,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                SizedBox(width: AppDimensions.ten),
                index == 0
                    ? Container(
                        alignment: Alignment.center,
                        height: AppDimensions.thirteen,
                        width: AppDimensions.sixTeen,
                        child: Text(
                          "",
                          style: TextStyle(
                              fontSize: AppDimensions.nine,
                              fontFamily: AppFonts.robotoFlex,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      )
                    : Container(
                        alignment: Alignment.centerRight,
                        height: AppDimensions.thirteen,
                        width: AppDimensions.sixTeen,
                        color: AppColors.buttonColor,
                        child: Text(
                          "",
                          style: TextStyle(
                              fontSize: AppDimensions.twelve,
                              fontFamily: AppFonts.robotoFlex,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
              ],
            ),
            SizedBox(height: AppDimensions.five),
          ],
        );
      },
    );
  }
}
