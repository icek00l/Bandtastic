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

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) => GetBuilder<SplashController>(
        init: SplashController(),
        builder: (controller) => Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SvgPicture.asset(AssetsBase.splashLogoSvg1),
          ),
        ),
      );
}
