// ignore_for_file: file_names

import 'package:bandapp/appstyle/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetUpController extends GetxController {
final GlobalKey<FormState> formKey = GlobalKey<FormState>();

TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
 String name='',nameErrorText = '',getName='';
  bool isNameValid =false;
  String email = '',emailErrorText = '',getEmail = '';
  bool isemailValid = false;
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
