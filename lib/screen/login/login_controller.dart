// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:bandapp/model/login_Model.dart';
import 'package:bandapp/navigation/app_route_maps.dart';
import 'package:bandapp/network_requests/network_requests.dart';
import 'package:bandapp/utility/sharePrefs/shared_pref_key.dart';
import 'package:bandapp/utility/sharePrefs/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  bool hasError = false;
  final pinController = TextEditingController();
  String otpValue = '';
  var apiClient = ApiClient();

  void socialLoginApi(BuildContext context, getCode) async {
    var res =
        await apiClient.checkUniqueCode(getCode: getCode, isLoading: true);
    print(res);
    if (res.hasError) {
      var data = loginFromJson(res.data);
      if (data.status == true) {
        SharedPrefs.setInteger(SharedPrefKeys.isLoggedIn, 4);
        SharedPrefs.saveStringInPrefs(
            SharedPrefKeys.token, data.result!.token.toString());
        SharedPrefs.saveObject(SharedPrefKeys.userData, (data.result!));
        AppRouteMaps.goToDashbaordScreen("");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              jsonDecode(res.data)['message'] as String? ?? 'Invalid Data'),
          duration: const Duration(milliseconds: 500),
        ));
      }
    } else {
      if (jsonDecode(res.data)['message'] == "The selected code is invalid.") {
        hasError = true;
      } else if (jsonDecode(res.data)['message'] == "User Not Found !") {
        SharedPrefs.setInteger(SharedPrefKeys.isLoggedIn, 1);

        AppRouteMaps.goToNameScreenPage(getCode);
      }
    }
    update();
  }
}
