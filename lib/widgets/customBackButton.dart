// ignore_for_file: file_names, must_be_immutable

import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_fonts.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/appstyle/assetbase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBack extends StatelessWidget {
  const CustomBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context,true);
          },
          child: SvgPicture.asset(AssetsBase.backButtonSvg,
              height: AppDimensions.twentyFive),
        ),
        SizedBox(width: AppDimensions.twelve),
        SvgPicture.asset(AssetsBase.bandasticTextSvg),
        SizedBox(width: AppDimensions.ten),
        Text(
          AppStrings.training,
          textAlign: TextAlign.end,
          style: AppThemeStyle.trainingText,
        )
      ],
    );
  }
}

class CustomWithoutTraining extends StatelessWidget {
   CustomWithoutTraining({super.key,required this.navigateBack});
  Function()? navigateBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: navigateBack,
          child: SvgPicture.asset(AssetsBase.backButtonSvg,
              height: AppDimensions.twentyFive),
        ),
        // SizedBox(width: AppDimensions.twelve),
        Expanded(child: SvgPicture.asset(AssetsBase.bandasticTextSvg)),
      ],
    );
  }
}

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(AssetsBase.backButtonSvg,
            height: AppDimensions.twentyFive),
        Expanded(child: SvgPicture.asset(AssetsBase.bandasticTextSvg)),
      ],
    );
  }
}

class CustomHeaderBack extends StatelessWidget {
  const CustomHeaderBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context,true);
              },
              child: SvgPicture.asset(AssetsBase.backButtonSvg,
                  height: AppDimensions.twentyFive),
            ),
            SizedBox(width: AppDimensions.twelve),
            SvgPicture.asset(AssetsBase.bandasticTextSvg),
          ],
        ),
      ],
    );
  }
}

class CustomWithTextHeader extends StatelessWidget {
  CustomWithTextHeader(
      {super.key, required this.getHeadingText, required this.isBackAllow,required this.navigateBack});
  String getHeadingText = '';
  bool isBackAllow = false;
  Function()? navigateBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.ce,
      children: [
        isBackAllow == true
            ? GestureDetector(
                onTap: navigateBack,
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: AppDimensions.eight),
                  height: AppDimensions.forty,
                  child: SvgPicture.asset(AssetsBase.backButtonSvg,
                      height: AppDimensions.twentyFive),
                ),
              )
            : SvgPicture.asset(AssetsBase.backButtonSvg,
                height: AppDimensions.twentyFive),
        Expanded(
          child: Text(
            getHeadingText,
            textAlign: TextAlign.center,
            style: AppThemeStyle.headingAppBar18,
          ),
        ),
      ],
    );
  }
}

class CustomWithNewHeader extends StatelessWidget {
  CustomWithNewHeader(
      {super.key,
      required this.getHeadingText,
      required this.getSubHeadText,
      required this.isBackAllow,required this.isStyleChange});
  String getHeadingText = '', getSubHeadText = '';
  bool isBackAllow = false;
  bool isStyleChange = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isBackAllow == true
            ? GestureDetector(
                onTap: () {
                  Navigator.pop(context,true);
                },
                child: SvgPicture.asset(AssetsBase.backButtonSvg,
                    height: AppDimensions.thirty),
              )
            : SvgPicture.asset(AssetsBase.backButtonSvg,
                height: AppDimensions.thirty),

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: AppDimensions.ten),

            Text(
              getHeadingText,
              style: AppThemeStyle.semiBold13,
            ),
            SizedBox(height: AppDimensions.three)
,            Text(
              getSubHeadText,
              style: isStyleChange == false
                  ? AppThemeStyle.extraBold18
                  : TextStyle(
                      fontSize: AppDimensions.eighteen,
                      fontFamily: AppFonts.plusSansBold,
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
            ),
          ],
        )
      ],
    );
  }
}
