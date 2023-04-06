// ignore_for_file: file_names

import 'dart:convert';

import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/utility/sharePrefs/shared_pref_key.dart';
import 'package:bandapp/utility/sharePrefs/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String name = '', nameErrorText = '', getName = '';
  bool isNameValid = false;
  String email = '', emailErrorText = '', getEmail = '';
  bool isemailValid = false;

  @override
  void onInit() {
    super.onInit();
    SharedPrefs.getString(SharedPrefKeys.userData).then((value) {
      if (value != "0") {
        var getData = jsonDecode(value);
        nameController.text = getData['title'];
        print("value has data $getData");
      }
    });
    SharedPrefs.getString(SharedPrefKeys.registerData).then((value) {
      if (value !="0") {
        var getData = jsonDecode(value);
        nameController.text = getData['data']['name'];
        emailController.text = getData['data']['email'];
        print("value has data $getData");
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
}
