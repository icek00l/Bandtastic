// ignore_for_file: file_names, avoid_print

import 'dart:convert';

import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/model/bandsModel.dart';
import 'package:bandapp/model/lastSessionModal.dart';
import 'package:bandapp/network_requests/network_requests.dart';
import 'package:bandapp/utility/sharePrefs/shared_pref_key.dart';
import 'package:bandapp/utility/sharePrefs/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewExerController extends GetxController {
  List<LastSessionPrepData> magicDataList = List.empty(growable: true);
  List<UserExcerciseBand> storeAllLastData = List.empty(growable: true);
  TextEditingController notesController = TextEditingController();
  var apiClient = ApiClient();
  String getToken = '', getSessionIdSave = '', getStoreID = '';

  @override
  void onInit() {
    SharedPrefs.getString(SharedPrefKeys.token).then((value) {
      if (value != "0") {
        getToken = value;
        print("value has data $getToken");
      }
    });
    SharedPrefs.getString(SharedPrefKeys.exerciseTypeID).then((value) {
      getSessionIdSave = value;
      getSessionDetailApi(int.parse(value));
    });
    update();
    super.onInit();
  }

  void getSessionDetailApi(int getSessionId) async {
    var res = await apiClient.getPreviousSessionData(
        getID: getSessionId, token: getToken, isLoading: true);

    if (jsonDecode(res.body)['status'] == 1) {
      var data1 = lastDataFromJson(res.body);
      if (data1.data != null) {
        storeAllLastData = data1.data!.userExcerciseBand!;

        notesController.text = data1.data!.notes ?? "N/A";
        if (data1.data!.userExcerciseBand!.isNotEmpty) {
          for (int i = 0; i < data1.data!.userExcerciseBand!.length; i++) {
            getStoreID = data1.data!.userExcerciseBand![i].id.toString();
            magicDataList.clear();
            magicDataList.add(LastSessionPrepData(names: "Notes"));
            magicDataList.add(LastSessionPrepData(
                names: "BAND",
                value: data1.data!.userExcerciseBand![0].band == null
                    ? "NA"
                    : data1.data!.userExcerciseBand![0].band!.band.toString()));
            magicDataList.add(LastSessionPrepData(
                names: "BAND POSITION",
                value: data1.data!.bandPosition == null
                    ? 'N/A'
                    : data1.data!.bandPosition!.position ?? "N/A"));
            magicDataList.add(LastSessionPrepData(
                names: "MAT POSITION",
                value: data1.data!.matFrom != null
                    ? "${data1.data!.matFrom ?? "N/A"} to ${data1.data!.matTo ?? "N/A"}"
                    : "N/A"));

            magicDataList.add(LastSessionPrepData(
                names: "TIME", value: data1.data!.time ?? "N/A"));
            magicDataList.add(LastSessionPrepData(
                names: "POWER", value: data1.data!.power ?? "N/A"));
          }
        } else {
          magicDataList.clear();
          magicDataList.add(LastSessionPrepData(names: "Notes", value: ""));
          magicDataList.add(LastSessionPrepData(names: "BAND", value: "N/A"));
          magicDataList.add(LastSessionPrepData(
              names: "BAND POSITION",
              value: data1.data!.bandPosition == null
                  ? "N/A"
                  : data1.data!.bandPosition!.position.toString()));
          magicDataList.add(LastSessionPrepData(
              names: "MAT POSITION",
              value: data1.data!.matFrom != null
                  ? "${data1.data!.matFrom ?? "N/A"} to ${data1.data!.matTo ?? "N/A"}"
                  : "N/A"));
          magicDataList.add(LastSessionPrepData(
              names: "TIME", value: data1.data!.time ?? "N/A"));
          magicDataList.add(LastSessionPrepData(
              names: "POWER", value: data1.data!.power ?? "00"));
        }
      }
    } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar( SnackBar(
                        content: Text(jsonDecode(res.body)['message'] ?? ""),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: AppColors.errorColor,
                        duration:const Duration(seconds: 1),
                      ));
    }
    update();
  }
}
