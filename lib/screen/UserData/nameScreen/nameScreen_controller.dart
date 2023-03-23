// ignore_for_file: file_names, avoid_print

import 'package:bandapp/appstyle/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NameScreenController extends GetxController {
final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  String name='',nameErrorText = '',getName='';
  dynamic getCode;
  bool isNameValid =false;
  dynamic argumentData = Get.arguments;

 @override
  void onInit() {
 if (argumentData != null) {
      getCode = argumentData["boxCode"];
      print(argumentData["boxCode"]);
    }

  super.onInit();
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
 
  
}
