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
import 'package:get/instance_manager.dart';

class IntroductionView extends StatefulWidget {
  const IntroductionView({super.key});

  @override
  State<IntroductionView> createState() => _IntroductionViewState();
}

class _IntroductionViewState extends State<IntroductionView> {
  var dsh = Get.isRegistered<IntroductionController>()
      ? Get.find<IntroductionController>()
      : Get.put(IntroductionController());

  @override
  Widget build(BuildContext context) => GetBuilder<IntroductionController>(
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
            body: SingleChildScrollView(
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
                    ]),
              ),
            ),
          ));
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomStraightLine(),
      SizedBox(height: AppDimensions.fifTeen),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppStrings.inYourBoxText,
            style: AppThemeStyle.introDataCommon,
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add_outlined,
                size: AppDimensions.twentyFive,
                color: Colors.black,
              ))
        ],
      ),
      SizedBox(height: AppDimensions.five),
      const CustomLine(),
      SizedBox(height: AppDimensions.ten),
      const CustomStraightLine(),
      SizedBox(height: AppDimensions.five),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppStrings.myStoryText,
            style: AppThemeStyle.introDataCommon,
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add_outlined,
                size: AppDimensions.twentyFive,
                color: Colors.black,
              ))
        ],
      ),
      SizedBox(height: AppDimensions.five),
      const CustomLine(),
      SizedBox(height: AppDimensions.ten),
      const CustomStraightLine(),
      SizedBox(height: AppDimensions.five),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppStrings.bandTrainText,
            style: AppThemeStyle.introDataCommon,
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add_outlined,
                size: AppDimensions.twentyFive,
                color: Colors.black,
              ))
        ],
      ),
      SizedBox(height: AppDimensions.five),
      const CustomLine(),
      SizedBox(height: AppDimensions.ten),
      const CustomStraightLine(),
      SizedBox(height: AppDimensions.five),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppStrings.howUseText,
            style: AppThemeStyle.introDataCommon,
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add_outlined,
                size: AppDimensions.twentyFive,
                color: Colors.black,
              ))
        ],
      ),
      SizedBox(height: AppDimensions.five),
      const CustomLine(),
      SizedBox(height: AppDimensions.ten),
      const CustomStraightLine(),
      SizedBox(height: AppDimensions.fifTeen),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppStrings.trainviewText,
            style: AppThemeStyle.introDataCommon,
          ),
          IconButton(
              onPressed: () {
                getController.toggleContainer();
              },
              icon: Icon(
                getController.isIconChange
                    ? Icons.add_outlined
                    : Icons.remove_rounded,
                size: AppDimensions.twentyFive,
                color: Colors.black,
              ))
        ],
      ),
      SizeTransition(
          sizeFactor: getController.animation,
          axis: Axis.vertical,
          child: InyourBboxData(getController.introList)),
      getController.isIconChange
          ? SizedBox(height: AppDimensions.ten)
          : SizedBox(height: AppDimensions.thirty),
      const CustomLine(),
    ]);
  }

  Widget InyourBboxData(List<IntroDataModel> dataList) {
    return ListView.builder(
      shrinkWrap: true,
      physics:const NeverScrollableScrollPhysics(),
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            AppRouteMaps.goToTrainVideoScreen();
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
