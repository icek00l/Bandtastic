import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:bandapp/appstyle/assetbase.dart';
import 'package:bandapp/screen/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>  {
  var dsh = Get.isRegistered<SplashController>()
      ? Get.find<SplashController>()
      : Get.put(SplashController());

  @override
  Widget build(BuildContext context) => GetBuilder<SplashController>(
      builder: (controller) => Scaffold(
              body: 
              Center(
            child: SvgPicture.asset(AssetsBase.bandasticTextSvg,height: AppDimensions.forty,)
            // Text(
            //   AppStrings.appName,
            //   style: TextStyle(
            //       fontSize: AppDimensions.thirty,
            //       fontFamily: 'Poppins',
            //       color: Colors.green.shade600,
            //       fontWeight: FontWeight.w500),
            // ),
          ))
          );
}
