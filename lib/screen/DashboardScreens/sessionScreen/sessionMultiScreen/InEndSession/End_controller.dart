// ignore_for_file: file_names, prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:math';

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/model/bandsModel.dart';
import 'package:bandapp/model/sessionDetailModal.dart';
import 'package:bandapp/navigation/app_route_maps.dart';
import 'package:bandapp/network_requests/network_requests.dart';
import 'package:bandapp/screen/DashboardScreens/CycleScreen/cycleScreen_controller.dart';
import 'package:bandapp/screen/DashboardScreens/HomeScreen/homeScreen_controller.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/session_controller.dart';
import 'package:bandapp/screen/DashboardScreens/setUpScreen/setUp_controller.dart';
import 'package:bandapp/utility/sharePrefs/shared_pref_key.dart';
import 'package:bandapp/utility/sharePrefs/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:bandapp/screen/DashboardScreens/Intro_Video/introductionScreens/introduction_controller.dart';
import 'package:bandapp/screen/login/login_welcome.dart';
import 'package:bandapp/utility/Utility.dart';

class EndSessionController extends GetxController {
  var apiClient = ApiClient();
  List<ExerciseVideoList> exerciseVideo = List.empty(growable: true);
  List<ExtraDataList> extraData = List.empty(growable: true);
  List<LastSessionPrepData> endSessionData = List.empty(growable: true);
  TextEditingController notesController = TextEditingController();
  String storeNotes = '', getToken = '', getSessionID = '', fetchCycleID = '',getNameSession = '';

  List<ExerciseTypeInfo> getSessionInfoDataApi = List.empty(growable: true);

  var storeTimerHere;

//speech to text variable
  bool hasSpeech = false;
  bool logEvents = false;
  bool onDevice = false;
  final TextEditingController pauseForController =
      TextEditingController(text: '3');
  final TextEditingController listenForController =
      TextEditingController(text: '30');
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String currentLocaleId = '';
  List<LocaleName> localeNames = [];
  final SpeechToText speech = SpeechToText();

  @override
  void onInit() async {
    initSpeechState();

    SharedPrefs.getString(SharedPrefKeys.token).then((value) {
      if (value != "0") {
        getToken = value;

        print("value has data $getToken");
      }
    });
     SharedPrefs.getString(SharedPrefKeys.cycleID).then((value) {
      if (value.isNotEmpty) {
        fetchCycleID= value;
        print("Value has fetchCycleID $fetchCycleID");
      }
    });
    SharedPrefs.getString(SharedPrefKeys.sessionId).then((value) {
      if (value.isNotEmpty) {
        getSessionID = value;
        getSessionDetailApi(int.parse(value));
      }
    });
    SharedPrefs.getString(SharedPrefKeys.saveTimer).then((value12) {
      storeTimerHere = value12;
      endSessionData.clear();
      endSessionData
          .add(LastSessionPrepData(names: "Session Time", value: value12));
      endSessionData
          .add(LastSessionPrepData(names: "Power increase", value: "+17"));
      update();
    });

    exerciseVideo.clear();
    exerciseVideo.add(ExerciseVideoList(
        exerciseName: "  Straight leg \n  deadlifts", value: 1));
    exerciseVideo
        .add(ExerciseVideoList(exerciseName: "  Chest Press", value: 2));
    exerciseVideo
        .add(ExerciseVideoList(exerciseName: "  Wide grip row", value: 3));
    exerciseVideo
        .add(ExerciseVideoList(exerciseName: "  Shoulder press", value: 4));
    exerciseVideo
        .add(ExerciseVideoList(exerciseName: "  Reverse bicep curl", value: 5));
    exerciseVideo.add(ExerciseVideoList(
        exerciseName: " Overhead \n  tricep extension", value: 6));
    exerciseVideo.add(ExerciseVideoList(
        exerciseName: " Overhead \n  tricep extension", value: 7));
    exerciseVideo.add(ExerciseVideoList(
        exerciseName: " Overhead \n  tricep extension", value: 8));
    exerciseVideo.add(ExerciseVideoList(
        exerciseName: " Overhead \n  tricep extension", value: 9));
    exerciseVideo.add(ExerciseVideoList(
        exerciseName: " Overhead \n  tricep extension", value: 10));

    super.onInit();
    update();
  }

  void getSessionDetailApi(int getSessionId) async {
    var res = await apiClient.getSessionData(
        getID: getSessionId, token: getToken, isLoading: true);

    if (jsonDecode(res.body)['status'] == 1) {
      var data1 = sessionDataFromJson(res.body);
      if (data1.data != null) {
        getNameSession = data1.data!.name!;
        getSessionInfoDataApi = data1.data!.exerciseTypeInfo!;
        for (int i = 0; i < getSessionInfoDataApi.length; i++) {
          if (getSessionInfoDataApi[i].userExcercise != null) {
            if (extraData.isNotEmpty) {
              extraData.clear();
            }
            getSessionInfoDataApi[i].responseDataSession!.add(ResponseSession(
                name: " Band",
                value:getSessionInfoDataApi[i]
                        .userExcercise!
                        .userExcerciseBand!.isEmpty ? "NA": getSessionInfoDataApi[i]
                        .userExcercise!
                        .userExcerciseBand![0]
                        .bandName ??
                    "N/A"));
            getSessionInfoDataApi[i].responseDataSession!.add(ResponseSession(
                name: " POS",
                value:
                    getSessionInfoDataApi[i].userExcercise!.bandPosition == null
                        ? "N/A"
                        : getSessionInfoDataApi[i]
                                .userExcercise!
                                .bandPosition!
                                .position ??
                            ""));
            getSessionInfoDataApi[i].responseDataSession!.add(ResponseSession(
                name: " Time",
                value: getSessionInfoDataApi[i].userExcercise!.time ?? "N/A"));

            getSessionInfoDataApi[i].responseDataSession!.add(ResponseSession(
                name: " Power",
                value: getSessionInfoDataApi[i].userExcercise!.power ?? "N/A"));
          }
        }
        print(extraData.length);
        print(getSessionInfoDataApi.length);
      }
    } else {
      if (jsonDecode(res.body)['message'] == "Unauthenticated.") {
        Utility.showLogoutDialog(
          "Login again!",
          () {
            Navigator.of(Get.context!, rootNavigator: true).pop('dialog');

            SharedPrefs.clear().then((value) {
              Get.delete<SessionController>();
              Get.delete<HomeScreenController>();
              Get.delete<IntroductionController>();
              Get.delete<WeekCycleController>();
              Get.delete<SetUpController>();
              Get.offAll(() => const LoginWelcomeView());
            });
          },
        );
      }
    }
    update();
  }

  void endSessionApi(BuildContext context) async {
    var res = await apiClient.endSessionAPi(
        notes: storeNotes,
        sessionId: int.parse(getSessionID),
        getcycleid: int.parse(fetchCycleID),
        totalTime: storeTimerHere,
        token: getToken,
        isLoading: true);

    if (jsonDecode(res.body)['status'] == 1) {
      Get.delete<HomeScreenController>();
      Get.delete<SessionController>();
      Get.delete<EndSessionController>();
      Get.delete<SetUpController>();
      Get.delete<WeekCycleController>();
      AppRouteMaps.goToDashbaordScreen("");
      notesController.clear();
    } else {
      if (jsonDecode(res.body)['message'] == "Unauthenticated.") {
        Utility.showLogoutDialog(
          "Login again!",
          () {
            Navigator.of(Get.context!, rootNavigator: true).pop('dialog');

            SharedPrefs.clear().then((value) {
              Get.delete<SessionController>();
              Get.delete<HomeScreenController>();
              Get.delete<IntroductionController>();
              Get.delete<WeekCycleController>();
              Get.delete<SetUpController>();
              Get.offAll(() => const LoginWelcomeView());
            });
          },
        );
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text(jsonDecode(res.body)['message'] as String? ?? 'Invalid Data'),
            behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.errorColor,

        duration: const Duration(milliseconds: 1000),
      ));
    }
  }

  //text to speech method

  Future<void> initSpeechState() async {
    logEvent('Initialize');
    try {
      var hasSpeech1 = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: logEvents,
      );
      if (hasSpeech1) {
        // Get the list of languages installed on the supporting platform so they
        // can be displayed in the UI for selection by the user.
        localeNames = await speech.locales();

        var systemLocale = await speech.systemLocale();
        currentLocaleId = systemLocale?.localeId ?? '';
      }

      hasSpeech = hasSpeech1;
    } catch (e) {
      lastError = 'Speech recognition failed: ${e.toString()}';
      hasSpeech = false;
    }
  }

  void logEvent(String eventDescription) {
    if (logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      print('$eventTime $eventDescription');
    }
  }

  void errorListener(SpeechRecognitionError error) {
    logEvent('Received error status: $error, listening: ${speech.isListening}');

    lastError = '${error.errorMsg} - ${error.permanent}';
    update();
  }

  void statusListener(String status) {
    logEvent(
        'Received listener status: $status, listening: ${speech.isListening}');

    lastStatus = status;
    notesController.text = lastWords;
    storeNotes = lastWords;
    print(lastWords);

    update();
  }
 void stopListening() async {
    await speech.stop();
    update();
  }
  void startListening() {
    logEvent('start listening');
    lastWords = '';
    lastError = '';
    final pauseFor = int.tryParse(pauseForController.text);
    final listenFor = int.tryParse(listenForController.text);

    speech.listen(
      onResult: resultListener,
      listenFor: Duration(seconds: listenFor ?? 30),
      pauseFor: Duration(seconds: pauseFor ?? 3),
      partialResults: true,
      localeId: currentLocaleId,
      onSoundLevelChange: soundLevelListener,
      cancelOnError: true,
      listenMode: ListenMode.confirmation,
      onDevice: onDevice,
    );
    update();
  }

  void resultListener(SpeechRecognitionResult result) {
    logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');

    lastWords = result.recognizedWords;
    update();
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');

    this.level = level;
    update();
  }
}
