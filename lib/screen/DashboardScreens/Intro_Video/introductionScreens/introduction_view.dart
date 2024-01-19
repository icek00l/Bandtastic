// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_fonts.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/model/bandsModel.dart';
import 'package:bandapp/navigation/app_route_maps.dart';
import 'package:bandapp/screen/DashboardScreens/Intro_Video/introductionScreens/introduction_controller.dart';
import 'package:bandapp/utility/custom_UI.dart';
import 'package:bandapp/widgets/customBackButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class IntroductionView extends StatefulWidget {
  const IntroductionView({super.key});

  @override
  State<IntroductionView> createState() => _IntroductionViewState();
}

class _IntroductionViewState extends State<IntroductionView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<IntroductionController>(
      init: IntroductionController(),
      builder: (controller) => Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                  AppDimensions.seventy), // here the desired height
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: AppDimensions.zero,
                title: const CustomHeader(),
              )),
          body: RefreshIndicator(
            color: AppColors.buttonColor,
            onRefresh: () async {
              controller.getIntroApi();
            },
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: AppDimensions.twenty),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppDimensions.fifTeen),
                    const IntroHeading(),
                    SizedBox(height: AppDimensions.twenty),
                    InYourBoxData(getController: controller),
                    SizedBox(height: AppDimensions.forty),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

// Introduction class
class IntroHeading extends StatelessWidget {
  const IntroHeading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        AppStrings.introHeadText,
        style: AppThemeStyle.heading28Bold,
      ),
      SizedBox(height: AppDimensions.twenty),
      Text(
        AppStrings.introdescText,
        style: TextStyle(
            height: 1.6,
            fontSize: AppDimensions.sixTeen,
            fontWeight: FontWeight.w400,
            wordSpacing: 1.0,
            fontFamily: AppFonts.robotoRegular,
            color: AppColors.secondaryTextColor),
      ),
      SizedBox(height: AppDimensions.twentyFive),
    ]);
  }
}

// MultipleData class
class InYourBoxData extends StatelessWidget {
  InYourBoxData({Key? key, required this.getController}) : super(key: key);
  IntroductionController getController;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: getController.introGetDataList.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            const CustomStraightLine(),
            SizedBox(height: AppDimensions.five),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getController.introGetDataList[index].title ?? "",
                  style: AppThemeStyle.introDataCommon,
                ),
                IconButton(
                    onPressed: () {
                      getController.introGetDataList[index].isListSelect =
                          !getController.introGetDataList[index].isListSelect;
                      getController.update();
                    },
                    icon: Icon(
                      getController.introGetDataList[index].isListSelect
                          ? Icons.remove_outlined
                          : Icons.add_outlined,
                      size: AppDimensions.twentyFive,
                      color: Colors.black,
                    ))
              ],
            ),
            getController.introGetDataList[index].isListSelect
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: getController
                        .introGetDataList[index].introContent!.length,
                    itemBuilder: (context, index1) {
                      return GestureDetector(
                        onTap: () {
                          if(getController
                              .introGetDataList[index].introContent![index1].url!.isNotEmpty) {
                          AppRouteMaps.goToTrainVideoScreen(getController
                              .introGetDataList[index].introContent![index1].url
                              .toString());
                          }else {
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
                          margin: EdgeInsets.only(top: AppDimensions.twenty),
                          child: Text(
                            getController.introGetDataList[index]
                                .introContent![index1].title
                                .toString(),
                            style: AppThemeStyle.robotoflex16,
                          ),
                        ),
                      );
                    },
                  )
                : Container(),
            getController.introGetDataList[index].isListSelect
                ? SizedBox(height: AppDimensions.thirty)
                : SizedBox(height: AppDimensions.ten),
            const CustomLine(),
            SizedBox(height: AppDimensions.ten),
          ],
        );
      },
    );
  }

  Widget InyourBboxData(List<IntroDataModel> dataList) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // AppRouteMaps.goToTrainVideoScreen();
          },
          child: Container(
            margin: EdgeInsets.only(top: AppDimensions.twenty),
            child: Text(
              dataList[index].names.toString(),
              style: AppThemeStyle.robotoflex16,
            ),
          ),
        );
      },
    );
  }
}
