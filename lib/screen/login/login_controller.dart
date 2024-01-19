// ignore_for_file: use_build_context_synchronously, avoid_print, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/model/login_Model.dart';
import 'package:bandapp/navigation/app_route_maps.dart';
import 'package:bandapp/network_requests/network_requests.dart';
import 'package:bandapp/screen/login/login_Code_request.dart';
import 'package:bandapp/utility/sharePrefs/shared_pref_key.dart';
import 'package:bandapp/utility/sharePrefs/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  bool hasError = false;
  final pinController = TextEditingController();
  String otpValue = '';
  var apiClient = ApiClient();
  var argumentData = Get.arguments;
  int count = 0;

  @override
  void onInit() {
    super.onInit();
    if (argumentData != null) {
      print(argumentData["changeBooleanValue"]);
      if (argumentData["changeBooleanValue"] == true) {
        hasError = false;
        count = 0;
      }
    }
  }

  void socialLoginApi(BuildContext context, getCode) async {
    print(getCode);
    String getBoxTypeHere = getCode[0] + getCode[1];
    var getTextNum = getCode[2] +
        getCode[3] +
        getCode[4] +
        getCode[5] +
        getCode[6] +
        getCode[7];
    

    var res;
    if (getBoxTypeHere.isNotEmpty) {
      res = await apiClient.checkUniqueCode(
          getCode: getTextNum, getBoxType: getBoxTypeHere, isLoading: true);
    }
    print("value printed======>${res.body}");

    if (jsonDecode(res.body)['status'] == true) {
      var data1 = loginFromJson(res.body);

      SharedPrefs.saveStringInPrefs(SharedPrefKeys.isLoggedIn, "4");
      SharedPrefs.saveStringInPrefs(
          SharedPrefKeys.token, data1.result!.token.toString());
      SharedPrefs.saveObject(SharedPrefKeys.userData, (data1.result!));
      AppRouteMaps.goToDashbaordScreen("");
    } else if (jsonDecode(res.body)['message'] ==
        "The selected code is invalid.") {
      hasError = true;
      count++;
      print(count);
      if (count == 3) {
        print(count);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginIDrequest()));
        count = 0;
      }
    } else if (jsonDecode(res.body)['message'] == "User Not Found !") {
      SharedPrefs.saveStringInPrefs(SharedPrefKeys.isLoggedIn, "1");
      SharedPrefs.saveStringInPrefs(SharedPrefKeys.saveType, getBoxTypeHere);
      SharedPrefs.saveStringInPrefs(SharedPrefKeys.saveCode, getTextNum);

      AppRouteMaps.goToNameScreenPage();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text(jsonDecode(res.body)['message'] as String? ?? 'Invalid Data'),
         behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.errorColor,

        duration: const Duration(milliseconds: 1000),
      ));
    }

    update();
  }
}
