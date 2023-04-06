import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_fonts.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/appstyle/assetbase.dart';
import 'package:bandapp/navigation/app_route_maps.dart';
import 'package:bandapp/screen/login/login_Code_request.dart';
import 'package:bandapp/screen/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var dsh = Get.isRegistered<LoginController>()
      ? Get.find<LoginController>()
      : Get.put(LoginController());

  @override
  Widget build(BuildContext context) => GetBuilder<LoginController>(
      builder: (controller) => Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    AssetsBase.dummyImage,
                    height: MediaQuery.of(context).size.height / 3.0,
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
                          AppStrings.welcomeText,
                          style: AppThemeStyle.welcomeText400,
                        ),
                        Text(
                          AppStrings.uniqueCodeText,
                          style: AppThemeStyle.bold28Text,
                        ),
                        SizedBox(height: AppDimensions.thirty),
                        Text(
                          AppStrings.cardInsideBox,
                          style: TextStyle(
                              fontSize: AppDimensions.sixTeen,
                              fontFamily: AppFonts.robotoRegular,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryTextColor),
                        ),
                        controller.hasError
                            ? SizedBox(height: AppDimensions.thirty)
                            : Container(),
                        controller.hasError ? errorWidgetMsg() : Container(),
                        SizedBox(height: AppDimensions.thirteen),
                        controller.hasError
                            ? Container()
                            : Row(
                                children: [
                                  Text(
                                    AppStrings.notGetText,
                                    style: TextStyle(
                                        fontSize: AppDimensions.eighteen,
                                        fontFamily: AppFonts.plusSansMedium,
                                        fontWeight: FontWeight.w600,
                                        // letterSpacing: 1.0,
                                        color: Colors.black),
                                  ),
                                  SizedBox(width: AppDimensions.twentyFive),
                                  GestureDetector(
                                    onTap: () {
                                      if (controller.otpValue.isEmpty) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginIDrequest()));
                                      } else {
                                        // AppRouteMaps.goToNameScreenPage();
                                      }
                                    },
                                    child: Text(
                                      AppStrings.buttonTextCheck,
                                      style: AppThemeStyle.greenTextButton500,
                                    ),
                                  ),
                                ],
                              ),
                        SizedBox(height: AppDimensions.twenty),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            AppStrings.uniqueCode,
                            style: AppThemeStyle.secondaryColorText400,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: AppDimensions.fifTeen),
                          child: PinCodeTextField(
                            length: 8,
                            appContext: context,
                            autoFocus: true,

                            obscureText: false,

                            boxShadows: const [
                              BoxShadow(
                                color: AppColors.borderColorTwo,
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset:
                                    Offset(1, 1), // changes position of shadow
                              ),
                            ],
                            textStyle: TextStyle(color: Colors.green.shade600),
                            animationType: AnimationType.scale,

                            pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius:
                                    BorderRadius.circular(AppDimensions.twelve),
                                fieldHeight: AppDimensions.fifty,
                                fieldWidth: AppDimensions.forty,
                                activeFillColor: Colors.white,
                                inactiveFillColor: Colors.white,
                                selectedFillColor: Colors.white,
                                activeColor: Colors.white,
                                selectedColor: Colors.white.withOpacity(0.4),
                                inactiveColor: Colors.white.withOpacity(0.4),
                                borderWidth: 1),
                            animationDuration:
                                const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: TextInputType.number,

                            onChanged: (value) {
                              controller.otpValue = value;
                              controller.update();
                            },
                            onCompleted: (value) {
                              // AppRouteMaps.goToNameScreenPage(value);
                              controller.socialLoginApi(context, value);
                            },
                            onSubmitted: (value) {
                              if (value.isNotEmpty) {
                                // AppRouteMaps.goToNameScreenPage(value);

                                controller.socialLoginApi(context, value);
                              } else {
                                controller.hasError = true;
                                controller.update();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));

  Widget errorWidgetMsg() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.warning_rounded,
          color: AppColors.errorColor,
          size: AppDimensions.fifty,
        ),
        Column(
          children: [
            Text(
              "  That didn’t work ):",
              style: TextStyle(
                  fontSize: AppDimensions.seventeen,
                  fontFamily: AppFonts.robotoFlex,
                  fontWeight: FontWeight.w500,
                  color: AppColors.errorColor),
            ),
            SizedBox(height: AppDimensions.ten),
            Text(
              "Let’s try again?",
              style: TextStyle(
                  fontSize: AppDimensions.fifTeen,
                  fontFamily: AppFonts.robotoFlex,
                  fontWeight: FontWeight.w400,
                  color: AppColors.fiveTextColor),
            ),
          ],
        ),
      ],
    );
  }
}
