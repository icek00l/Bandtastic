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
import 'package:bandapp/utility/Utility.dart';
import 'package:bandapp/utility/custom_UI.dart';
import 'package:bandapp/utility/sharePrefs/shared_pref_key.dart';
import 'package:bandapp/utility/sharePrefs/shared_prefs.dart';
import 'package:bandapp/widgets/buttonBackground.dart';
import 'package:bandapp/widgets/customBackButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SessionScreenView extends StatelessWidget {
  const SessionScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SessionController>(
        init: SessionController(),
        builder: (controller) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(
                    AppDimensions.seventy), // here the desired height
                child: AppBar(
                    backgroundColor: Colors.white,
                    elevation: AppDimensions.zero,
                    title: controller.getSessionInfoDataList.isEmpty
                        ? CustomWithTextHeader(
                            getHeadingText: "Session",
                            isBackAllow: false,
                            navigateBack: () {
                              Navigator.pop(context);
                            },
                          )
                        : controller.isShowVideo
                            ? CustomWithTextHeader(
                                getHeadingText:
                                    controller.sessionData.data!.name ?? "",
                                isBackAllow: false,
                                navigateBack: () {
                                  Navigator.pop(context);
                                },
                              )
                            : CustomWithNewHeader(
                                getHeadingText: Utility.storeName.isEmpty
                                    ? ""
                                    : Utility.storeName,
                                getSubHeadText:
                                    "Session: ${controller.formatDuration(controller.durationdf)}",
                                isBackAllow: false,
                                isStyleChange: true,
                              )),
              ),
              body: RefreshIndicator(
                color: AppColors.buttonColor,
                onRefresh: () async {
                  controller
                      .getSessionDetailApi(int.parse(controller.getSessionID));
                },
                child: SingleChildScrollView(
                  child: controller.getSessionInfoDataList.isNotEmpty
                      ? Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: AppDimensions.twenty),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: AppDimensions.fifTeen),
                              VideoReady(controllerGet: controller),
                              SizedBox(height: AppDimensions.ten),
                              PreparationSheet(getSessionValue: controller),
                              SizedBox(height: AppDimensions.ten),
                              VideoGridView(
                                  getExerciseGrid: controller.exerciseVideo,
                                  getExtraData: controller.extraData,
                                  controller3: controller)
                            ],
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
                ),
              ));
        });
  }
}

class LineWithText extends StatelessWidget {
  final List<String?> textList;

  LineWithText({required this.textList});

  @override
  Widget build(BuildContext context) {
    return textList.isEmpty
        ? const IgnorePointer()
        : CustomPaint(
            painter: VerticalLineWithTextPainter(textList: textList),
            child: Container(height: 170),
          );
  }
}

class VerticalLineWithTextPainter extends CustomPainter {
  final List<String?> textList;

  VerticalLineWithTextPainter({required this.textList});
  @override
  void paint(Canvas canvas, Size size) {
    Paint linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;

    Paint containerPaint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.fill;

    Paint borderPaint = Paint()
      ..color = AppColors.containerColor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    double centerX = size.width / 2;
    double centerY = size.height / 2;

    if (textList.length == 1) {
      String singleValue = textList.first ?? "";
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: "$singleValue  ",
          style: AppThemeStyle.robotoflex13Medium.copyWith(color: Colors.black),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(minWidth: 0, maxWidth: size.width);

      double textX = centerX - textPainter.width / 2;
      double textY = centerY - textPainter.height / 2;

      textPainter.paint(canvas, Offset(textX, textY));

      double dotX = centerX + textPainter.width / 2 + 10;
      double dotY = centerY;
      canvas.drawCircle(Offset(dotX, dotY), 6, linePaint);
      return;
    }

    for (int i = 0; i < textList.length; i++) {
      double fraction = i / (textList.length - 1);
      double x = centerX;
      double y = centerY - 75 + fraction * 150;

      double containerWidth = 70;
      double containerHeight = 24;
      double containerX = x - containerWidth - 10;
      double containerY = y - containerHeight / 2;

      RRect containerRect = RRect.fromRectAndRadius(
        Rect.fromPoints(
          Offset(containerX, containerY),
          Offset(containerX + containerWidth, containerY + containerHeight),
        ),
        Radius.circular(AppDimensions.twenty),
      );

      if (textList[i]!.isNotEmpty) {
        canvas.drawRRect(containerRect, containerPaint);

        canvas.drawRRect(containerRect, borderPaint);
      }
      canvas.drawLine(
        Offset(centerX, centerY - 75),
        Offset(centerX, centerY + 75),
        linePaint,
      );

      canvas.drawCircle(Offset(x, y), 6, linePaint);

      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: "${textList[i]}  ",
          style: AppThemeStyle.robotoflex13Medium.copyWith(color: Colors.black),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(minWidth: 0, maxWidth: size.width);

      double textX = x - textPainter.width - 10;
      textX = textX < 0 ? 0 : textX;
      double textY = y - textPainter.height / 2;

      textPainter.paint(canvas, Offset(textX, textY));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
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
                  controllerGet.sessionData.data!.video != null
                      ? controllerGet.sessionData.data!.video.isEmpty
                          ? ""
                          : AppRouteMaps.goToTrainVideoScreen(
                              controllerGet.sessionData.data!.video ?? "")
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
        GestureDetector(
          onTap: () {
            getSessionValue.toggleContainer();
          },
          child: Container(
            color: Colors.transparent,
            child: Row(
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
                Icon(
                  getSessionValue.isIconChange
                      ? Icons.add_outlined
                      : Icons.remove_rounded,
                  size: AppDimensions.twentyFive,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
        SizedBox(height: AppDimensions.ten),
        SizeTransition(
            sizeFactor: getSessionValue.animation,
            axis: Axis.vertical,
            child: bandAnchorsList(
                context, getSessionValue.exerciseVideo, getSessionValue)),
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

  Widget bandAnchorsList(context, videoGridhere, controllerSession) {
    return Column(
      children: [
        AnchorsListData(controller4: controllerSession),
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

class AnchorsListData extends StatelessWidget {
  AnchorsListData({super.key, required this.controller4});
  SessionController controller4;

  @override
  Widget build(BuildContext context) {
    List<String> modifiedList = [];
    // if (controller4.sessionData.anchor != null) {
    //   List<String> modifyList(List<String> originalList) {
    //     List<String> predefinedOrder = [
    //       "HEAD",
    //       "CHEST",
    //       "NAVAL",
    //       "THIGH",
    //       "FEET"
    //     ];

    //     List<String> modifiedList = predefinedOrder
    //         .where((item) => originalList.contains(item))
    //         .toList();

    //     return modifiedList;
    //   }

    //   modifiedList = modifyList(controller4.sessionData.anchor!);
    // }
    if (controller4.sessionData.anchor != null) {
      List<String> predefinedOrder = [
        "HEAD",
        "CHEST",
        "NAVAL",
        "THIGH",
        "FEET"
      ];

      Map<String, bool> presenceMap = {};
      for (var item in predefinedOrder) {
        presenceMap[item] = controller4.sessionData.anchor!.contains(item);
      }

      for (var item in predefinedOrder) {
        if (presenceMap[item]!) {
          modifiedList.add(item);
        } else {
          modifiedList.add("");
        }
      }
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.anchorText,
          style: AppThemeStyle.fifteenBoldRoboto,
        ),
        SizedBox(height: AppDimensions.sixTeen),
        LineWithText(textList: modifiedList)
        //     controller4.anchorImage == "NAVAL"
        //         ? SvgPicture.asset(
        //             AssetsBase.navalAnchor,
        //             color: Colors.black,
        //           )
        //         : controller4.anchorImage == "HEAD"
        //             ? SvgPicture.asset(
        //                 AssetsBase.headAnchor,
        //                 color: Colors.black,
        //               )
        //             : controller4.anchorImage == "CHEST"
        //                 ? SvgPicture.asset(
        //                     AssetsBase.chestAnchor,
        //                     color: Colors.black,
        //                   )
        //                 : controller4.anchorImage == "HIP"
        //                     ? SvgPicture.asset(
        //                         AssetsBase.hipAnchor,
        //                         color: Colors.black,
        //                       )
        //                     : controller4.anchorImage == "FEET"
        //                         ? SvgPicture.asset(
        //                             AssetsBase.feetAnchor,
        //                             color: Colors.black,
        //                           )
        //                         : Container()
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
    print(controller3.sessionData.data);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller3.getSessionInfoDataList.length > 6
                ? 6
                : controller3.getSessionInfoDataList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: AppDimensions.oneSixty,
                crossAxisSpacing: AppDimensions.thirty,
                mainAxisSpacing: AppDimensions.thirtyfive),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  print(
                      controller3.getSessionInfoDataList[index].url.toString());
                  if (controller3
                      .getSessionInfoDataList[index].isUserExcercise!) {
                    print(controller3.getSessionInfoDataList[index].url
                        .toString());
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
                                name: controller3
                                        .getSessionInfoDataList[index].name ??
                                    "",
                                number:
                                    getExerciseGrid[index].value!.toString(),
                                getVideoUrl: controller3
                                    .getSessionInfoDataList[index].url
                                    .toString(),
                              ),
                              withNavBar: true)
                          .then((value) {
                        controller3.getSessionDetailApi(
                            int.parse(controller3.getSessionID));
                      });
                    });
                  } else {
                    if (controller3.sessionData.data!.sessionComplete ==
                        false) {
                      controller3.startTimer();
                      SharedPrefs.saveStringInPrefs(
                              SharedPrefKeys.exerciseTypeID,
                              controller3.getSessionInfoDataList[index].id
                                  .toString())
                          .then((value) {
                        pushNewScreen(context,
                                screen: ExerciseLogBandView(
                                  getExerName: controller3
                                          .getSessionInfoDataList[index].name ??
                                      "",
                                  getNumber:
                                      getExerciseGrid[index].value!.toString(),
                                  getURlHere: controller3
                                      .getSessionInfoDataList[index].url
                                      .toString(),
                                      getImageURlHere: controller3
                                    .getSessionInfoDataList[index].image ??
                                "",
                                ),
                                withNavBar: true)
                            .then((value) {
                          if (value == true) {
                            controller3.getSessionDetailApi(
                                int.parse(controller3.getSessionID));
                          }
                        });
                      });
                    }
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
                    image: controller3.getSessionInfoDataList[index]
                                .isUserExcercise ==
                            true
                        ? const DecorationImage(
                            image: AssetImage(AssetsBase.iconArrow),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.transparent, BlendMode.dstATop),
                          )
                        : DecorationImage(
                            image: NetworkImage(controller3
                                    .getSessionInfoDataList[index].image ??
                                ""),
                            fit: BoxFit.cover),
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
                                color: controller3.getSessionInfoDataList[index]
                                            .isUserExcercise ==
                                        true
                                    ? AppColors.buttonColor
                                    : AppColors.backgColorOne,
                                borderRadius:
                                    BorderRadius.circular(AppDimensions.fifty)),
                            child: Text(
                              getExerciseGrid[index].value.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: controller3
                                              .getSessionInfoDataList[index]
                                              .isUserExcercise ==
                                          true
                                      ? Colors.white
                                      : Colors.black,
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
                                            bottom: AppDimensions.three),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                controller3
                                                        .getSessionInfoDataList[
                                                            index]
                                                        .responseDataSession![
                                                            index1]
                                                        .name ??
                                                    "N/A",
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
                                            SizedBox(width: AppDimensions.five),
                                            Container(
                                              alignment: Alignment.center,
                                              height: AppDimensions.fifTeen,
                                              width: AppDimensions.twentySix,
                                              decoration: BoxDecoration(
                                                  color: AppColors.buttonColor,
                                                  border: Border.all(
                                                      color:
                                                          AppColors.buttonColor,
                                                      width:
                                                          AppDimensions.one)),
                                              child: Text(
                                                index1 == 0
                                                    ? controller3
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
                                                        : "NA"
                                                    : controller3
                                                            .getSessionInfoDataList[
                                                                index]
                                                            .responseDataSession![
                                                                index1]
                                                            .value ??
                                                        "N/A",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize:
                                                        AppDimensions.nine,
                                                    fontFamily:
                                                        AppFonts.robotoFlex,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white),
                                              ),
                                            )
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
                              backgroundColor:  AppColors.buttonColor,
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
        controller3.isExtraExercise
            ? GestureDetector(
                onTap: () {
                  if (controller3.getSessionInfoDataList[6].isUserExcercise!) {
                    print(controller3
                        .getSessionInfoDataList[6].userExcercise!.id);
                    SharedPrefs.saveStringInPrefs(
                        SharedPrefKeys.exerciseEditID,
                        controller3.getSessionInfoDataList[6].userExcercise!.id
                            .toString());
                    SharedPrefs.saveStringInPrefs(
                            SharedPrefKeys.exerciseTypeID,
                            controller3.getSessionInfoDataList[6].userExcercise!
                                .excerciseTypeId
                                .toString())
                        .then((value) {
                      pushNewScreen(context,
                          screen: ReviewExerView(
                            name: controller3.getSessionInfoDataList[6].name ??
                                "",
                            number: getExerciseGrid[6].value!.toString(),
                            getVideoUrl: controller3
                                .getSessionInfoDataList[6].url
                                .toString(),
                          ),
                          withNavBar: true);
                    }).then((value) {
                      if (value == true) {
                        controller3.getSessionDetailApi(
                            int.parse(controller3.getSessionID));
                      }
                    });
                  } else {
                    if (controller3.sessionData.data!.sessionComplete ==
                        false) {
                      controller3.startTimer();

                      if (controller3
                              .getSessionInfoDataList[6].isUserExcercise ==
                          false) {
                        controller3.value = 6.toString();
                        controller3.getNamehere =
                            controller3.getSessionInfoDataList[6].name!;
                        controller3.getNumberhere =
                            getExerciseGrid[6].value.toString();
                        controller3.getExerVideo =
                            controller3.getSessionInfoDataList[6].url!;
                      }

                      if (controller3.getNamehere.isNotEmpty) {
                        SharedPrefs.saveStringInPrefs(
                                SharedPrefKeys.exerciseTypeID,
                                controller3.getSessionInfoDataList[6].id
                                    .toString())
                            .then((value) {
                          pushNewScreen(context,
                                  screen: ExerciseLogBandView(
                                    getExerName: controller3
                                            .getSessionInfoDataList[6].name ??
                                        "",
                                    getNumber: controller3.getNumberhere,
                                    getURlHere: controller3
                                        .getSessionInfoDataList[6].url,
                                        getImageURlHere: controller3
                                    .getSessionInfoDataList[6].image ??
                                "",
                                  ),
                                  withNavBar: true)
                              .then((value) {
                            if (value == true) {
                              controller3.getSessionDetailApi(
                                  int.parse(controller3.getSessionID));
                            }
                          });
                        });
                      }
                    }
                  }
                },
                child: Container(
                  height: AppDimensions.onetwenty,
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(AppDimensions.five,
                      AppDimensions.five, AppDimensions.ten, AppDimensions.ten),
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  bottom: AppDimensions.thirty6),
                              height: AppDimensions.thirtyfive,
                              width: AppDimensions.thirtyfive,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      AppDimensions.fifty)),
                              child: Icon(
                                Icons.add_outlined,
                                color: Colors.black,
                                size: AppDimensions.twenty,
                              )),
                          Container(
                              alignment: Alignment.topLeft,
                              width: AppDimensions.oneThirty,
                              child: DataAddList(
                                getExtraData: controller3.extraData,
                              )),
                        ],
                      ),
                      SizedBox(
                        width: AppDimensions.hunDred,
                        child: Text(
                          controller3.isExtraExerciseName,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: AppDimensions.forteen,
                              fontFamily: AppFonts.robotoFlex,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(),
        controller3.buttonName.isEmpty
            ? const IgnorePointer()
            : SizedBox(height: AppDimensions.fifty),
        controller3.buttonName.isEmpty
            ? const IgnorePointer()
            : Text(
                "${AppStrings.next} :",
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: AppDimensions.sixTeen,
                    fontFamily: AppFonts.robotoMedium),
              ),
        controller3.buttonName.isEmpty
            ? const IgnorePointer()
            : SizedBox(height: AppDimensions.twenty),
        controller3.sessionData.data!.sessionComplete == false
            ? controller3.buttonName.isEmpty
                ? const IgnorePointer()
                : CenterButtonArrowClass(
                    onTap: (p0) {
                      if (controller3.sessionData.data!.sessionComplete ==
                          false) {
                        controller3.startTimer();

                        for (int i = 0;
                            i < controller3.getSessionInfoDataList.length;
                            i++) {
                          if (controller3
                                  .getSessionInfoDataList[i].isUserExcercise ==
                              false) {
                            controller3.value = i.toString();
                            controller3.getNamehere =
                                controller3.getSessionInfoDataList[i].name ??
                                    "";
                            controller3.getNumberhere =
                                getExerciseGrid[i].value.toString();
                            controller3.getExerVideo =
                                controller3.getSessionInfoDataList[i].url!;
                            break;
                          }
                        }
                        if (controller3.getNamehere.isNotEmpty) {
                          print(controller3
                              .getSessionInfoDataList[
                                  int.parse(controller3.value)]
                              .id);
                          SharedPrefs.saveStringInPrefs(
                                  SharedPrefKeys.exerciseTypeID,
                                  controller3
                                      .getSessionInfoDataList[
                                          int.parse(controller3.value)]
                                      .id
                                      .toString())
                              .then((value) {
                            pushNewScreen(context,
                                    screen: ExerciseLogBandView(
                                      getExerName: controller3.getNamehere,
                                      getNumber: controller3.getNumberhere,
                                      getURlHere: controller3.getExerVideo,
                                      getImageURlHere: controller3
                                    .getSessionInfoDataList[int.parse(controller3.value)].image ??
                                "",
                                    ),
                                    withNavBar: true)
                                .then((value) {
                              if (value == true) {
                                controller3.getSessionDetailApi(
                                    int.parse(controller3.getSessionID));
                              }
                            });
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
        controller3.sessionData.data!.sessionComplete == false
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
                        break;
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Oops! You have to complete at least one exercise."),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: AppColors.errorColor,
                        duration: Duration(seconds: 1),
                      ));
                      break;
                    }
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
      itemCount: getExtraData.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                    width: AppDimensions.hunDred,
                    child: Text(getExtraData[index].name ?? "",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            backgroundColor: AppColors.buttonColor,
                            fontSize: AppDimensions.twelve,
                            fontFamily: AppFonts.robotoFlex,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))),
                SizedBox(width: AppDimensions.ten),
                index == 0
                    ? Container(
                        alignment: Alignment.center,
                        height: AppDimensions.thirteen,
                        width: AppDimensions.sixTeen,
                        decoration: BoxDecoration(
                            color: AppColors.buttonColor,
                            border: Border.all(
                                color: AppColors.buttonColor,
                                width: AppDimensions.one)),
                        child: Text(
                          getExtraData[index].value!.isNotEmpty
                              ? getExtraData[index]
                                  .value!
                                  .substring(0, 2)
                                  .toString()
                              : "NA",
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
                          getExtraData[index].value ?? "",
                          textAlign: TextAlign.end,
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
