// ignore_for_file: file_names

import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/app_fonts.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/assetbase.dart';
import 'package:bandapp/navigation/app_route_maps.dart';
import 'package:bandapp/screen/welcomeScreen/welcomeScreen_controller.dart';
import 'package:bandapp/widgets/buttonBackground.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class WelcomeScreenView extends StatefulWidget {
  const WelcomeScreenView({super.key});

  @override
  State<WelcomeScreenView> createState() => _WelcomeScreenViewState();
}

class _WelcomeScreenViewState extends State<WelcomeScreenView> {
  var dsh = Get.isRegistered<WelcomeController>()
      ? Get.find<WelcomeController>()
      : Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) => GetBuilder<WelcomeController>(
      builder: (controller) => Scaffold(
            body: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  AssetsBase.modalImageWelcome,
                ),
                fit: BoxFit.fill,
              )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // VideoPlayer(controller.videoController)

                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(
                          left: AppDimensions.hunDred,
                          top: AppDimensions.twohunDred),
                      child: Row(
                        children: [
                          Text(
                            "Super",
                            style: TextStyle(
                                fontSize: AppDimensions.forty7,
                                fontFamily: AppFonts.plusSansRegular,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.5,
                                color: Colors.white),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: AppDimensions.ten),
                            child: Text(
                              "!",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: AppDimensions.forty7,
                                  fontFamily: AppFonts.notoSerif,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.5,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ButtonCommonArrowClass(onTap: (p0) {
                          AppRouteMaps.goToTrainingScreenPage();
                    
                  }, buttonText: AppStrings.letGetGo,isMargin: true),
                  

                  SizedBox(height: AppDimensions.forty),
                ],
              ),
            ),
          ));
}
