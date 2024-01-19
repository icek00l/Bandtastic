// ignore_for_file: file_names

import 'dart:convert';

import 'package:bandapp/model/cycleModel.dart';
import 'package:bandapp/model/yearlyCycleModal.dart';
import 'package:bandapp/network_requests/network_requests.dart';
import 'package:bandapp/screen/DashboardScreens/HomeScreen/homeScreen_controller.dart';
import 'package:bandapp/screen/DashboardScreens/setUpScreen/setUp_controller.dart';
import 'package:bandapp/utility/Utility.dart';
import 'package:bandapp/utility/sharePrefs/shared_pref_key.dart';
import 'package:bandapp/utility/sharePrefs/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bandapp/screen/DashboardScreens/Intro_Video/introductionScreens/introduction_controller.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/session_controller.dart';
import 'package:bandapp/screen/login/login_welcome.dart';

class WeekCycleController extends GetxController {
  List<CycleModel> cycleDataList = List.empty(growable: true);
  List<YearlyData> yearlyCycleList = List.empty(growable: true);
  String getToken = '';
  bool isLoading = false;
  var apiClient = ApiClient();
  @override
  void onInit() async {
    SharedPrefs.getString(SharedPrefKeys.token).then((value) {
      if (value != "0") {
        getToken = value;
        isLoading = true;
        print("value has data $getToken");
        getCycleYearList();
      }
    });

    super.onInit();
  }

  void getCycleYearList() async {
    isLoading = true;

    yearlyCycleList.clear();
    var res = await apiClient.yearlyCycleAPi(token: getToken, isLoading: true);

    if (jsonDecode(res.body)['status'] == 1) {
      var data1 = cycleYearDataFromJson(res.body);

      yearlyCycleList = data1.yearlyData!;
      isLoading = false;
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
