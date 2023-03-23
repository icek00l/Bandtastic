// ignore_for_file: file_names

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_strings.dart';
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

  /// Close any open dialog.
  static void closeDialog() {
   if(Get.isDialogOpen ?? false) Get.back<void>();
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
            )
        ),
      ),
    );
  }

}
