// ignore_for_file: file_names

import 'package:bandapp/model/cycleModel.dart';
import 'package:get/get.dart';

class WeekDataController extends GetxController {
  List<CycleModel> cycleDataList = List.empty(growable: true);
  List<WeekName> weekNameList = List.empty(growable: true);

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
    weekNameList.clear();
    weekNameList.add(WeekName(weekName: 'Wednesday'));
    weekNameList.add(WeekName(weekName: 'Friday'));
    weekNameList.add(WeekName(weekName: 'Monday'));

    super.onInit();
  }
}
