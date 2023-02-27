// ignore_for_file: file_names

import 'package:bandapp/model/cycleModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExerDataController extends GetxController {
  List<CycleModel> cycleDataList = List.empty(growable: true);
  List<WeekDataModel> weekWiseData = List.empty(growable: true);
  
ScrollController scrollControl = ScrollController();
  @override
  void onInit() async {
    cycleDataList.clear();
    cycleDataList.add(
        CycleModel(exerName: "Stiff leg deadlifts", value: "+12"));
    cycleDataList.add(CycleModel(exerName: "Chest Press", value: "+12"));
    cycleDataList.add(CycleModel(exerName: "Wide grip row", value: "+12"));
    cycleDataList.add(CycleModel(exerName: "Shoulder press", value: "+12"));
    cycleDataList.add(CycleModel(exerName: "Reverse bicep curl", value: "+12"));
    cycleDataList
        .add(CycleModel(exerName: "Overhead tricep extension", value: "+12"));
   
weekWiseData.clear();
    weekWiseData.add(WeekDataModel(weekDay: "wk1", power: "49",value: "Change" ));
    weekWiseData.add(WeekDataModel(weekDay: "2", power: "53",value: "+4" ));
    weekWiseData.add(WeekDataModel(weekDay: "3", power: "55",value: "+1" ));
    weekWiseData.add(WeekDataModel(weekDay: "4", power: "60",value: "+5" ));
    weekWiseData.add(WeekDataModel(weekDay: "5", power: "62",value: "+2" ));
    weekWiseData.add(WeekDataModel(weekDay: "6", power: "63",value: "+1" ));

    super.onInit();
  }
}
