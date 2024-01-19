// ignore_for_file: file_names

import 'dart:convert';

import 'package:bandapp/model/weeklyCycleModal.dart';
import 'package:bandapp/network_requests/network_requests.dart';
import 'package:bandapp/screen/DashboardScreens/HomeScreen/homeScreen_controller.dart';
import 'package:bandapp/screen/DashboardScreens/setUpScreen/setUp_controller.dart';
import 'package:bandapp/utility/Utility.dart';
import 'package:bandapp/utility/sharePrefs/shared_pref_key.dart';
import 'package:bandapp/utility/sharePrefs/shared_prefs.dart';
import 'package:get/get.dart';
import 'package:bandapp/screen/DashboardScreens/CycleScreen/cycleScreen_controller.dart';
import 'package:bandapp/screen/DashboardScreens/Intro_Video/introductionScreens/introduction_controller.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/session_controller.dart';
import 'package:bandapp/screen/login/login_welcome.dart';
import 'package:flutter/material.dart';

class WeekDataController extends GetxController {
  WeeklyCycleModal cycleDataList = WeeklyCycleModal();
  String getToken = '', fetchCycleID = '';
  var apiClient = ApiClient();
  @override
  void onInit() async {
    SharedPrefs.getString(SharedPrefKeys.token).then((value) {
      if (value != "0") {
        getToken = value;

        print("value has getToken $getToken");
      }
    });
    SharedPrefs.getString(SharedPrefKeys.getClickID).then((value) {
      if (value.isNotEmpty) {
        fetchCycleID = value;
        getCycleYearList();
      }
    });

    super.onInit();
  }

  void getCycleYearList() async {
    var res = await apiClient.monthlyCycleAPi(
        cycleIDApi: fetchCycleID, token: getToken, isLoading: true);


    if (jsonDecode(res.body)['status'] == 1) {
      var data1 = weeklyCycleDataFromJson(res.body);

      cycleDataList = data1;
      print(cycleDataList);
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
