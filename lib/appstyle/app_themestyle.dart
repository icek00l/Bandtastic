import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_fonts.dart';
import 'package:flutter/material.dart';

abstract class AppThemeStyle {
  static TextStyle headingAppBar18 = TextStyle(
      fontSize: AppDimensions.eighteen,
      fontFamily: AppFonts.plusSansBold,
      fontWeight: FontWeight.w800,
      color: Colors.black);

  static TextStyle heading24Bold = TextStyle(
      fontSize: AppDimensions.twentyFour,
      fontFamily: AppFonts.plusSansBold,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.0,
      color: AppColors.secondaryTextColor);
  static TextStyle heading28Bold = TextStyle(
      fontSize: AppDimensions.twentyEight,
      fontFamily: AppFonts.plusSansBold,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
      color: AppColors.secondaryTextColor);

  static TextStyle welcomeText400 = TextStyle(
      fontSize: AppDimensions.sixTeen,
      fontFamily: AppFonts.plusSansMedium,
      fontWeight: FontWeight.w500,
      letterSpacing: 3.0,
      color: AppColors.primaryTextColor);

  static TextStyle descriptionText300 = TextStyle(
      fontSize: AppDimensions.sixTeen,
      fontFamily: AppFonts.robotoRegular,
      fontWeight: FontWeight.w400,
      height: 1.4,
      color: AppColors.secondaryTextColor);

  static TextStyle whiteTextButton500 = TextStyle(
      fontSize: AppDimensions.sixTeen,
      fontFamily: AppFonts.robotoMedium,
      fontWeight: FontWeight.w500,
      color: Colors.white);
  static TextStyle greenTextButton500 = TextStyle(
      fontSize: AppDimensions.eighteen,
      fontFamily: AppFonts.plusSansMedium,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.underline,
      color: AppColors.textButtonColor);
  static TextStyle whiteTextButtoneight = TextStyle(
      fontSize: AppDimensions.eighteen,
      fontFamily: AppFonts.robotoFlex,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.0,
      color: Colors.white);

  static TextStyle greenTextButtoneight = TextStyle(
      fontSize: AppDimensions.sixTeen,
      fontFamily: AppFonts.robotoFlex,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.0,
      color: AppColors.greenTextColor);

  static TextStyle blackTextButton400 = TextStyle(
      fontSize: AppDimensions.sixTeen,
      fontFamily: AppFonts.robotoRegular,
      fontWeight: FontWeight.w300,
      height: 1.4,
      letterSpacing: 1.0,
      color: Colors.black);

  static TextStyle robotoregular16 =   TextStyle(
                    fontSize: AppDimensions.sixTeen,
                    fontFamily: AppFonts.robotoFlex,
                    fontWeight: FontWeight.w400,
                    color: Colors.black);

  static TextStyle bold28Text = TextStyle(
      fontSize: AppDimensions.twentyEight,
      fontFamily: AppFonts.plusSansBold,
      fontWeight: FontWeight.bold,
      color: Colors.black);

  static TextStyle secondaryColorText400 = TextStyle(
      fontSize: AppDimensions.twenty,
      letterSpacing: 1.8,
      fontFamily: AppFonts.plusSansMedium,
      fontWeight: FontWeight.w400,
      color: AppColors.secondaryTextColor);
  static TextStyle trainingText = TextStyle(
      fontSize: AppDimensions.sixTeen,
      letterSpacing: 2.0,
      fontFamily: AppFonts.plusSansRegular,
      fontWeight: FontWeight.bold,
      color: Colors.black);

  static TextStyle regular13Size = TextStyle(
      fontSize: AppDimensions.thirteen,
      letterSpacing: 1.0,
      fontFamily: AppFonts.plusSansRegular,
      fontWeight: FontWeight.w500,
      color: Colors.black);

  static TextStyle fifteenBoldRoboto = TextStyle(
      fontSize: AppDimensions.fifTeen,
      letterSpacing: 1.0,
      fontFamily: AppFonts.robotoFlex,
      fontWeight: FontWeight.bold,
      color: AppColors.fourTextColor);

  static TextStyle fifteenMediumRoboto = TextStyle(
      fontSize: AppDimensions.fifTeen,
      letterSpacing: 1.0,
      fontFamily: AppFonts.robotoMedium,
      fontWeight: FontWeight.w500,
      color: AppColors.secondaryTextColor);

  static TextStyle eightBlackBoldRoboto = TextStyle(
      fontSize: AppDimensions.eighteen,
      fontFamily: AppFonts.robotoBold,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.0,
      color: Colors.black);

  static TextStyle robotoMedium13 = TextStyle(
      fontSize: AppDimensions.thirteen,
      fontFamily: AppFonts.robotoMedium,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.0,
      color: AppColors.thirdTextColor);

  static TextStyle robotoflex11 = TextStyle(
      fontSize: AppDimensions.eleven,
      fontFamily: AppFonts.robotoFlex,
      fontWeight: FontWeight.w400,
      color: Colors.white);

  static TextStyle robotoflex12bold = TextStyle(
      fontSize: AppDimensions.twelve,
      fontFamily: AppFonts.robotoFlex,
      fontWeight: FontWeight.bold,
      color: Colors.white);
      static TextStyle robotovblackflex12bold = TextStyle(
      fontSize: AppDimensions.twelve,
      fontFamily: AppFonts.robotoFlex,
      letterSpacing: 1.0,
      fontWeight: FontWeight.bold,
      color: Colors.black);

  static TextStyle robotoflex13Medium = TextStyle(
    fontSize: AppDimensions.thirteen,
    fontFamily: AppFonts.robotoFlex,
    fontWeight: FontWeight.w500,
  );

  static TextStyle introDataCommon = TextStyle(
      fontSize: AppDimensions.twentyTwo,
      wordSpacing: 1.0,
      fontFamily: AppFonts.plusSansMedium,
      fontWeight: FontWeight.w600,
      color: Colors.black);

  static TextStyle semi22Bold = TextStyle(
      fontSize: AppDimensions.twentyTwo,
      fontFamily: AppFonts.plusSansMedium,
      fontWeight: FontWeight.w600,
      color: AppColors.secondaryTextColor);

  static TextStyle robotoflex16 = TextStyle(
      fontSize: AppDimensions.sixTeen,
      fontFamily: AppFonts.robotoFlex,
      letterSpacing: 0.5,
      decoration: TextDecoration.underline,
      fontWeight: FontWeight.w400,
      color: Colors.black);

  static TextStyle bandProgess = TextStyle(
      fontSize: AppDimensions.sixTeen,
      fontFamily: AppFonts.plusSansBold,
      fontWeight: FontWeight.bold,
      color: AppColors.secondaryTextColor);

  static TextStyle cycleContainer = TextStyle(
      fontSize: AppDimensions.forteen,
      fontFamily: AppFonts.robotoFlex,
      fontWeight: FontWeight.w600,
      color: Colors.white);

      static TextStyle blackContainer = TextStyle(
      fontSize: AppDimensions.forteen,
      fontFamily: AppFonts.robotoFlex,
      fontWeight: FontWeight.w300,
      color: Colors.black);

  static TextStyle semiBold13 = TextStyle(
      fontSize: AppDimensions.thirteen,
      fontFamily: AppFonts.robotoFlex,
      letterSpacing: 1.0,
      wordSpacing: 1.0,
      fontWeight: FontWeight.w600,
      color: AppColors.text7Color);

  static TextStyle extraBold18 = TextStyle(
      fontSize: AppDimensions.eighteen,
      fontFamily: AppFonts.plusSansExtraBold,
      letterSpacing: 0.5,
      fontWeight: FontWeight.w800,
      color: AppColors.text7Color);


   static TextStyle bold24=   TextStyle(
                                fontSize: AppDimensions.twentyFour,
                                fontFamily: AppFonts.plusSansBold,
                                fontWeight: FontWeight.bold,
                                color: AppColors.buttonColor);
}
