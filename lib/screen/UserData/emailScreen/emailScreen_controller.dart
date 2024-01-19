// ignore_for_file: file_names, avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/model/registerModel.dart';
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
  dynamic codeType;
  bool isemailValid = false;
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formemailKey = GlobalKey<FormState>();
  var apiClient = ApiClient();
  @override
  void onInit() async {
    SharedPrefs.getString(SharedPrefKeys.saveCode).then((value) {
codeBox = value;
    });
     SharedPrefs.getString(SharedPrefKeys.saveType).then((value) {
      codeType = value;
    });
    if (argumentData != null) {
      name = argumentData["userName"];
      print(argumentData["userName"]);
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

  void userRegisterApi(BuildContext context,  getName, getEmail) async {
    var res = await apiClient.userRegister(
        getCode: codeBox,getType:codeType , name: getName, email: getEmail, isLoading: true);

    if (jsonDecode(res.body)['status'] == true) {
      var data1 = registerFromJson(res.body);
      print(data1);
      SharedPrefs.saveStringInPrefs(SharedPrefKeys.isLoggedIn, "2");
      SharedPrefs.saveStringInPrefs(
          SharedPrefKeys.token, data1.result!.token.toString());
      SharedPrefs.saveObject(SharedPrefKeys.registerData, (data1.result!));
      SharedPrefs.saveObject(SharedPrefKeys.userID, (data1.result!.data!.id));

      Get.to(() => const EmailVerifyScreen());
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
