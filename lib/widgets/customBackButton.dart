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
            Navigator.pop(context);
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
  const CustomWithoutTraining({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
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
                Navigator.pop(context);
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
      {super.key, required this.getHeadingText, required this.isBackAllow});
  String getHeadingText = '';
  bool isBackAllow = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.ce,
      children: [
        isBackAllow == true
            ? GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(AssetsBase.backButtonSvg,
                    height: AppDimensions.twentyFive),
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
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(AssetsBase.backButtonSvg,
                    height: AppDimensions.twentyFive),
              )
            : SvgPicture.asset(AssetsBase.backButtonSvg,
                height: AppDimensions.twentyFive),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              getHeadingText,
              style: AppThemeStyle.semiBold13,
            ),
            Text(
              getSubHeadText,
              style: isStyleChange == false
                  ? AppThemeStyle.extraBold18
                  : TextStyle(
                      fontSize: AppDimensions.sixTeen,
                      fontFamily: AppFonts.robotoFlex,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
            ),
          ],
        )
      ],
    );
  }
}
