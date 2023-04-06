// ignore_for_file: file_names

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_fonts.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/appstyle/assetbase.dart';
import 'package:bandapp/navigation/app_route_maps.dart';
import 'package:bandapp/screen/UserData/emailScreen/emailScreen_controller.dart';
import 'package:bandapp/utility/sharePrefs/shared_pref_key.dart';
import 'package:bandapp/utility/sharePrefs/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class EmailVerifyScreen extends StatefulWidget {
  const EmailVerifyScreen({super.key});

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen>
     {
  var dsh = Get.isRegistered<EmailScreenController>()
      ? Get.find<EmailScreenController>()
      : Get.put(EmailScreenController());

  @override
  Widget build(BuildContext context) => GetBuilder<EmailScreenController>(
        builder: (controller) => Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Image.asset(
            AssetsBase.dummyImage,
            height: MediaQuery.of(context).size.height / 2.4,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            margin: EdgeInsets.only(
                left: AppDimensions.forteen,
                right: AppDimensions.twenty,
                top: AppDimensions.ten),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.checkInbox,
                    style: AppThemeStyle.bold28Text,
                  ),
                  SizedBox(height: AppDimensions.twelve),
                  Text(
                    AppStrings.descriptionText,
                    style: AppThemeStyle.descriptionText300,
                  ),
                  SizedBox(height: AppDimensions.twenty),
                  Text(
                    AppStrings.descriptionText,
                    style: AppThemeStyle.descriptionText300,
                  ),
                  SizedBox(height: AppDimensions.twenty),
                  Text(
                    AppStrings.emailNotReceive,
                    style: AppThemeStyle.descriptionText300,
                  ),
                ]),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                onPressed: () {
                  SharedPrefs.saveStringInPrefs(SharedPrefKeys.isLoggedIn, "3");
                  AppRouteMaps.goToWelcomeScreenPage();
                },
                child: Text(
                  AppStrings.reEnteremail,
                  
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                      fontSize: AppDimensions.eighteen,
                      fontFamily: AppFonts.robotoFlex,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.0,
                      color: AppColors.textButtonColor),
                ),
              ),
            ),
          ),
          SizedBox(height: AppDimensions.forty)
            ],
          ),
        ),
      );
}
