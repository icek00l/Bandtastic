// ignore_for_file: file_names, avoid_print

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/navigation/app_route_maps.dart';
import 'package:bandapp/screen/DashboardScreens/CycleScreen/cycleScreen_controller.dart';
import 'package:bandapp/screen/DashboardScreens/HomeScreen/homeScreen_controller.dart';
import 'package:bandapp/screen/DashboardScreens/Intro_Video/introductionScreens/introduction_controller.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/session_controller.dart';
import 'package:bandapp/screen/DashboardScreens/setUpScreen/setUp_controller.dart';
import 'package:bandapp/screen/login/login_welcome.dart';
import 'package:bandapp/utility/sharePrefs/shared_prefs.dart';
import 'package:bandapp/widgets/buttonBackground.dart';
import 'package:bandapp/widgets/customBackButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetUpScreenView extends StatefulWidget {
  const SetUpScreenView({super.key});

  @override
  State<SetUpScreenView> createState() => _SetUpScreenViewState();
}

class _SetUpScreenViewState extends State<SetUpScreenView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SetUpController>(
        init: SetUpController(),
        builder: (controller) => Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(
                      AppDimensions.seventy), // here the desired height
                  child: AppBar(
                    backgroundColor: Colors.white,
                    elevation: AppDimensions.zero,
                    title: CustomWithTextHeader(
                      getHeadingText: AppStrings.setupAPpText,
                      isBackAllow: false,
                      navigateBack: () {
                        Navigator.pop(context);
                      },
                    ),
                  )),
              body: SafeArea(
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: AppDimensions.twenty),
                  child: Form(
                    key: controller.formKey,
                    child: Column(children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: AppDimensions.twelve),
                                  child: Text(
                                    AppStrings.nameText,
                                    textAlign: TextAlign.end,
                                    style: AppThemeStyle.robotoMedium13,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: AppDimensions.forty),
                                    child: TextFormField(
                                      controller: controller.nameController,
                                      autofocus: false,
                                      style: AppThemeStyle.blackContainer,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.name,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "This field is required";
                                        }  else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: AppDimensions.ten,
                                            left: AppDimensions.five,
                                            bottom: AppDimensions.ten),
                                        isDense: true,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppDimensions.zero),
                                          borderSide: const BorderSide(
                                              color:
                                                  AppColors.borderColorThree),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppDimensions.zero),
                                          borderSide: const BorderSide(
                                              color:
                                                  AppColors.borderColorThree),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppDimensions.zero),
                                          borderSide: const BorderSide(
                                              color:
                                                  AppColors.borderColorThree),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppDimensions.zero),
                                          borderSide: const BorderSide(
                                              color:
                                                  AppColors.borderColorThree),
                                        ),
                                        errorStyle: TextStyle(
                                            color: AppColors.errorColor,
                                            fontSize: AppDimensions.thirteen),
                                      ),
                                      onChanged: (String value) {
                                        controller.checkName(value);
                                        controller.getName = value;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: AppDimensions.fifTeen),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: AppDimensions.twelve),
                                  child: Text(
                                    AppStrings.emailText,
                                    textAlign: TextAlign.end,
                                    style: AppThemeStyle.robotoMedium13,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: AppDimensions.thirtyeight),
                                    child: TextFormField(
                                      controller: controller.emailController,
                                      autofocus: false,
                                      style: AppThemeStyle.blackContainer,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        String patttern =
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                                        RegExp regExp = RegExp(patttern);
                                        if (value!.isEmpty) {
                                          return "This field is required";
                                        } else if (!regExp.hasMatch(value)) {
                                          return "Please enter valid email";
                                        } else {
                                          return null;
                                        }
                                      },
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: AppDimensions.ten,
                                            left: AppDimensions.five,
                                            bottom: AppDimensions.ten),
                                        isDense: true,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppDimensions.zero),
                                          borderSide: const BorderSide(
                                              color:
                                                  AppColors.borderColorThree),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppDimensions.zero),
                                          borderSide: const BorderSide(
                                              color:
                                                  AppColors.borderColorThree),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppDimensions.zero),
                                          borderSide: const BorderSide(
                                              color:
                                                  AppColors.borderColorThree),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppDimensions.zero),
                                          borderSide: const BorderSide(
                                              color:
                                                  AppColors.borderColorThree),
                                        ),
                                        errorStyle: TextStyle(
                                            color: AppColors.errorColor,
                                            fontSize: AppDimensions.thirteen),
                                      ),
                                      onChanged: (String value) {
                                        controller.checkEmail(value);
                                        controller.getEmail = value;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: AppDimensions.fifTeen),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.only(left: AppDimensions.five),
                                  child: Text(
                                    "UNIQUE \nCODE",
                                    textAlign: TextAlign.start,
                                    style: AppThemeStyle.robotoMedium13,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          left: AppDimensions.thirty2),
                                      height: AppDimensions.forty,
                                      child:
                                          // controller.isCodeChange ==
                                          //         false
                                          //     ?
                                          Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                AppDimensions.one),
                                            border: Border.all(
                                                color:
                                                    AppColors.borderColorThree),
                                            color: AppColors.borderColorThree),
                                        height: AppDimensions.forty,
                                        padding: EdgeInsets.only(
                                            top: AppDimensions.nine,
                                            left: AppDimensions.five,
                                            bottom: AppDimensions.eight),
                                        child: Text(controller.codeField.text,
                                            style: AppThemeStyle.blackContainer
                                                .copyWith(
                                                    fontSize:
                                                        AppDimensions.sixTeen)),
                                      )
                                      // : TextFormField(
                                      //     controller:
                                      //         controller.codeField,
                                      //     autofocus: true,
                                      //     readOnly: false,
                                      //     style: AppThemeStyle
                                      //         .blackContainer,
                                      //     textInputAction:
                                      //         TextInputAction.done,
                                      //     keyboardType: TextInputType
                                      //         .emailAddress,
                                      //     decoration: InputDecoration(
                                      //       contentPadding:
                                      //           EdgeInsets.only(
                                      //               top: AppDimensions
                                      //                   .ten,
                                      //               left: AppDimensions
                                      //                   .five,
                                      //               bottom:
                                      //                   AppDimensions
                                      //                       .ten),
                                      //       enabledBorder:
                                      //           OutlineInputBorder(
                                      //         borderRadius:
                                      //             BorderRadius.circular(
                                      //                 AppDimensions
                                      //                     .zero),
                                      //         borderSide: const BorderSide(
                                      //             color: AppColors
                                      //                 .borderColorThree),
                                      //       ),
                                      //       focusedBorder:
                                      //           OutlineInputBorder(
                                      //         borderRadius:
                                      //             BorderRadius.circular(
                                      //                 AppDimensions
                                      //                     .zero),
                                      //         borderSide: const BorderSide(
                                      //             color: AppColors
                                      //                 .borderColorThree),
                                      //       ),
                                      //       focusedErrorBorder:
                                      //           OutlineInputBorder(
                                      //         borderRadius:
                                      //             BorderRadius.circular(
                                      //                 AppDimensions
                                      //                     .zero),
                                      //         borderSide: const BorderSide(
                                      //             color: AppColors
                                      //                 .borderColorThree),
                                      //       ),
                                      //       border: OutlineInputBorder(
                                      //         borderRadius:
                                      //             BorderRadius.circular(
                                      //                 AppDimensions
                                      //                     .zero),
                                      //         borderSide: const BorderSide(
                                      //             color: AppColors
                                      //                 .borderColorThree),
                                      //       ),

                                      //       // errorText: controller.emailErrorText,
                                      //       errorStyle: TextStyle(
                                      //           color: AppColors
                                      //               .errorColor,
                                      //           fontSize: AppDimensions
                                      //               .thirteen),
                                      //     ),
                                      //     onChanged: (String value) {},
                                      //   ),

                                      ),
                                ),
                                // GestureDetector(
                                //   onTap: () {
                                //     if (controller.isCodeChange == true) {
                                //       controller.isCodeChange = false;
                                //     } else {
                                //       controller.isCodeChange = true;
                                //     }
                                //     controller.update();
                                //   },
                                //   child: Text(
                                //     controller.isCodeChange == false
                                //         ? "Change"
                                //         : "Cancel",
                                //     style: TextStyle(
                                //         fontSize: AppDimensions.sixTeen,
                                //         fontFamily: AppFonts.robotoMedium,
                                //         fontWeight: FontWeight.w500,
                                //         decoration:
                                //             TextDecoration.underline,
                                //         color: AppColors.buttonColor),
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      CenterButtonArrowClass(
                          onTap: (p0) {
                            if (controller.formKey.currentState!.validate()) {
                              controller.userUpdateApi(context);
                            }
                          },
                          buttonText: AppStrings.confirmText),
                      SizedBox(height: AppDimensions.twenty),
                      GestureDetector(
                        onTap: () async {
                          controller.onInit();
                          AppRouteMaps.goToDashbaordScreen("0");
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            AppStrings.cancelText,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: AppDimensions.seventeen,
                                fontWeight: FontWeight.bold,
                                color: AppColors.buttonColor),
                          ),
                        ),
                      ),
                      SizedBox(height: AppDimensions.twenty),
                      GestureDetector(
                        onTap: () {
                          SharedPrefs.clear().then((value) {
                            Get.delete<SessionController>();
                            Get.delete<HomeScreenController>();
                            Get.delete<IntroductionController>();
                            Get.delete<WeekCycleController>();
                            Get.delete<SetUpController>();
                            Get.offAll(() => const LoginWelcomeView());
                          });
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Logout",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: AppDimensions.seventeen,
                                fontWeight: FontWeight.bold,
                                color: AppColors.buttonColor),
                          ),
                        ),
                      ),
                      SizedBox(height: AppDimensions.twenty),
                    ]),
                  ),
                ),
              ),
            ));
  }
}
