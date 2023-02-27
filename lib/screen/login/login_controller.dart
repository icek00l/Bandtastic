// ignore_for_file: use_build_context_synchronously

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

    if (!res.hasError) {
      var data = loginFromJson(res.data);
      if (data != null && data.status == true) {
        SharedPrefs.setInteger(SharedPrefKeys.isLoggedIn, 1);
        SharedPrefs.saveStringInPrefs(
            SharedPrefKeys.token, data.result!.token.toString());
        SharedPrefs.saveObject(SharedPrefKeys.userData, (data.result!));

        AppRouteMaps.goToDashbaordScreen("");
      } else if (data.status == false) {
        AppRouteMaps.goToNameScreenPage();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(
              content: Text(
                  jsonDecode(res.data)['message'] as String? ?? 'Invalid Data'),
              duration: const Duration(milliseconds: 2000),
            ))
            .closed
            .then((value) {});
      }
    }
    update();
  }
}
