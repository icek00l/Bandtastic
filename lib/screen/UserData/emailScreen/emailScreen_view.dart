// ignore_for_file: file_names, avoid_print

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_fonts.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/screen/UserData/emailScreen/emailScreen_controller.dart';
import 'package:bandapp/widgets/buttonBackground.dart';
import 'package:bandapp/widgets/customBackButton.dart';
import 'package:bandapp/widgets/custom_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class EmailScreenView extends StatefulWidget {
  const EmailScreenView({super.key});

  @override
  State<EmailScreenView> createState() => _EmailScreenViewState();
}

class _EmailScreenViewState extends State<EmailScreenView> {
  var dsh = Get.isRegistered<EmailScreenController>()
      ? Get.find<EmailScreenController>()
      : Get.put(EmailScreenController());

  @override
  Widget build(BuildContext context) => GetBuilder<EmailScreenController>(
      builder: (controller) => Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: AppDimensions.twenty),
                child: Form(
                  key: controller.formemailKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppDimensions.twenty),
                       CustomWithoutTraining(
                        navigateBack: () {
      Navigator.pop(context);
                          
                        },
                       ),
                      SizedBox(height: AppDimensions.fifty),

                      Text(
                        controller.name.isNotEmpty
                            ? "Hi ${controller.name}"
                            : "Hi Embad,",
                        style: TextStyle(
                            fontFamily: AppFonts.plusSansBold,
                            fontSize: AppDimensions.twentyEight,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.0,
                            color: Colors.black),
                      ),
                      // SizedBox(height: AppDimensions.twentyTwo),
                      // Text(
                      //   AppStrings.oneMoreThing,
                      //   style: TextStyle(
                      //       fontFamily: AppFonts.plusSansMedium,
                      //       fontSize: AppDimensions.sixTeen,
                      //       fontWeight: FontWeight.w500,
                      //       letterSpacing: 1.0,
                      //       color: AppColors.primaryTextColor),
                      // ),
                      SizedBox(height: AppDimensions.fifty),
                      Text(
                        AppStrings.whatYourEmail,
                        style: TextStyle(
                            fontFamily: AppFonts.plusSansRegular,
                            fontSize: AppDimensions.twentyFour,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0,
                            color: Colors.black),
                      ),
                      // SizedBox(height: AppDimensions.twentyFour),
                      // Text(
                      //   AppStrings.reachYouWay,
                      //   style: TextStyle(
                      //       fontFamily: AppFonts.robotoRegular,
                      //       fontSize: AppDimensions.sixTeen,
                      //       fontWeight: FontWeight.w400,
                      //       letterSpacing: 1.0,
                      //       color: AppColors.secondaryTextColor),
                      // ),
                      SizedBox(height: AppDimensions.fifty),
                      TextFormField(
                        controller: controller.emailController,
                        autofocus: true,
                        style: TextStyle(
                          fontSize: AppDimensions.sixTeen,
                          fontWeight: FontWeight.w500,
                        ),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.emailAddress,
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
                          errorText: controller.emailErrorText,
                          errorStyle: TextStyle(
                              color: AppColors.errorColor,
                              fontSize: AppDimensions.thirteen),
                        ),
                        onChanged: (String value) {
                          controller.checkEmail(value);
                          controller.emailID = value;
                        },
                        onFieldSubmitted: (value) {
                          print("value");
                          if (value.isNotEmpty) {
                             if (controller.emailID.isNotEmpty &&
                                RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(controller.emailID) &&
                                controller.isEmailSelect == true) {
                             controller.userRegisterApi(context,controller.name,value);
                            }
                          }
                        },
                      ),
                      SizedBox(height: AppDimensions.fifTeen),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomCheckBox(
                            selected: controller.isEmailSelect,
                            size: AppDimensions.thirty,
                            onPressed: () {
                              controller.isEmailSelect =
                                  !controller.isEmailSelect;
                              controller.update();
                            },
                          ),
                          SizedBox(width: AppDimensions.ten),
                          Expanded(
                              child: Text(
                            AppStrings.checkBoxText,
                            maxLines: 4,
                            style: TextStyle(
                                fontFamily: AppFonts.robotoRegular,
                                fontSize: AppDimensions.sixTeen,
                                fontWeight: FontWeight.w300,
                                height: 1.4,
                                letterSpacing: 0.6,
                                color: AppColors.secondaryTextColor),
                          )),
                        ],
                      ),

                      ButtonCommonArrowClass(isMargin: false,
                          onTap: (p0) {
                            if (controller.emailID.isNotEmpty &&
                                RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(controller.emailID) &&
                                controller.isEmailSelect == true) {

                             controller.userRegisterApi(context,controller.name,controller.email);

                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: AppColors.buttonColor,
                                content: Text(
                                  "Please fill all details",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: AppDimensions.forteen),
                                ),
                                duration: const Duration(milliseconds: 500),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppDimensions.ten)),
                              ));
                            }
                          },
                          buttonText: AppStrings.confirmText,
                          ),

                      SizedBox(height: AppDimensions.forty),
                    ],
                  ),
                ),
              ),
            ),
          ));
}
