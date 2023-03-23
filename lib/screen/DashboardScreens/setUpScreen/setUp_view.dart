// ignore_for_file: file_names

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/screen/DashboardScreens/setUpScreen/setUp_controller.dart';
import 'package:bandapp/widgets/buttonBackground.dart';
import 'package:bandapp/widgets/customBackButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class SetUpScreenView extends StatefulWidget {
  const SetUpScreenView({super.key});

  @override
  State<SetUpScreenView> createState() => _SetUpScreenViewState();
}

class _SetUpScreenViewState extends State<SetUpScreenView> {
  var dsh = Get.isRegistered<SetUpController>()
      ? Get.find<SetUpController>()
      : Get.put(SetUpController());

  @override
  Widget build(BuildContext context) => GetBuilder<SetUpController>(
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
                      isBackAllow: false),
                )),
            body: SafeArea(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: AppDimensions.twenty),
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
                                margin:
                                    EdgeInsets.only(left: AppDimensions.twelve),
                                child: Text(
                                  AppStrings.nameText,
                                  textAlign: TextAlign.end,
                                  style: AppThemeStyle.robotoMedium13,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: AppDimensions.twenty3),
                                  child: TextFormField(
                                    controller: controller.nameController,
                                    autofocus: false,
                                    style: AppThemeStyle.blackContainer,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
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
                                            color: AppColors.borderColorThree),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            AppDimensions.zero),
                                        borderSide: const BorderSide(
                                            color: AppColors.borderColorThree),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            AppDimensions.zero),
                                        borderSide: const BorderSide(
                                            color: AppColors.borderColorThree),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            AppDimensions.zero),
                                        borderSide: const BorderSide(
                                            color: AppColors.borderColorThree),
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
                                margin:
                                    EdgeInsets.only(left: AppDimensions.twelve),
                                child: Text(
                                  AppStrings.emailText,
                                  textAlign: TextAlign.end,
                                  style: AppThemeStyle.robotoMedium13,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: AppDimensions.twenty),
                                  height: AppDimensions.forty,
                                  child: TextFormField(
                                    controller: controller.emailController,
                                    autofocus: false,
                                    style: AppThemeStyle.blackContainer,
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
                                            color: AppColors.borderColorThree),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            AppDimensions.zero),
                                        borderSide: const BorderSide(
                                            color: AppColors.borderColorThree),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            AppDimensions.zero),
                                        borderSide: const BorderSide(
                                            color: AppColors.borderColorThree),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            AppDimensions.zero),
                                        borderSide: const BorderSide(
                                            color: AppColors.borderColorThree),
                                      ),

                                      // errorText: controller.emailErrorText,
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
                                    EdgeInsets.only(left: AppDimensions.twelve),
                                child: Text(
                                  "${AppStrings.dayText} 1 ",
                                  textAlign: TextAlign.end,
                                  style: AppThemeStyle.robotoMedium13,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: AppDimensions.twenty),
                                  height: AppDimensions.forty,
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            bottom: AppDimensions.ten,
                                            left: AppDimensions.five),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.zero,
                                          borderSide: BorderSide(
                                              color:
                                                  AppColors.borderColorThree),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.zero,
                                          borderSide: BorderSide(
                                              color:
                                                  AppColors.borderColorThree),
                                        ),
                                        border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.zero,
                                            borderSide: BorderSide(
                                                color: AppColors
                                                    .borderColorThree))),
                                    style: AppThemeStyle.blackContainer,
                                    icon: Visibility(
                                        visible: true,
                                        child: Icon(Icons.arrow_drop_down,
                                            color: AppColors.borderColorThree,
                                            size: AppDimensions.thirty)),
                                    value: "Monday",
                                    iconEnabledColor:
                                        const Color.fromRGBO(76, 73, 73, 0.6),
                                    items: <String>[
                                      'Monday',
                                      'Tuesday',
                                      'Wednesday',
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text("$value   "),
                                      );
                                    }).toList(),
                                    onChanged: (value) {},
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
                                    EdgeInsets.only(left: AppDimensions.twelve),
                                child: Text(
                                  "${AppStrings.dayText} 2 ",
                                  textAlign: TextAlign.end,
                                  style: AppThemeStyle.robotoMedium13,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: AppDimensions.twenty),
                                  height: AppDimensions.forty,
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            bottom: AppDimensions.ten,
                                            left: AppDimensions.five),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.zero,
                                          borderSide: BorderSide(
                                              color:
                                                  AppColors.borderColorThree),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.zero,
                                          borderSide: BorderSide(
                                              color:
                                                  AppColors.borderColorThree),
                                        ),
                                        border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.zero,
                                            borderSide: BorderSide(
                                                color: AppColors
                                                    .borderColorThree))),
                                    style: AppThemeStyle.blackContainer,
                                    icon: Visibility(
                                        visible: true,
                                        child: Icon(Icons.arrow_drop_down,
                                            color: AppColors.borderColorThree,
                                            size: AppDimensions.thirty)),
                                    value: "Wednesday",
                                    iconEnabledColor:
                                        const Color.fromRGBO(76, 73, 73, 0.6),
                                    items: <String>[
                                      'Monday',
                                      'Tuesday',
                                      'Wednesday',
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text("$value   "),
                                      );
                                    }).toList(),
                                    onChanged: (value) {},
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    CenterButtonArrowClass(
                        onTap: (p0) {},
                        buttonText: AppStrings.confirmText),
                    SizedBox(height: AppDimensions.twenty),
                    GestureDetector(
                      onTap: () {},
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
                    SizedBox(height: AppDimensions.fifty),
                  ]),
                ),
              ),
            ),
          ));
}
