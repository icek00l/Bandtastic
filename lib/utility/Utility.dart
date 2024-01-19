// ignore_for_file: file_names

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_fonts.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class Utility {
  /// Show loader
  static void showLoader() async {
    closeDialog();
    await Get.dialog<void>(
      WillPopScope(
        onWillPop: () async => false,
        child: Align(
            alignment: Alignment.center,
            child: Card(
              elevation: 4,
              color: Colors.transparent,
              child: Padding(
                padding: AppDimensions.padding10,
                child: Wrap(
                  children: [
                    SizedBox(
                      width: AppDimensions.fiftyFive,
                      height: AppDimensions.fiftyFive,
                      child: SpinKitCircle(
                        color: AppColors.buttonColor,
                        size: AppDimensions.fifty,
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
      barrierDismissible: true,
    );
  }
//storee name
static String storeName ='';
static String storeTotalSession ='';
  /// Close any open dialog.
  static void closeDialog() {
    if (Get.isDialogOpen ?? false) Get.back<void>();
  }

  static void printILog(String message) {
    Logger().i('${AppStrings.appName}: $message');
  }

  static void printLog(dynamic message) {
    Logger().log(Level.info, message);
  }

  /// Returns true if the internet connection is available.
  static Future<bool> isNetworkAvailable() async =>
      await InternetConnectionChecker().hasConnection;
  static void onLoading() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        child: Center(
            child: Card(
          elevation: 4,
          color: Colors.transparent,
          child: Padding(
            padding: AppDimensions.padding10,
            child: Wrap(
              children: [
                SizedBox(
                  width: AppDimensions.fiftyFive,
                  height: AppDimensions.fiftyFive,
                  child: SpinKitCircle(
                    color: AppColors.buttonColor,
                    size: AppDimensions.fifty,
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  static showCommonDialog(title, VoidCallback onTap) {
    Get.defaultDialog(
        barrierDismissible: true,
        backgroundColor: AppColors.backgColorOne,
        title: "",
        titlePadding: EdgeInsets.zero,
        contentPadding:
            EdgeInsets.symmetric(horizontal: AppDimensions.twentyEight),
        content: Column(
          children: [
            SizedBox(height: AppDimensions.ten),
            Container(
              alignment: Alignment.center,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: AppThemeStyle.greenTextButtoneight,
              ),
            ),
            SizedBox(height: AppDimensions.thirty),
            GestureDetector(
              onTap:onTap,
              child: Container(
                alignment: Alignment.center,
                height: AppDimensions.forty,
                width: AppDimensions.oneFifty5,
                decoration: BoxDecoration(
                    color: AppColors.greenTextColor,
                    borderRadius: BorderRadius.circular(AppDimensions.five)),
                child: Text(
                  "Close",
                  style: TextStyle(
                      fontSize: AppDimensions.sixTeen,
                      fontFamily: AppFonts.robotoMedium,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: AppDimensions.twenty),
          ],
        ));
  }

  static showLogoutDialog(title,VoidCallback onTap) {
    Get.defaultDialog(
        barrierDismissible: true,
        backgroundColor: AppColors.backgColorOne,
        title: "",
        titlePadding: EdgeInsets.zero,
        contentPadding:
            EdgeInsets.symmetric(horizontal: AppDimensions.twentyEight),
        content: Column(
          children: [
            SizedBox(height: AppDimensions.ten),
            Container(
              alignment: Alignment.center,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: AppThemeStyle.greenTextButtoneight,
              ),
            ),
            SizedBox(height: AppDimensions.thirty),
            GestureDetector(
              onTap: onTap,
              child: Container(
                alignment: Alignment.center,
                height: AppDimensions.forty,
                width: AppDimensions.oneFifty5,
                decoration: BoxDecoration(
                    color: AppColors.greenTextColor,
                    borderRadius: BorderRadius.circular(AppDimensions.five)),
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontSize: AppDimensions.sixTeen,
                      fontFamily: AppFonts.robotoMedium,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: AppDimensions.twenty),
          ],
        ));
  }


  static showYesNoCommonDialog(
      title, VoidCallback closeTap, VoidCallback yesTap) {
    Get.defaultDialog(
        barrierDismissible: true,
        backgroundColor: AppColors.backgColorOne,
        title: "",
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.symmetric(horizontal: AppDimensions.sixTeen),
        content: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: AppThemeStyle.greenTextButtoneight,
              ),
            ),
            SizedBox(height: AppDimensions.twentyFour),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: closeTap,
                  color: AppColors.errorColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimensions.five)),
                  height: AppDimensions.forty,
                  child: Text(
                    "No",
                    style: TextStyle(
                        fontSize: AppDimensions.sixTeen,
                        fontFamily: AppFonts.robotoMedium,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
                SizedBox(width: AppDimensions.ten),
                MaterialButton(
                  onPressed: yesTap,
                  color: AppColors.greenTextColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimensions.five)),
                  height: AppDimensions.forty,
                  child: Text(
                    "Yes",
                    style: TextStyle(
                        fontSize: AppDimensions.sixTeen,
                        fontFamily: AppFonts.robotoMedium,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.sixTeen),
          ],
        ));
  }
}
