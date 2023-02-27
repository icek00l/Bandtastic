// ignore_for_file: file_names, avoid_print

import 'package:bandapp/appstyle/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailScreenController extends GetxController {
  bool isEmailSelect = false;
  dynamic argumentData = Get.arguments;
  String name = '', emailID = '', emailErrorText = '', email = '';
  bool isemailValid = false;
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formemailKey = GlobalKey<FormState>();

  @override
  void onInit() async {
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
}
