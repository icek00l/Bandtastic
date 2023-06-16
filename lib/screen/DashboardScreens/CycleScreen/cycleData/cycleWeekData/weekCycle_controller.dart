// ignore_for_file: file_names

import 'dart:convert';

import 'package:bandapp/model/cycleModel.dart';
import 'package:bandapp/navigation/app_route_maps.dart';
import 'package:bandapp/network_requests/network_requests.dart';
import 'package:bandapp/utility/sharePrefs/shared_pref_key.dart';
import 'package:bandapp/utility/sharePrefs/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeekDataController extends GetxController {
  List<CycleModel> cycleDataList = List.empty(growable: true);
  List<WeekName> weekNameList = List.empty(growable: true);
String getToken = '',firstDate= '',endDate = '';
var apiClient = ApiClient();
  @override
  void onInit() async {

     SharedPrefs.getString(SharedPrefKeys.token).then((value) {
      if (value != "0") {
        getToken = value;
        print("value has getToken $getToken");

      }
    }); SharedPrefs.getString(SharedPrefKeys.firstDate).then((value) {
      if (value != "0") {
        firstDate= value;

        print("value has datafirstDate $firstDate");
      }
    }); SharedPrefs.getString(SharedPrefKeys.secondDate).then((value) {
      if (value != "0") {
        endDate = value;
getCycleYearList();
        print("value has dataendDate $endDate");
      }
    });
    cycleDataList.clear();
    cycleDataList.add(
        CycleModel(exerName: "Stiff leg deadlifts", value: "+12"));
    cycleDataList.add(CycleModel(exerName: "Chest Press", value: "+12"));
    cycleDataList.add(CycleModel(exerName: "Wide grip row", value: "+12"));
    cycleDataList.add(CycleModel(exerName: "Shoulder press", value: "+12"));
    cycleDataList.add(CycleModel(exerName: "Reverse bicep curl", value: "+12"));
    cycleDataList
        .add(CycleModel(exerName: "Overhead tricep extension", value: "+12"));
    weekNameList.clear();

    super.onInit();
  }

  void getCycleYearList() async {
    var res = await apiClient.monthlyCycleAPi(startDate:firstDate ,endDate: endDate,token: getToken, isLoading: true);

    print(res);

    if (jsonDecode(res.body)['status'] != false) {
      // var data1 = cycleYearDataFromJson(res.body);

      // yearlyCycleList = data1.yearlyData!;
      // print(yearlyCycleList);
    } else {
       if (jsonDecode(res.body)['message'] == "Unauthenticated.") {
        SharedPrefs.clear();
        AppRouteMaps.goTowalkthrough();
      }
    }
    update();
  }
  
}
