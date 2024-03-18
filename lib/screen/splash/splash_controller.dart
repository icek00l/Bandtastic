// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bandapp/model/generalDatamodel.dart';
import 'package:bandapp/navigation/app_route_maps.dart';
import 'package:bandapp/network_requests/network_requests.dart';
import 'package:bandapp/screen/DashboardScreens/CycleScreen/cycleScreen_controller.dart';
import 'package:bandapp/screen/DashboardScreens/HomeScreen/homeScreen_controller.dart';
import 'package:bandapp/screen/DashboardScreens/Intro_Video/introductionScreens/introduction_controller.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/session_controller.dart';
import 'package:bandapp/screen/DashboardScreens/setUpScreen/setUp_controller.dart';
import 'package:bandapp/screen/UserData/emailScreen/email_Verify.dart';
import 'package:bandapp/screen/login/login_welcome.dart';
import 'package:bandapp/utility/Utility.dart';
import 'package:bandapp/utility/sharePrefs/shared_pref_key.dart';
import 'package:bandapp/utility/sharePrefs/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  var apiClient = ApiClient();
  String getToken = '';
  bool isLoading = false;

  @override
  void onInit() async {
    SharedPrefs.getString(SharedPrefKeys.token).then((value) {
      getToken = value;

      if (getToken.isEmpty) {
        generalDataSave();
      } else {
        generalDataSave();
      }
    });
    SharedPrefs.getString(SharedPrefKeys.isLoggedIn).then((value) {
      print(value);
      if (value == "1") {
        SharedPrefs.getString(SharedPrefKeys.saveCode).then((value) {
          if (value.isNotEmpty) {
            var getCode = value;
            print(getCode);
            AppRouteMaps.goToNameScreenPage();
          }
        });
      } else if (value == "2") {
        Get.to(() => const EmailVerifyScreen());
      } else if (value == "3") {
        AppRouteMaps.goToWelcomeScreenPage();
      } else if (value == "4") {
        AppRouteMaps.goToDashbaordScreen("");
      } else {
        Future.delayed(
          const Duration(
            seconds: 2,
          ),
          () {
            AppRouteMaps.goTowalkthrough();
          },
        );
      }
    });

    super.onInit();
  }

  generalDataSave() async {
    isLoading = true;

    var res = await apiClient.getGeneralDataApi(
        token: getToken.isEmpty ? "" : getToken, isLoading: false);

    if (jsonDecode(res.body)['status'] == 1) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      Map<String, dynamic> decodedata = json.decode(res.body);
      String user = jsonEncode(GeneralDataModel.fromJson(decodedata));
      preferences.setString('generalData', user);
    } else {

      if (jsonDecode(res.body)['message'] == "Unauthenticated.") {
        Utility.showLogoutDialog(
          "Login again!",
          () {
            Navigator.of(Get.context!, rootNavigator: true).pop('dialog');

            SharedPrefs.clear().then((value) {
              Get.delete<SessionController>();
              Get.delete<HomeScreenController>();
              Get.delete<IntroductionController>();
              Get.delete<WeekCycleController>();
              Get.delete<SetUpController>();
              Get.offAll(() => const LoginWelcomeView());
            });
          },
        );
      }
    }
    update();
  }

}
