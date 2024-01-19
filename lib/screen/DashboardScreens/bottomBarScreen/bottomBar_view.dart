// ignore_for_file: file_names

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/appstyle/app_strings.dart';
import 'package:bandapp/appstyle/assetbase.dart';
import 'package:bandapp/screen/DashboardScreens/CycleScreen/cycleScreen_controller.dart';
import 'package:bandapp/screen/DashboardScreens/HomeScreen/homeScreen_controller.dart';
import 'package:bandapp/screen/DashboardScreens/HomeScreen/homeScreen_view.dart';
import 'package:bandapp/screen/DashboardScreens/Intro_Video/introductionScreens/introduction_view.dart';
import 'package:bandapp/screen/DashboardScreens/bottomBarScreen/bottomBar_controller.dart';
import 'package:bandapp/screen/DashboardScreens/CycleScreen/cycleScreen_view.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/session_view.dart';
import 'package:bandapp/screen/DashboardScreens/setUpScreen/setUp_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BottomBarView extends StatefulWidget {
  const BottomBarView({super.key});

  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {
  var dsh = Get.isRegistered<BottomBarController>()
      ? Get.find<BottomBarController>()
      : Get.put(BottomBarController());

  @override
  Widget build(BuildContext context) => GetBuilder<BottomBarController>(
      builder: (controller) => Scaffold(
            body: PersistentTabView(
              context,
              controller: controller.tabController,
              screens: _buildScreens(),
              items: _navBarsItems(),
              confineInSafeArea: true,
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              popActionScreens: PopActionScreensType.once,
              onItemSelected: (value) {
                print(value);
                if (value == 2) {
                  final controller1 = Get.put(WeekCycleController());
                  controller1.onInit();
                } else if(value == 0) {
                  final controller2 = Get.put(HomeScreenController());
                  if(controller2.homeDataList.session==null){
                  controller2.getHomeApi();

                  }
                }
              },
              hideNavigationBarWhenKeyboardShows: true,
              decoration: NavBarDecoration(
                  border: Border.all(color: AppColors.borderColorThree)),
              itemAnimationProperties: const ItemAnimationProperties(
                duration: Duration(milliseconds: 200),
                curve: Curves.ease,
              ),
              screenTransitionAnimation: const ScreenTransitionAnimation(
                animateTabTransition: true,
                curve: Curves.ease,
                duration: Duration(milliseconds: 200),
              ),
              navBarStyle: NavBarStyle.style6,
            ),
          ));

  List<Widget> _buildScreens() {
    return [
      const HomeScreenView(),
      const SessionScreenView(),
      const WeekCycleView(),
      const IntroductionView(),
      const SetUpScreenView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AssetsBase.homeIconSvg,
        ),
        inactiveIcon: SvgPicture.asset(
          AssetsBase.homeInActiveSvg,
        ),
        title: AppStrings.homeText,
        activeColorPrimary: AppColors.textButtonColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AssetsBase.sessionIconSvg,
        ),
        inactiveIcon: SvgPicture.asset(
          AssetsBase.sessionInActiveSvg,
        ),
        title: AppStrings.sessionText,
        activeColorPrimary: AppColors.textButtonColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AssetsBase.cycleIconSvg,
        ),
        inactiveIcon: SvgPicture.asset(
          AssetsBase.cycleInActiveSvg,
        ),
        title: AppStrings.cyclesText,
        activeColorPrimary: AppColors.textButtonColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AssetsBase.boxIconSvg,
        ),
        inactiveIcon: SvgPicture.asset(
          AssetsBase.boxInActiveSvg,
        ),
        title: AppStrings.introText,
        activeColorPrimary: AppColors.textButtonColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AssetsBase.settingIconSvg,
        ),
        inactiveIcon: SvgPicture.asset(
          AssetsBase.settingInActiveSvg,
        ),
        title: AppStrings.setupText,
        activeColorPrimary: AppColors.textButtonColor,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }
}
