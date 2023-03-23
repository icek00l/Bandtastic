// ignore_for_file: file_names

import 'package:bandapp/appstyle/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';


class WalkThroughController extends GetxController {

    int courrentIndex=0;
 late PageController pageController;
  @override
  void onInit() async {
   pageController=PageController(initialPage: 0);

    super.onInit();
  }
   @override
     void dispose() {
    pageController.dispose();
    super.dispose();
  }

  InkWell buildDot(
    int index, BuildContext context, WalkThroughController controller) {
  return InkWell(
    onTap: () {
      controller.pageController.nextPage(
          duration: const Duration(milliseconds: 1000), curve: Curves.linearToEaseOut);
    },
    child: Container(
      height: AppDimensions.forteen,
      width: controller.courrentIndex == index
          ? AppDimensions.fifty
          : AppDimensions.forteen,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: controller.courrentIndex == index
            ? Colors.green.shade600
            : Colors.grey,
      ),
    ),
  );
}

}
