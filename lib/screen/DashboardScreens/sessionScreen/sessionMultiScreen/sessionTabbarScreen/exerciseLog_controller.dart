// ignore_for_file: file_names, use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:bandapp/appstyle/app_colors.dart';
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
  String getBandPosition = 'Select one',
      getBandValue = '',
      getBandPositionID = '',
      getLastSessionPower = '00',
      getPowerDiffer = '',
      getReps = '',
      getNotes = '';
  int errorCount = 0;
  var apiClient = ApiClient();
  RxBool isLoading = false.obs;
  List<BandData> bandPower = [];
  List<String> selectedbandIdList = [];
  List<BandPositonData> bandPositionList = List.empty(growable: true);
  List<RepsList> repsDataList = List.empty(growable: true);
  List<BeyondFailureList> beyondFailureList = List.empty(growable: true);
  List<LastData> lastSessionDataList = List.empty(growable: true);
  List<LastSessionPrepData> prepDataList = List.empty(growable: true);
  TextEditingController notesController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController matfromController = TextEditingController();
  TextEditingController mattoController = TextEditingController();
  List<ThisSessionData> thisSesstionList = List.empty(growable: true);
  List<LastSessionPrepData> addBandList = List.empty(growable: true);
  List<BandDataModel> bandList = [];
  // int count = 1;
  String getToken = '',
      getExerciseTypeId = '',
      g1etSessionId = '',
      getCycleId = '',
      getBandPower = '',
      getBandPowerCalculate = '',
      powerEmoji = '🙂';
  List<double> selectedBandValues = [];

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
    SharedPrefs.getString(SharedPrefKeys.sessionId).then((value) {
      if (value.isNotEmpty) {
        g1etSessionId = value;
        print("Value has datagetSessionId $g1etSessionId");
      }
      update();
    });
    SharedPrefs.getString(SharedPrefKeys.cycleID).then((value) {
      if (value.isNotEmpty) {
        getCycleId = value;
        print("Value has getCycleId $getCycleId");
      }
      update();
    });
    SharedPrefs.getString(SharedPrefKeys.exerciseTypeID).then((value) {
      getExerciseTypeId = value;
      getSessionDetailApi(int.parse(getExerciseTypeId));

      print("value has datagetExerciseTypeId $getExerciseTypeId");
    });

    repsDataList.clear();
    repsDataList.add(RepsList(names: "1", value: "0.1"));
    repsDataList.add(RepsList(names: "2", value: "0.1"));
    repsDataList.add(RepsList(names: "3", value: "0.1"));
    repsDataList.add(RepsList(names: "4", value: "0.1"));
    repsDataList.add(RepsList(names: "5", value: "0.1"));
    repsDataList.add(RepsList(names: "6", value: "0.1"));
    repsDataList.add(RepsList(names: "7", value: "0.1"));
    repsDataList.add(RepsList(names: "8", value: "0.1"));
    repsDataList.add(RepsList(names: "9", value: "0.1"));
    repsDataList.add(RepsList(names: "10", value: "1"));
    repsDataList.add(RepsList(names: "11", value: "1"));
    repsDataList.add(RepsList(names: "12", value: "1"));
    repsDataList.add(RepsList(names: "13", value: "1"));
    repsDataList.add(RepsList(names: "14", value: "1"));
    repsDataList.add(RepsList(names: "15", value: "1.5"));

    beyondFailureList.clear();
    beyondFailureList.add(BeyondFailureList(names: "1"));
    beyondFailureList.add(BeyondFailureList(names: "2"));
    beyondFailureList.add(BeyondFailureList(names: "3"));
    beyondFailureList.add(BeyondFailureList(names: "4"));
    beyondFailureList.add(BeyondFailureList(names: "5"));

    thisSesstionList.clear();
    // thisSesstionList.add(ThisSessionData(names: "BAND POSITION"));
    // thisSesstionList.add(ThisSessionData(names: "BAND POSITION"));
    thisSesstionList.add(ThisSessionData(names: "BAND POSITION"));
    thisSesstionList.add(ThisSessionData(names: "BAND POSITION"));
    thisSesstionList.add(ThisSessionData(names: "BAND POSITION"));
    thisSesstionList.add(ThisSessionData(names: "MAT POSITION"));
    thisSesstionList.add(ThisSessionData(names: "*TIME"));
    thisSesstionList.add(ThisSessionData(names: "REPS"));
    thisSesstionList.add(ThisSessionData(names: "NOTES"));
    thisSesstionList.add(ThisSessionData(names: "POWER \nINCREASE"));

    super.onInit();
  }

// bandname api
  void getBandProgressList() async {
    bandPower.clear();
    var res =
        await apiClient.getBandProgressData(token: getToken, isLoading: true);

    if (jsonDecode(res.body)['status'] == 1) {
      var data1 = bandModalFromJson(res.body);

      print(data1);
      bandPower.add(BandData(
          id: 0, band: "Select one", power: 0, createdAt: "", updatedAt: ""));
      bandPower.addAll(data1.band!);

      bandList.add(BandDataModel(
          id: bandPower[0].id.toString(),
          names: bandPower[0].band ?? '',
          power: bandPower[0].power.toString()));
      calculateValue();
      getBandPostionList();
      print(bandPower);
    }
    update();
  }

  //get bandposition api
  void getBandPostionList() async {
    bandPositionList.clear();
    var res =
        await apiClient.getBandPositionData(token: getToken, isLoading: true);

    if (jsonDecode(res.body)['status'] == true) {
      var data1 = bandPositionFromJson(res.body);
      print(data1);
      bandPositionList = data1.result!;
      calculateBandPosition();
      isLoading.value = true;
      print(bandPower);
    } else {}
    update();
  }

// create exercise api
  void createExercise(BuildContext context) async {
    String commaSeparatedValues = '';
    List<String> listOdIds = [];

    for (var i = 0; i < bandList.length; i++) {
      listOdIds.add(bandList[i].id.toString());
    }

    commaSeparatedValues = listOdIds.join(',');
    print("getBandsId $commaSeparatedValues");
    var res = await apiClient.createExerciseApi(
      sesionId: int.parse(g1etSessionId),
      exerciseTypeid: int.parse(getExerciseTypeId),
      getcycleid: int.parse(getCycleId),
      bandpostionId:
          getBandPositionID.isEmpty ? null : int.parse(getBandPositionID),
      reps: getReps,
      time: timeController.text,
      notes: getNotes,
      power: getBandPower,
      bands: commaSeparatedValues.isNotEmpty ? commaSeparatedValues : "",
      matfromvalue: matfromController.text,
      matTovalue: mattoController.text,
      token: getToken,
      isLoading: true,
    );

    if (jsonDecode(res.body)['status'] == 1) {
      print("success");

      Navigator.pop(context, true);

      Get.delete<ExerciseLogController>();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text(jsonDecode(res.body)['message'] as String? ?? 'Invalid Data'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.errorColor,
        duration: const Duration(milliseconds: 1000),
      ));
    }

    update();
  }

  void getSessionDetailApi(int getSessionId) async {
    var res = await apiClient.getPreviousSessionData(
        getID: getSessionId, token: getToken, isLoading: true);

    getBandProgressList();

    if (jsonDecode(res.body)['status'] == 1) {
      var data1 = lastDataFromJson(res.body);
      if (data1.data != null) {
        lastSessionDataList.add(data1.data!);

        prepDataList.clear();
        prepDataList.add(LastSessionPrepData(
            names: "BAND",
            value: data1.data!.userExcerciseBand != null &&
                    data1.data!.userExcerciseBand!.isNotEmpty
                ? data1.data!.userExcerciseBand![0].band == null
                    ? "N/A"
                    : data1.data!.userExcerciseBand![0].band!.band ?? "N/A"
                : "N/A"));
        prepDataList.add(LastSessionPrepData(
            names: "BAND POSITION",
            value: data1.data!.bandPosition != null
                ? data1.data!.bandPosition!.position ?? "N/A"
                : "N/A"));
        prepDataList.add(LastSessionPrepData(
            names: "MAT POSITION",
            value: data1.data!.matFrom != null
                ? "${data1.data!.matFrom ?? "N/A"} to ${data1.data!.matTo ?? "N/A"}"
                : "N/A"));
        prepDataList.add(LastSessionPrepData(
            names: "TIME", value: data1.data!.time ?? "N/A"));
        prepDataList.add(LastSessionPrepData(
            names: "POWER", value: data1.data!.power ?? "N/A"));
        getLastSessionPower = data1.data!.power ?? "0";
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

    this.level = level;
    update();
  }

  calculateValue() {
    List<double> getPower = [];
    for (int i = 0; i < bandList.length; i++) {
      print(bandList[i].power);
      getPower.add(double.parse(bandList[i].power.toString()));
    }
    List<double> selectedValues = getPower.toList();

    double powerCalculate =
        selectedValues.reduce((value, element) => value + element);
    getBandPowerCalculate = powerCalculate.toString();
    var getBandPower1 = powerCalculate.toInt();
    getBandPower = getBandPower1.toString();
    if (getLastSessionPower != "00") {
      if (double.parse(getLastSessionPower) > double.parse(getBandPower)) {
        var powerDiffer =
            double.parse(getLastSessionPower) - double.parse(getBandPower);
        var storePower = powerDiffer.toInt();
        getPowerDiffer = "- $storePower";
        powerEmoji = '😔';
      } else {
        var powerDiffer =
            double.parse(getBandPower) - double.parse(getLastSessionPower);
        var storePower = powerDiffer.toInt();
        getPowerDiffer = "+ $storePower";

        powerEmoji = '🙂';
      }
    }

    update();
  }

  calculateBandPosition() {
    var getBandMulti = double.parse(getBandPower) *
        double.parse(getBandValue.isEmpty ? "1" : getBandValue);
     int  getBandPowerCalculate1 = getBandMulti.round();
    getBandPowerCalculate = getBandPowerCalculate1.toString();

    var getBandPower1 = getBandMulti.toInt();
    getBandPower = getBandPower1.toString();
    if (getLastSessionPower != "00") {
      if (double.parse(getLastSessionPower) > double.parse(getBandPower)) {
        var powerDiffer =
            double.parse(getLastSessionPower) - double.parse(getBandPower);
        var storePower = powerDiffer.toInt();
        getPowerDiffer = "- $storePower";
        powerEmoji = '😔';
      } else {
        var powerDiffer =
            double.parse(getBandPower) - double.parse(getLastSessionPower);
        var storePower = powerDiffer.toInt();
        getPowerDiffer = "+ $storePower";
        powerEmoji = '🙂';
      }
    }
    print(getBandMulti);
    print(getBandPower);
    update();
  }

  calculateTimeValue(value) {
    if (int.parse(value) < int.parse("90")) {
      print("less");
      var getBandMulti =
          double.parse(getBandPowerCalculate) * double.parse("0.011");

      int getBandPower1 = getBandMulti.round();
      getBandPowerCalculate = getBandPower1.toString();
      getBandPower = getBandPower1.toString();
      if (getLastSessionPower != "00") {
        if (double.parse(getLastSessionPower) >
            double.parse(getBandPowerCalculate)) {
          var powerDiffer = double.parse(getLastSessionPower) -
              double.parse(getBandPowerCalculate);
          var storePower = powerDiffer.toInt();
          getPowerDiffer = "- $storePower";
          powerEmoji = '😔';
        } else {
          var powerDiffer = double.parse(getBandPowerCalculate) -
              double.parse(getLastSessionPower);
          var storePower = powerDiffer.toInt();
          getPowerDiffer = "+ $storePower";
          powerEmoji = '🙂';
        }
      }
    } else if (value == "90") {
      var getBandMulti =
          double.parse(getBandPowerCalculate) * double.parse("1");

      int getBandPower1 = getBandMulti.round();
      getBandPowerCalculate = getBandPower1.toString();
      getBandPower = getBandPower1.toString();
      if (getLastSessionPower != "00") {
        if (double.parse(getLastSessionPower) >
            double.parse(getBandPowerCalculate)) {
          var powerDiffer = double.parse(getLastSessionPower) -
              double.parse(getBandPowerCalculate);
          var storePower = powerDiffer.toInt();
          getPowerDiffer = "- $storePower";
          powerEmoji = '😔';
        } else {
          var powerDiffer = double.parse(getBandPowerCalculate) -
              double.parse(getLastSessionPower);
          var storePower = powerDiffer.toInt();
          getPowerDiffer = "+ $storePower";
          powerEmoji = '🙂';
        }
      }
    } else if (value == "180") {
      var getBandMulti =
          double.parse(getBandPowerCalculate) * double.parse("1.225");

      int getBandPower1 = getBandMulti.round();
      getBandPowerCalculate = getBandPower1.toString();
      getBandPower = getBandPower1.toString();
      if (getLastSessionPower != "00") {
        if (double.parse(getLastSessionPower) >
            double.parse(getBandPowerCalculate)) {
          var powerDiffer = double.parse(getLastSessionPower) -
              double.parse(getBandPowerCalculate);
          var storePower = powerDiffer.toInt();
          getPowerDiffer = "- $storePower";
          powerEmoji = '😔';
        } else {
          var powerDiffer = double.parse(getBandPowerCalculate) -
              double.parse(getLastSessionPower);
          var storePower = powerDiffer.toInt();
          getPowerDiffer = "+ $storePower";
          powerEmoji = '🙂';
        }
      }
    } else if (int.parse(value) > int.parse("90")) {
      print(value);
      var result = int.parse(value) - 90;
      var result1 = (double.parse(result.toString()) * 0.0025) + 1;
      print(result1);
      var getBandMulti = double.parse(getBandPowerCalculate) *
          double.parse(result1.toString());

      int getBandPower1 = getBandMulti.round();
      getBandPowerCalculate = getBandPower1.toString();
      getBandPower = getBandPower1.toString();
      if (getLastSessionPower != "00") {
        if (double.parse(getLastSessionPower) >
            double.parse(getBandPowerCalculate)) {
          var powerDiffer = double.parse(getLastSessionPower) -
              double.parse(getBandPowerCalculate);
          var storePower = powerDiffer.toInt();
          getPowerDiffer = "- $storePower";
          powerEmoji = '😔';
        } else {
          var powerDiffer = double.parse(getBandPowerCalculate) -
              double.parse(getLastSessionPower);
          var storePower = powerDiffer.toInt();
          getPowerDiffer = "+ $storePower";
          powerEmoji = '🙂';
        }
      }
    }

    update();
  }

}
