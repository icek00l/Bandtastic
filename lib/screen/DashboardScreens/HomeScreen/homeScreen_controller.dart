// ignore_for_file: file_names, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:bandapp/model/exerciseModel.dart';
import 'package:bandapp/model/homeCycleModal.dart';
import 'package:bandapp/model/homescreenModal.dart';
import 'package:bandapp/model/overallPerformance.dart';
import 'package:bandapp/network_requests/network_requests.dart';
import 'package:bandapp/screen/DashboardScreens/CycleScreen/cycleScreen_controller.dart';
import 'package:bandapp/screen/DashboardScreens/Intro_Video/introductionScreens/introduction_controller.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/session_controller.dart';
import 'package:bandapp/screen/DashboardScreens/setUpScreen/setUp_controller.dart';
import 'package:bandapp/utility/Utility.dart';
import 'package:bandapp/screen/login/login_welcome.dart';
import 'package:bandapp/utility/sharePrefs/shared_pref_key.dart';
import 'package:bandapp/utility/sharePrefs/shared_prefs.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  List<AddExerciseModel> exerciseList = List.empty(growable: true);
  List<CycleHomeData> cycleListData = List.empty(growable: true);
  List<ExerciseData> graphListData = List.empty(growable: true);
  HomeDataType homeDataList = HomeDataType();
  List<ExerciseInfo> exerciseTypeData = List.empty(growable: true);
  List<GraphData> graphPointList = List.empty(growable: true);
  var apiClient = ApiClient();
  String getToken = '', weekNumberstore = '';
  RxBool isLoading = false.obs;
  bool isShowGraph = false;
  @override
  void onInit() async {
    SharedPrefs.getString(SharedPrefKeys.token).then((value) {
      if (value != "0") {
        getToken = value;
        getHomeApi();
        print("value has data $getToken");
      }
    });

    super.onInit();
  }

  getHomeApi() async {
    var res = await apiClient.getHomeData(token: getToken, isLoading: true);
    if (jsonDecode(res.body)['status'] == true) {
      var data1 = homeDataFromJson(res.body);

      if (data1.result != null) {
        SharedPrefs.saveStringInPrefs(
            SharedPrefKeys.cycleID, data1.result!.id.toString());
        getWeeklyCycleApi(
            data1.result!.session!.id.toString(), data1.result!.id.toString());
        await SharedPrefs.saveStringInPrefs(
                SharedPrefKeys.sessionId, data1.result!.session!.id.toString())
            .then((value) {
          update();
          
          homeDataList = data1.result!;
        });
      }
    } else if (jsonDecode(res.body)['status'] == false) {
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
    } else {}
    print(jsonDecode(res.body)['message']);
    update();
  }

  getWeeklyCycleApi(sessionGetID, cycleID) async {
    cycleListData.clear();
    var res = await apiClient.weeklyCycleAPi(
        token: getToken,
        sessionID: sessionGetID,
        cycleID: cycleID,
        isLoading: true);

    getOverallPerformanceApi(sessionGetID);
    if (jsonDecode(res.body)['status'] == 1) {
      var data1 = cycleDataFromJson(res.body);
      cycleListData = data1.data!;
      weekNumberstore = data1.weekNumber.toString();
      Utility.storeName = '';
      Utility.storeTotalSession = '';
      Utility.storeTotalSession = data1.dailySessionNumber.toString();
      Utility.storeName = "Session ${data1.dailySessionNumber.toString()}";
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
      print("error");
    }
    update();
  }

  getOverallPerformanceApi(sessionID) async {
    graphPointList.clear();
    var res = await apiClient.overallPerformanceAPi(
        sessionID: sessionID, token: getToken, isLoading: true);

    isLoading.value = true;
    if (jsonDecode(res.body)['status'] == 1) {
      var data1 = overallDataFromJson(res.body);
      graphListData = data1.exerciseData!;
    } else {
      print("error");

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
