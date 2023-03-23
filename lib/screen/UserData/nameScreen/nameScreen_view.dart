// ignore_for_file: file_names, avoid_print

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_fonts.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/navigation/app_route_maps.dart';
import 'package:bandapp/screen/UserData/nameScreen/nameScreen_controller.dart';
import 'package:bandapp/widgets/buttonBackground.dart';
import 'package:bandapp/widgets/customBackButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class NameScreenView extends StatefulWidget {
  const NameScreenView({super.key});

  @override
  State<NameScreenView> createState() => _NameScreenViewState();
}

class _NameScreenViewState extends State<NameScreenView> {
  var dsh = Get.isRegistered<NameScreenController>()
      ? Get.find<NameScreenController>()
      : Get.put(NameScreenController());

  @override
  Widget build(BuildContext context) => GetBuilder<NameScreenController>(
      builder: (controller) => Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: AppDimensions.twenty),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppDimensions.twenty),

                      const CustomWithoutTraining(),
                      SizedBox(height: AppDimensions.oneThirty),
                      // Text(
                      //   AppStrings.tellUsAboutYou,
                      //   style: TextStyle(
                      //       fontFamily: AppFonts.plusSansMedium,
                      //       fontSize: AppDimensions.sixTeen,
                      //       fontWeight: FontWeight.w500,
                      //       letterSpacing: 1.0,
                      //       color: AppColors.primaryTextColor),
                      // ),
                      // SizedBox(height: AppDimensions.ten),
                      Text(
                        AppStrings.whatYourName,
                        style: TextStyle(
                            fontFamily: AppFonts.plusSansRegular,
                            fontSize: AppDimensions.twentyFour,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0,
                            color: Colors.black),
                      ),
                      SizedBox(height: AppDimensions.thirty),
                      Text(
                        AppStrings.yourName,
                        style: TextStyle(
                            fontFamily: AppFonts.robotoRegular,
                            fontSize: AppDimensions.sixTeen,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.0,
                            color: AppColors.secondaryTextColor),
                      ),
                      SizedBox(height: AppDimensions.twenty),
                      TextFormField(
                        controller: controller.nameController,
                        autofocus: true,
                        style: TextStyle(
                          fontSize: AppDimensions.sixTeen,
                          fontWeight: FontWeight.w500,
                        ),
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              top: AppDimensions.ten,
                              right: AppDimensions.five,
                              bottom: AppDimensions.ten),
                          isDense: true,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.textformColor),

                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.textformColor),
                          ),
                          focusedErrorBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.textformColor),
                          ),
                          border: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.textformColor),
                          ),
                          
                          errorText: controller.nameErrorText,
                          errorStyle: TextStyle(
                              color: AppColors.errorColor,
                              fontSize: AppDimensions.thirteen),
                        ),
                        onChanged: (String value) {
                          controller.checkName(value);
                          controller.getName = value;
                        },
                        onFieldSubmitted: (value) {
                          if(value.isNotEmpty) {
                            print(controller.getName);
                            AppRouteMaps.goToEmailScreenPage(
                                  controller.getName,controller.getCode);
                          } 
                        },

                      ),
                      ButtonCommonArrowClass(
                          onTap: (p0) {
                            print(controller.getName);
                            if (controller.getName.isNotEmpty) {
                              AppRouteMaps.goToEmailScreenPage(
                                  controller.getName,controller.getCode);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: AppColors.buttonColor,
                                content: Text(
                                  "Please Enter your name",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: AppDimensions.forteen),
                                ),
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(milliseconds: 500),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppDimensions.ten)),
                              ));
                            }
                          },
                          buttonText: AppStrings.confirmText,isMargin: false),
                     
                      SizedBox(height: AppDimensions.forty),
                    ],
                  ),
                ),
              ),
            ),
          ));
}
