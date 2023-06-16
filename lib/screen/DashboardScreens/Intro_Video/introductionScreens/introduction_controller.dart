// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bandapp/model/introductionModel.dart';
import 'package:bandapp/network_requests/network_requests.dart';
import 'package:bandapp/utility/sharePrefs/shared_pref_key.dart';
import 'package:bandapp/utility/sharePrefs/shared_prefs.dart';
import 'package:get/get.dart';
class IntroductionController extends GetxController
     {
  List<IntroData> introGetDataList = List.empty(growable: true);
  var apiClient = ApiClient();
  String getToken = '';
  bool isIconChange = true;
  @override
  void onInit() async {
   
   
   
    SharedPrefs.getString(SharedPrefKeys.token).then((value) {
      if (value != "0") {
        getToken = value;
        getIntroApi();
        print("value has data $getToken");
      }
    });
    super.onInit();
  }


  void getIntroApi() async {
    var res = await apiClient.getIntroData(token: getToken, isLoading: true);

    print(res);

    if (jsonDecode(res.body)['status'] != 0) {
      var data1 = introDataFromJson(res.body);

      print(data1);
      introGetDataList = data1.result!;
       SharedPrefs.saveStringInPrefs(
            SharedPrefKeys.sessionId, data1.sessionID.toString());
        SharedPrefs.saveStringInPrefs(
            SharedPrefKeys.userDay, data1.day.toString());
      print(introGetDataList);
    } else {}

    update();
  }
}
