
import 'package:bandapp/model/bandsModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroductionController extends GetxController with GetSingleTickerProviderStateMixin{
  late AnimationController animationController;
  late Animation<double> animation;
  List<IntroDataModel> introList = List.empty(growable: true);

  bool isIconChange = true;
  @override
  void onInit() async {
    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.fastLinearToSlowEaseIn,
    );
    introList.add(IntroDataModel(names: "Which band do I use?"));
    introList.add(IntroDataModel(names: "Chest Press"));
    introList.add(IntroDataModel(names: "Wide grip row"));
    introList.add(IntroDataModel(names: "Shoulder press"));
    introList.add(IntroDataModel(names: "Reverse bicep curl"));
    introList.add(IntroDataModel(names: "Overhead tricep extension"));
     super.onInit();
  }

  toggleContainer() {
    if (animation.status != AnimationStatus.completed) {
      animationController.forward();

      isIconChange = false;
      update();
    } else {
      animationController
          .animateBack(0, duration: const Duration(milliseconds: 600))
          .then((value) {
        isIconChange = true;
        update();
      });
    }
  }
  
}
