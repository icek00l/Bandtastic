// ignore_for_file: file_names, avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/model/profileGetModal.dart';
import 'package:bandapp/navigation/app_route_maps.dart';
import 'package:bandapp/network_requests/network_requests.dart';
import 'package:bandapp/utility/sharePrefs/shared_pref_key.dart';
import 'package:bandapp/utility/sharePrefs/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController codeField = TextEditingController();
  String name = '', nameErrorText = '', getName = '';
  bool isNameValid = false;
  String email = '', emailErrorText = '', getEmail = '', getToken = '',firstDay='',secondDay = '';
  bool isemailValid = false;
  bool isCodeChange = false;
  var apiClient = ApiClient();
  bool isLoading = true;
  @override
  void onInit() {
    super.onInit();

    SharedPrefs.getString(SharedPrefKeys.token).then((value) {
      if (value != "0") {
        getToken = value;
        print("value has data $getToken");
        getUserProfileApi();
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
      isLoading = true;

    var res = await apiClient.userEditApi(
        getCode: codeField.text, name: nameController.text, email: emailController.text,firstDay: firstDay,secondDay: secondDay, token: getToken,isLoading: true);

    print(res);

    if (jsonDecode(res.body)['status'] != false) {
      getUserProfileApi();

    } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text(jsonDecode(res.body)['message'] as String? ?? 'Invalid Data'),
        duration: const Duration(milliseconds: 500),
      ));
    }

    update();
  }
  void getUserProfileApi() async {
    isLoading = true;
    var res = await apiClient.getProfileApi(token: getToken, isLoading: true);

    print(res);

    if (jsonDecode(res.body)['status'] == 1) {

      var data1 = profileDataFromJson(res.body);
      nameController.text = data1.data!.name ?? "";
      emailController.text = data1.data!.email ?? "";
      codeField.text = data1.data!.code ?? "";
      firstDay = data1.data!.firstDay ?? "";
      secondDay = data1.data!.secondDay ?? "";
      isLoading = false;

      print(data1);
    } else {
      isLoading = false;
 if (jsonDecode(res.body)['message'] == "Unauthenticated.") {
        SharedPrefs.clear();
        AppRouteMaps.goToLoginPage(false);
      }
    }
    update();
  }
}
