// ignore_for_file: file_names, avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/model/login_Model.dart';
import 'package:bandapp/network_requests/network_requests.dart';
import 'package:bandapp/screen/UserData/emailScreen/email_Verify.dart';
import 'package:bandapp/utility/sharePrefs/shared_pref_key.dart';
import 'package:bandapp/utility/sharePrefs/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailScreenController extends GetxController {
  bool isEmailSelect = false;
  dynamic argumentData = Get.arguments;
  String name = '', emailID = '', emailErrorText = '', email = '';
  dynamic codeBox;
  bool isemailValid = false;
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formemailKey = GlobalKey<FormState>();
  var apiClient = ApiClient();
  @override
  void onInit() async {
    if (argumentData != null) {
      name = argumentData["userName"];
      codeBox = argumentData["codeGet"];
      print(argumentData["userName"]);
      print(argumentData["codeGet"]);
    }

    super.onInit();
  }

  void checkEmail(String emailText) {
    if (emailText.isEmpty) {
      isemailValid = false;
      emailErrorText = AppStrings.emptyEamilFieldText;
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailText)) {
      isemailValid = false;
      emailErrorText = "Enter valid email";
    } else {
      isemailValid = true;
      emailErrorText = "";
    }
    email = emailText;
    update();
  }

  void userRegisterApi(BuildContext context, getCode, getName, getEmail) async {
    var res = await apiClient.userRegister(
        getCode: getCode, name: getName, email: getEmail, isLoading: true);

    if (res.hasError) {
      var data = loginFromJson(res.data);
      if (data.status == true) {
        SharedPrefs.setInteger(SharedPrefKeys.isLoggedIn, 2);
        SharedPrefs.saveStringInPrefs(
            SharedPrefKeys.token, data.result!.token.toString());
        SharedPrefs.saveObject(SharedPrefKeys.userData, (data.result!));
        Get.to(() => const EmailVerifyScreen());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              jsonDecode(res.data)['message'] as String? ?? 'Invalid Data'),
          duration: const Duration(milliseconds: 500),
        ));
      }
    }
    update();
  }
}
