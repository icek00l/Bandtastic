// ignore_for_file: file_names

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_fonts.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/app_themestyle.dart';
import 'package:bandapp/appstyle/assetbase.dart';
import 'package:bandapp/navigation/app_route_maps.dart';
import 'package:bandapp/screen/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginIDrequest extends StatefulWidget {
  const LoginIDrequest({super.key});

  @override
  State<LoginIDrequest> createState() => _LoginIDrequestState();
}

class _LoginIDrequestState extends State<LoginIDrequest> {
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
                  Stack(
                    children: [
                      Image.asset(
                        AssetsBase.dummyImage,
                        height: MediaQuery.of(context).size.height / 2.4,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                          top: AppDimensions.forty,
                          child: MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Image(
                                height: AppDimensions.thirty,
                                image: const Svg(AssetsBase.backButtonSvg),
                              )))
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: AppDimensions.forteen,
                        right: AppDimensions.twenty,
                        top: AppDimensions.ten),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: AppDimensions.thirty),
                        errorWidgetMsg(),
                        SizedBox(height: AppDimensions.thirty),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            AppStrings.codeRequestdescText,
                            style: AppThemeStyle.blackTextButton400,
                          ),
                        ),
                        SizedBox(height: AppDimensions.ten),
                        SizedBox(height: AppDimensions.five),
                        GestureDetector(
                          onTap: () async {
                            String email =
                                Uri.encodeComponent("code.support@bandtasticbodies.com");
                            String subject =
                                Uri.encodeComponent("Bandtastic help support");
                            String body = Uri.encodeComponent(
                                "Hi! I'm Flutter Developer");
                            Uri mail = Uri.parse(
                                "mailto:$email?subject=$subject&body=$body");
                            if (await launchUrl(mail)) {
                              //email app opened
                              print("email app opened");
                            } else {
                              //email app is not opened
                              print("email app is not opened");
                            }
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "code.support@bandtasticbodies.com",
                              style: TextStyle(
                                fontFamily: AppFonts.robotoFlex,
                                fontWeight: FontWeight.w500,
                                fontSize: AppDimensions.eighteen,
                                color: AppColors.greenTextColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: AppDimensions.sixty),
                        GestureDetector(
                          onTap: () {
                            AppRouteMaps.goToLoginPage(true);
                          },
                          child: Container(
                            width: double.infinity,
                            height: AppDimensions.fifty,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: Svg(AssetsBase.buttonBackAll),
                                    fit: BoxFit.cover)),
                            child: Text(
                              AppStrings.buttonRetryCode,
                              style: AppThemeStyle.whiteTextButton500,
                            ),
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
        SizedBox(width: AppDimensions.ten),
        Text(
          "That didn’t work either ):",
          style: TextStyle(
              fontSize: AppDimensions.twenty,
              fontFamily: AppFonts.robotoFlex,
              fontWeight: FontWeight.w400,
              color: AppColors.errorColor),
        ),
      ],
    );
  }
}
