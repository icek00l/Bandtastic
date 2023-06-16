// ignore_for_file: must_be_immutable, file_names

import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_fonts.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/appstyle/assetbase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class ButtonCommonArrowClass extends StatelessWidget {
  ButtonCommonArrowClass(
      {Key? key,
      required this.onTap,
      required this.buttonText,
      required this.isMargin})
      : super(key: key);
  String buttonText;
  final Function(String) onTap;
  bool isMargin = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () => onTap("dsnc"),
          child: Container(
            margin: isMargin == true
                ? EdgeInsets.symmetric(horizontal: AppDimensions.twenty)
                : EdgeInsets.all(AppDimensions.zero),
            width: double.infinity,
            height: AppDimensions.fifty,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: Svg(AssetsBase.buttonBackAll), fit: BoxFit.cover)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: AppDimensions.sixTeen,
                      fontFamily: AppFonts.robotoMedium,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: AppDimensions.ten),
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CenterButtonArrowClass extends StatelessWidget {
  CenterButtonArrowClass(
      {Key? key, required this.onTap, required this.buttonText})
      : super(key: key);
  String buttonText;
  final Function(String) onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap("dsnc"),
      child: Container(
        width: double.infinity,
        height: AppDimensions.fifty,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: Svg(AssetsBase.buttonBackAll), fit: BoxFit.cover)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              buttonText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: AppDimensions.sixTeen,
                  fontFamily: AppFonts.robotoMedium,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: AppDimensions.ten),
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ButtonWithoutArrow extends StatelessWidget {
  ButtonWithoutArrow({Key? key, required this.onTap, required this.buttonText})
      : super(key: key);
  String buttonText;
  final Function(String) onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () => onTap("dsnc"),
          child: Container(
            width: double.infinity,
            height: AppDimensions.fifty,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: Svg(AssetsBase.buttonBackAll), fit: BoxFit.cover)),
            child: Align(
              child: Text(
                buttonText,
                style: AppThemeStyle.whiteTextButton500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TwoButtonClass extends StatelessWidget {
  TwoButtonClass({
    Key? key,
    required this.onTap,
    required this.firstText,
    required this.isChangeBack,
  }) : super(key: key);
  String firstText;
  Function()? onTap;
  bool isChangeBack = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppDimensions.sixty,
        width: AppDimensions.oneFifty,
        alignment: Alignment.center,
        decoration:  BoxDecoration(
            image: DecorationImage(
                image: Svg(isChangeBack == false ? AssetsBase.smallBack : AssetsBase.buttonBlack), fit: BoxFit.cover)),
        child: Text(
          firstText,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: AppDimensions.sixTeen,
              fontFamily: AppFonts.robotoMedium,
              fontWeight: FontWeight.w500,
              color: Colors.white),
        ),
      ),
    );
  }
}
