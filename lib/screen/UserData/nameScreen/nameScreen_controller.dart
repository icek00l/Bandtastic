// ignore_for_file: file_names

import 'package:bandapp/appstyle/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NameScreenController extends GetxController {
final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  String name='',nameErrorText = '',getName='';
  bool isNameValid =false;
 
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
