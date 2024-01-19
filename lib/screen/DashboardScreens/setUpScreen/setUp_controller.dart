// ignore_for_file: file_names, avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/model/profileGetModal.dart';
import 'package:bandapp/network_requests/network_requests.dart';
import 'package:bandapp/screen/DashboardScreens/HomeScreen/homeScreen_controller.dart';
import 'package:bandapp/utility/Utility.dart';
import 'package:bandapp/utility/sharePrefs/shared_pref_key.dart';
import 'package:bandapp/utility/sharePrefs/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bandapp/screen/DashboardScreens/CycleScreen/cycleScreen_controller.dart';
import 'package:bandapp/screen/DashboardScreens/Intro_Video/introductionScreens/introduction_controller.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/session_controller.dart';
import 'package:bandapp/screen/login/login_welcome.dart';

class SetUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController codeField = TextEditingController();
  String name = '', nameErrorText = '', getName = '';
  bool isNameValid = false;
  String email = '', emailErrorText = '', getEmail = '', getToken = '';
  bool isemailValid = false;
  bool isCodeChange = false;
  var apiClient = ApiClient();
  @override
  void onInit() {
    super.onInit();
    FocusManager.instance.primaryFocus?.unfocus();

    SharedPrefs.getString(SharedPrefKeys.token).then((value) {
      if (value != "0") {
        getToken = value;
        print("value has data $getToken");
        getUserProfileApi(true);
      }
    });

    update();
  }

  void checkName(String nameText) {
    if (nameText.isEmpty) {
      isNameValid = false;
      nameErrorText = AppStrings.emptyNameFieldText;
    } else {
      isNameValid = true;
      nameErrorText = "";
    }
    name = nameText;
    update();
  }

  void checkEmail(String emailText) {
    if (emailText.isEmpty) {
      isemailValid = false;
      emailErrorText = AppStrings.emptyEamilFieldText;
    } else {
      isemailValid = true;
      emailErrorText = "";
    }
    email = emailText;
    update();
  }

  void userUpdateApi(BuildContext context) async {
    var res = await apiClient.userEditApi(
        getCode: codeField.text,
        name: nameController.text,
        email: emailController.text,
        token: getToken,
        isLoading: true);
    FocusManager.instance.primaryFocus?.unfocus();
    if (jsonDecode(res.body)['status'] == true) {
      getUserProfileApi(false);
    } else {
      getUserProfileApi(true);

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

  void getUserProfileApi(isLoad) async {
    var res = await apiClient.getProfileApi(token: getToken, isLoading: true);

    if (jsonDecode(res.body)['status'] == 1) {
      var data1 = profileDataFromJson(res.body);
      nameController.text = data1.data!.name ?? "";
      emailController.text = data1.data!.email ?? "";
      codeField.text = data1.data!.code ?? "";

      if (isLoad == false) {
        Utility.showCommonDialog(
          "Profile updated successfully",
          () {
            Navigator.of(Get.context!, rootNavigator: true).pop('dialog');
          },
        );
      }
      print(data1);
    } else {
      if (jsonDecode(res.body)['message'] == "Unauthenticated.") {
        Utility.showLogoutDialog(
          "Login again!",
          () {
            Navigator.of(Get.context!, rootNavigator: true).pop('dialog');

            SharedPrefs.clear().then((value) {
              Get.delete<SessionController>();
              Get.delete<HomeScreenController>();
              Get.delete<IntroductionController>();
              Get.delete<WeekCycleController>();
              Get.delete<SetUpController>();
              Get.offAll(() => const LoginWelcomeView());
            });
          },
        );
      }
    }
    update();
  }
}
