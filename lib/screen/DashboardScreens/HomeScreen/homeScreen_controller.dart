// ignore_for_file: file_names, avoid_print

import 'dart:convert';

import 'package:bandapp/model/exerciseModel.dart';
import 'package:bandapp/model/graphModel.dart';
import 'package:bandapp/model/homeCycleModal.dart';
import 'package:bandapp/model/homescreenModal.dart';
import 'package:bandapp/model/overallPerformance.dart';
import 'package:bandapp/navigation/app_route_maps.dart';
import 'package:bandapp/network_requests/network_requests.dart';
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
  String getSessionDay = '';
  var apiClient = ApiClient();
  String getToken = '', weekNumberstore = '';
  RxBool isLoading = false.obs;
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

  void getHomeApi() async {
    var res = await apiClient.getHomeData(token: getToken, isLoading: true);

    print(res);
    getWeeklyCycleApi();
    if (jsonDecode(res.body) != null &&
        jsonDecode(res.body)['status'] != false) {
      if (jsonDecode(res.body)["result"] != [] &&
          jsonDecode(res.body)['result'] != null) {
        var data1 = homeDataFromJson(res.body);

        print(data1);
        homeDataList = data1.result!.data!;
        getSessionDay = data1.result!.day!;

        SharedPrefs.saveStringInPrefs(
            SharedPrefKeys.sessionId, data1.result!.data!.id.toString());
        SharedPrefs.saveStringInPrefs(
            SharedPrefKeys.userDay, data1.result!.day.toString());
      }
    } else {
      if (jsonDecode(res.body)['message'] == "Unauthenticated.") {
        SharedPrefs.clear();
        AppRouteMaps.goTowalkthrough();
      }
      print(jsonDecode(res.body)['message']);
    }
    update();
  }

  void getWeeklyCycleApi() async {
    cycleListData.clear();
    var res = await apiClient.weeklyCycleAPi(token: getToken, isLoading: true);

    print(res);
    getOverallPerformanceApi();
    if (jsonDecode(res.body)['status'] == 1) {
      var data1 = cycleDataFromJson(res.body);
      cycleListData = data1.data!;
      weekNumberstore = data1.weekNumber.toString();
    } else {
      if (jsonDecode(res.body)['message'] == "Unauthenticated.") {
        SharedPrefs.clear();
        AppRouteMaps.goToLoginPage(false);
      }
      print("error");
    }
    update();
  }

  void getOverallPerformanceApi() async {
    graphPointList.clear();
    var res =
        await apiClient.overallPerformanceAPi(token: getToken, isLoading: true);

    print(res);
    isLoading.value = true;
    if (jsonDecode(res.body)['status'] == 1) {
      var data1 = overallDataFromJson(res.body);
      graphListData = data1.exerciseData!;

      print("error");
    } else {
      if (jsonDecode(res.body)['message'] == "Unauthenticated.") {
        SharedPrefs.clear();
        AppRouteMaps.goTowalkthrough();
      }
    }
    update();
  }
}
