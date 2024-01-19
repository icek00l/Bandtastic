// ignore_for_file: file_names

import 'dart:convert';

import 'package:bandapp/model/dayreview_modal.dart';
import 'package:bandapp/network_requests/network_requests.dart';
import 'package:bandapp/utility/sharePrefs/shared_pref_key.dart';
import 'package:bandapp/utility/sharePrefs/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bandapp/screen/DashboardScreens/HomeScreen/homeScreen_controller.dart';
import 'package:bandapp/screen/DashboardScreens/setUpScreen/setUp_controller.dart';

import 'package:bandapp/screen/DashboardScreens/CycleScreen/cycleScreen_controller.dart';
import 'package:bandapp/screen/DashboardScreens/Intro_Video/introductionScreens/introduction_controller.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/session_controller.dart';
import 'package:bandapp/screen/login/login_welcome.dart';
import 'package:bandapp/utility/Utility.dart';

class ExerDataController extends GetxController {
  ExerDataController({this.sessionIDGet});
  String? sessionIDGet;
  String getToken = '';
  DayReviewData dayReviewExerData = DayReviewData();
  var apiClient = ApiClient();
  bool isLoading = false;
  @override
  void onInit() async {
    isLoading = true;
    print(sessionIDGet);
    SharedPrefs.getString(SharedPrefKeys.token).then((value) {
      if (value != "0") {
        getToken = value;
        print("value has getToken $getToken");
        dayReviewData(sessionIDGet);
      }
    });

    super.onInit();
  }

  dayReviewData(fetchSessionId) async {
    var res = await apiClient.dayReviewApi(
        sessionId: fetchSessionId, token: getToken, isLoading: true);

    if (jsonDecode(res.body)['status'] == 1) {
      var data1 = dayReviewDataFromJson(res.body);

      dayReviewExerData = data1;
      isLoading = false;
      print(dayReviewExerData);
    } else {
      isLoading = false;
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
