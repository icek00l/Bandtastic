// ignore_for_file: file_names, use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:bandapp/model/bandPositionModal.dart';
import 'package:bandapp/model/bandsModel.dart';
import 'package:bandapp/model/lastSessionModal.dart';
import 'package:bandapp/network_requests/network_requests.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/sessionMultiScreen/sessionTabbarScreen/progress_band_model.dart';
import 'package:bandapp/utility/sharePrefs/shared_pref_key.dart';
import 'package:bandapp/utility/sharePrefs/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ExerciseLogController extends GetxController {
  dynamic argumentData = Get.arguments;
  String selectSet = 'Prep Set',
      thisSelectSet = 'Prep Set',
      getBandValue1 = 'Select one',
      getBandValue1ID = '',
      getBandValue2ID = '',
      getBandPosition = '',
      getBandPositionID = '',
      getReps = '',
      getBeyondFailure = '',
      getNotes = '',
      getPower = '';
  var apiClient = ApiClient();
  RxBool isLoading = false.obs;
  List<BandData> bandPower = List.empty(growable: true);
  List<BandPositonData> bandPositionList = List.empty(growable: true);
  List<RepsList> repsDataList = List.empty(growable: true);
  List<BeyondFailureList> beyondFailureList = List.empty(growable: true);
  List<LastData> lastSessionDataList = List.empty(growable: true);
  List<int> getBandsId = List.empty(growable: true);
  List<LastSessionPrepData> prepDataList = List.empty(growable: true);
  List<LastSessionPrepData> magicDataList = List.empty(growable: true);
  TextEditingController notesController = TextEditingController();
  List<ThisSessionData> thisSesstionList = List.empty(growable: true);
  List<LastSessionPrepData> addBandList = List.empty(growable: true);
  int count = 1;
  String getToken = '', getExerciseTypeId = '', getSessionId = '';

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
    SharedPrefs.getString(SharedPrefKeys.exerciseTypeID).then((value) {
      getExerciseTypeId = value;
      getSessionDetailApi(int.parse(getExerciseTypeId));

      print("value has datagetExerciseTypeId $getExerciseTypeId");
    });
    SharedPrefs.getString(SharedPrefKeys.sessionId).then((value) {
      if (value.isNotEmpty) {
        getSessionId = value;
        print("value has datagetSessionId $getSessionId");
      }
    });
    repsDataList.clear();
    repsDataList.add(RepsList(names: "3"));
    repsDataList.add(RepsList(names: "6"));
    repsDataList.add(RepsList(names: "9"));
    repsDataList.add(RepsList(names: "12"));
    repsDataList.add(RepsList(names: "15"));

    beyondFailureList.clear();
    beyondFailureList.add(BeyondFailureList(names: "1"));
    beyondFailureList.add(BeyondFailureList(names: "2"));
    beyondFailureList.add(BeyondFailureList(names: "3"));
    beyondFailureList.add(BeyondFailureList(names: "4"));
    beyondFailureList.add(BeyondFailureList(names: "5"));

    thisSesstionList.clear();
    thisSesstionList.add(ThisSessionData(names: "BAND POSITION"));
    thisSesstionList.add(ThisSessionData(names: "BAND POSITION"));
    thisSesstionList.add(ThisSessionData(names: "BAND POSITION"));
    thisSesstionList.add(ThisSessionData(names: "BAND POSITION"));
    thisSesstionList.add(ThisSessionData(names: "BAND POSITION"));
    // thisSesstionList.add(ThisSessionData(names: "MAT POSITION"));
    thisSesstionList.add(ThisSessionData(names: "REPS"));
    thisSesstionList.add(ThisSessionData(names: "BEYOND FAILURE"));
    thisSesstionList.add(ThisSessionData(names: "NOTES"));
    thisSesstionList.add(ThisSessionData(names: "POWER \nINCREASE"));

    super.onInit();
  }

  chooseSelectSet(value) {
    selectSet = value;
    update();
  }

  thisChooseSelectSet(value) {
    thisSelectSet = value;
    update();
  }
// bandname api

  void getBandProgressList() async {
    bandPower.clear();
    var res =
        await apiClient.getBandProgressData(token: getToken, isLoading: true);

    print(res);

    if (jsonDecode(res.body)['status'] != false) {
      var data1 = bandModalFromJson(res.body);

      print(data1);
      bandPower = data1.result!;
      getBandPostionList();
      print(bandPower);
    } else {}
    update();
  }

  //get bandposition api
  void getBandPostionList() async {
    bandPositionList.clear();
    var res =
        await apiClient.getBandPositionData(token: getToken, isLoading: true);

    print(res);

    if (jsonDecode(res.body)['status'] != false) {
      var data1 = bandPositionFromJson(res.body);
      print(data1);
      bandPositionList = data1.result!;
      isLoading.value = true;
      print(bandPower);
    } else {}
    update();
  }

// create exercise api
  void createExercise(BuildContext context) async {
    getBandsId.add(int.parse(getBandValue1ID));
    getBandsId.toSet().toList();
    String commaSeparatedValues = getBandsId.join(',');
    print("getBandsId $commaSeparatedValues");

    var res = await apiClient.createExerciseApi(
        sesionId: int.parse(getSessionId),
        exerciseTypeid: int.parse(getExerciseTypeId),
        sessionType: thisSelectSet,
        bandpostionId: int.parse(getBandPositionID),
        reps: getReps,
        beyondFailure: getBeyondFailure,
        notes: getNotes,
        power: 50,
        bands: commaSeparatedValues.isNotEmpty ? commaSeparatedValues : [],
        token: getToken,
        isLoading: true);

    print(res);

    if (jsonDecode(res.body)['status'] == 1) {
      print("success");

      Navigator.pop(context, true);

      Get.delete<ExerciseLogController>();

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text(jsonDecode(res.body)['message'] as String? ?? 'Invalid Data'),
        duration: const Duration(milliseconds: 500),
      ));
    }

    update();
  }

  void getSessionDetailApi(int getSessionId) async {
    var res = await apiClient.getPreviousSessionData(
        getID: getSessionId, token: getToken, isLoading: true);

    print(res);
    getBandProgressList();

    if (jsonDecode(res.body) != null &&
        jsonDecode(res.body)['status'] != false) {
      var data1 = lastDataFromJson(res.body);
      if (data1.data != null) {
        lastSessionDataList.add(data1.data!);

        if (data1.data!.sessionType == "magic_set") {
          magicDataList.clear();
          magicDataList.add(LastSessionPrepData(names: "BAND", value: "GREEN"));
          magicDataList.add(LastSessionPrepData(
              names: "BAND POSITION",
              value: data1.data!.bandPosition.toString()));
          magicDataList.add(LastSessionPrepData(
              names: "REPS", value: data1.data!.reps.toString()));
          magicDataList.add(LastSessionPrepData(
              names: "BEYOND FAILURE",
              value: data1.data!.beyondFailure.toString()));
          magicDataList.add(LastSessionPrepData(
              names: "POWER", value: data1.data!.power.toString()));
        } else {
          prepDataList.clear();
          prepDataList.add(LastSessionPrepData(names: "BAND", value: "GREEN"));
          prepDataList.add(LastSessionPrepData(
              names: "BAND POSITION",
              value: data1.data!.bandPosition.toString()));
          prepDataList.add(LastSessionPrepData(
              names: "REPS", value: data1.data!.reps.toString()));
          prepDataList.add(LastSessionPrepData(
              names: "POWER", value: data1.data!.power.toString()));
        }
      }
    } else {}
    update();
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
    getNotes = lastWords;
    print(lastWords);

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
