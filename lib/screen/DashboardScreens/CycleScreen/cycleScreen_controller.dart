// ignore_for_file: file_names

import 'dart:convert';

import 'package:bandapp/model/cycleModel.dart';
import 'package:bandapp/model/yearlyCycleModal.dart';
import 'package:bandapp/navigation/app_route_maps.dart';
import 'package:bandapp/network_requests/network_requests.dart';
import 'package:bandapp/utility/sharePrefs/shared_pref_key.dart';
import 'package:bandapp/utility/sharePrefs/shared_prefs.dart';
import 'package:get/get.dart';

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
    cycleDataList.clear();
    cycleDataList.add(CycleModel(exerName: "LEGS", value: "+12"));
    cycleDataList.add(CycleModel(exerName: "CHESTS", value: "+12"));
    cycleDataList.add(CycleModel(exerName: "BACK", value: "+12"));
    cycleDataList.add(CycleModel(exerName: "SHOULDERS", value: "+12"));
    cycleDataList.add(CycleModel(exerName: "BICEPS", value: "+12"));
    cycleDataList.add(CycleModel(exerName: "TRICEPS", value: "+12"));

    super.onInit();
  }

  void getCycleYearList() async {
        isLoading = true;

    yearlyCycleList.clear();
    var res = await apiClient.yearlyCycleAPi(token: getToken, isLoading: true);

    print(res);

    if (jsonDecode(res.body)['status'] != false) {
      var data1 = cycleYearDataFromJson(res.body);

      yearlyCycleList = data1.yearlyData!;
        isLoading = false;

      print(yearlyCycleList);
    } else {
        isLoading = false;

       if (jsonDecode(res.body)['message'] == "Unauthenticated.") {
        SharedPrefs.clear();
        AppRouteMaps.goTowalkthrough();
      }
    }
    update();
  }
}
