// ignore_for_file: file_names, avoid_print

import 'dart:convert';

import 'package:bandapp/model/weekModel.dart';
import 'package:bandapp/navigation/app_route_maps.dart';
import 'package:bandapp/network_requests/network_requests.dart';
import 'package:bandapp/utility/sharePrefs/shared_pref_key.dart';
import 'package:bandapp/utility/sharePrefs/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectDayScreenController extends GetxController {
  List<AddWeekModel> weekList = List.empty(growable: true);
  int count = 0;
  var apiClient = ApiClient();
  String getFirstDay = '';
  List getNameList = [];
  String getSecondDay = '';
  String getUserID = '';
  String getToken = '';
  @override
  void onInit() async {
    super.onInit();
    SharedPrefs.getString(SharedPrefKeys.userID).then((value) {
      print(value);
      if (value.isNotEmpty) {
        getUserID = value;
      }
    });
    SharedPrefs.getString(SharedPrefKeys.token).then((value) {
      if (value != "0") {
        getToken = value;
        print("value has data $getToken");
      }
    });
    weekList.clear();
    weekList.add(
        AddWeekModel(name: "Sunday", isSelectedWeek: false, isVisible: true));
    weekList.add(
        AddWeekModel(name: "Monday", isSelectedWeek: false, isVisible: true));
    weekList.add(
        AddWeekModel(name: "Tuesday", isSelectedWeek: false, isVisible: true));
    weekList.add(AddWeekModel(
        name: "Wednesday", isSelectedWeek: false, isVisible: true));
    weekList.add(
        AddWeekModel(name: "Thursday", isSelectedWeek: false, isVisible: true));
    weekList.add(
        AddWeekModel(name: "Friday", isSelectedWeek: false, isVisible: true));
    weekList.add(
        AddWeekModel(name: "Saturday", isSelectedWeek: false, isVisible: true));
  }

  void userSelectDayApi(
      BuildContext context, getFirstName, getSecondName) async {
    print(getUserID);

    var res = await apiClient.userSelectDay(
        firstDay: getFirstName,
        secondDay: getSecondName,
        token: getToken,
        isLoading: true);

    if (jsonDecode(res.body)['status'] != false) {
      SharedPrefs.saveStringInPrefs(SharedPrefKeys.isLoggedIn, "4");

      AppRouteMaps.goToDashbaordScreen("1");
    } else {
      print(res.body);
    }
    update();
  }
}
