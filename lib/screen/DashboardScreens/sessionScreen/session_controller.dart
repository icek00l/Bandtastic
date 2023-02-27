import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/model/bandsModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SessionController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  bool isIconChange = true;

  List<BandsModel> bandsList = List.empty(growable: true);
  List<ExerciseVideoList> exerciseVideo = List.empty(growable: true);
  List<ExtraDataList> extraData = List.empty(growable: true);

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

    bandsList.clear();
    bandsList.add(BandsModel(
      bandName: "2x",
      colorName: "Green",
      colorValue: AppColors.buttonColor,
    ));
    bandsList.add(BandsModel(
      bandName: "1x",
      colorName: "Purple",
      colorValue: Colors.purple,
    ));
    bandsList.add(BandsModel(
      bandName: "2x",
      colorName: "Black",
      colorValue: Colors.black,
    ));
    bandsList.add(BandsModel(
      bandName: "2x",
      colorName: "Red",
      colorValue: Colors.red,
    ));
    bandsList.add(BandsModel(
      bandName: "2x",
      colorName: "Yellow",
      colorValue: Colors.yellow,
    ));
    exerciseVideo.clear();
    exerciseVideo.add(ExerciseVideoList(
        exerciseName: "Straight leg \ndeadlifts", value: 1));
    exerciseVideo.add(ExerciseVideoList(exerciseName: "Chest Press", value: 2));
    exerciseVideo
        .add(ExerciseVideoList(exerciseName: "Wide grip row", value: 3));
    exerciseVideo
        .add(ExerciseVideoList(exerciseName: "Shoulder press", value: 4));
    exerciseVideo
        .add(ExerciseVideoList(exerciseName: "Reverse bicep curl", value: 5));
    exerciseVideo.add(ExerciseVideoList(
        exerciseName: "Overhead \ntricep extension", value: 6));

         extraData.clear();
    extraData.add(ExtraDataList(
        name: "Band", value: "gr"));
    extraData.add(ExtraDataList(name: "Position", value: "2"));
    extraData
        .add(ExtraDataList(name: "Reps", value: "11"));
    extraData
        .add(ExtraDataList(name: "Beyond failure", value: "3"));
    extraData
        .add(ExtraDataList(name: "Power", value: "+3"));
    
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
