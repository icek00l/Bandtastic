// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/model/bandsModel.dart';
import 'package:bandapp/model/sessionDetailModal.dart';
import 'package:bandapp/navigation/app_route_maps.dart';
import 'package:bandapp/network_requests/network_requests.dart';
import 'package:bandapp/utility/sharePrefs/shared_pref_key.dart';
import 'package:bandapp/utility/sharePrefs/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SessionController extends GetxController
    with GetTickerProviderStateMixin {
  //timer

  static const countdownDuration = Duration(hours: 100);
  Duration durationdf = const Duration(seconds: 0);
  Timer? timer;
  var storeHour;
  var storeMinute;
  var storeSecond;
  var storeTime;
  bool countDown = true;
  int secondsStore = 0;
  String value = '';
  late AnimationController animationController;
  late Animation<double> animation;
  bool isIconChange = true;
  bool endSession = false;
  String buttonName = '';
  String anchorImage = '';
  var apiClient = ApiClient();
  List<BandsModel> bandsList = List.empty(growable: true);
  List<ExerciseVideoList> exerciseVideo = List.empty(growable: true);
  List<ResponseSession> extraData = List.empty(growable: true);

  List<ExerciseTypeInfo> getSessionInfoDataList = List.empty(growable: true);
  String getNameSession = '';
  String getNameDay = '';
  bool isShowVideo = false;
  String getNamehere = '';
  String getNumberhere = '';
  String getFirstVideoUrl = '';
  String getExerVideo = '';
  String getIdhere = '';
  String getToken = '';
  String getSessionID = '';
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

    SharedPrefs.getString(SharedPrefKeys.token).then((value) {
      if (value != "0") {
        getToken = value;

        print("value has data $getToken");
      }
    });
    SharedPrefs.getString(SharedPrefKeys.userDay).then((value) {
      if (value != "0") {
        getNameDay = value;
      }
    });
    SharedPrefs.getString(SharedPrefKeys.sessionId).then((value) {
      if (value.isNotEmpty) {
        getSessionID = value;
        getSessionDetailApi(int.parse(value));
      }
    });
    addListData();
    // reset();
    super.onInit();
  }

// duration
  void reset() {
    if (countDown) {
      durationdf = countdownDuration;
    } else {
      durationdf = const Duration();
    }
    update();
  }

  String formatDuration(Duration? duration) {
    if (duration != null) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');

      String twoDigitsBack(int n) => n.toString().padLeft(2, '0');

      final String twoDigitHours = twoDigits(duration.inHours.remainder(60));

      final String twoDigitMinutes =
          twoDigitsBack(duration.inMinutes.remainder(60));

      final String twoDigitSeconds =
          twoDigitsBack(duration.inSeconds.remainder(60));

      return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
      // }
    }

    return "00:00:00";
  }

  void startTimer() {
    timer ??= Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    secondsStore++;
    durationdf = Duration(seconds: secondsStore);

    update();
  }

  void stopTimer({bool resets = true}) {
    storeHour = durationdf.inHours;
    storeMinute = durationdf.inMinutes;
    storeSecond = durationdf.inSeconds;
    storeTime = "$storeHour:$storeMinute:$storeSecond";
    print(storeHour);
    secondsStore = 0;
    durationdf = const Duration(seconds: 0);
    timer?.cancel();
    update();
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

  void getSessionDetailApi(int getSessionId) async {
    var res = await apiClient.getSessionData(
        getID: getSessionId, token: getToken, isLoading: true);

    print(res);

    if (jsonDecode(res.body)['status'] != false) {
      var data1 = sessionDataFromJson(res.body);
      if (data1.data != null) {
        getNameSession = data1.data!.name!;
        getFirstVideoUrl = data1.data!.video;
        getSessionInfoDataList = data1.data!.exerciseTypeInfo!;
        endSession = data1.data!.sessionComplete!;
        for (int j = 0; j < getSessionInfoDataList.length; j++) {
          if (getSessionInfoDataList[j].isUserExcercise == false) {
            isShowVideo = true;
            anchorImage = getSessionInfoDataList[j].anchor.toString();
            print("get id here ==>${getSessionInfoDataList[j].id}");
            SharedPrefs.saveStringInPrefs(SharedPrefKeys.exerciseTypeID,
                getSessionInfoDataList[j].id.toString());
            buttonName = getSessionInfoDataList[j].name.toString();

            break;
          }
        }
        for (int k = 0; k < getSessionInfoDataList.length; k++) {
          if (getSessionInfoDataList[k].isUserExcercise == true) {
            isShowVideo = false;
            break;
          }
        }

        for (int i = 0; i < getSessionInfoDataList.length; i++) {
          if (getSessionInfoDataList[i].userExcercise != null) {
            if (extraData.isNotEmpty) {
              extraData.clear();
            }
            getSessionInfoDataList[i].responseDataSession!.add(ResponseSession(
                name: " Band",
                value: getSessionInfoDataList[i]
                        .userExcercise!
                        .userExcerciseBand![0]
                        .bandName ??
                    ""));
            getSessionInfoDataList[i].responseDataSession!.add(ResponseSession(
                name: " Position",
                value: getSessionInfoDataList[i]
                        .userExcercise!
                        .bandPosition!
                        .position ??
                    ""));
            getSessionInfoDataList[i].responseDataSession!.add(ResponseSession(
                name: " Reps",
                value: getSessionInfoDataList[i].userExcercise!.reps ?? ""));
            getSessionInfoDataList[i].responseDataSession!.add(ResponseSession(
                name: " Beyond \n  failure",
                value: getSessionInfoDataList[i].userExcercise!.beyondFailure ??
                    ""));
            getSessionInfoDataList[i].responseDataSession!.add(ResponseSession(
                name: " Power",
                value: getSessionInfoDataList[i].userExcercise!.power ?? ""));
          }
        }
        print(getSessionInfoDataList);
      }
    } else {
      if (jsonDecode(res.body)['message'] == "Unauthenticated.") {
        SharedPrefs.clear();
        AppRouteMaps.goTowalkthrough();
      }
    }
    update();
  }

  addListData() {
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
        exerciseName: "  Straight leg \n  deadlifts with bar", value: 1));
    exerciseVideo
        .add(ExerciseVideoList(exerciseName: "  Chest Press", value: 2));
    exerciseVideo
        .add(ExerciseVideoList(exerciseName: "  Wide grip row", value: 3));
    exerciseVideo
        .add(ExerciseVideoList(exerciseName: "  Shoulder press", value: 4));
    exerciseVideo
        .add(ExerciseVideoList(exerciseName: "  Reverse bicep curl", value: 5));
    exerciseVideo.add(ExerciseVideoList(
        exerciseName: "  Overhead \n  tricep extension", value: 6));
    exerciseVideo.add(ExerciseVideoList(
        exerciseName: "  Overhead \n  tricep extension", value: 7));
    exerciseVideo.add(ExerciseVideoList(
        exerciseName: "  Overhead \n  tricep extension", value: 8));
    exerciseVideo.add(ExerciseVideoList(
        exerciseName: "  Overhead \n  tricep extension", value: 9));
    exerciseVideo.add(ExerciseVideoList(
        exerciseName: "  Overhead \n  tricep extension", value: 10));
    exerciseVideo.add(ExerciseVideoList(
        exerciseName: "  Overhead \n  tricep extension", value: 11));
    exerciseVideo.add(ExerciseVideoList(
        exerciseName: "  Overhead \n  tricep extension", value: 12));
    exerciseVideo.add(ExerciseVideoList(
        exerciseName: "  Overhead \n  tricep extension", value: 13));
    exerciseVideo.add(ExerciseVideoList(
        exerciseName: "  Overhead \n  tricep extension", value: 14));
    exerciseVideo.add(ExerciseVideoList(
        exerciseName: "  Overhead \n  tricep extension", value: 15));
    exerciseVideo.add(ExerciseVideoList(
        exerciseName: "  Overhead \n  tricep extension", value: 16));
    update();
  }
}
