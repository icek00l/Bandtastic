// ignore_for_file: file_names

import 'package:bandapp/model/cycleModel.dart';
import 'package:get/get.dart';

class WeekCycleController extends GetxController {
  List<CycleModel> cycleDataList = List.empty(growable: true);

  @override
  void onInit() async {
    cycleDataList.clear();
    cycleDataList.add(CycleModel(exerName: "LEGS", value: "+12"));
    cycleDataList.add(CycleModel(exerName: "CHESTS", value: "+12"));
    cycleDataList.add(CycleModel(exerName: "BACK", value: "+12"));
    cycleDataList.add(CycleModel(exerName: "SHOULDERS", value: "+12"));
    cycleDataList.add(CycleModel(exerName: "BICEPS", value: "+12"));
    cycleDataList.add(CycleModel(exerName: "TRICEPS", value: "+12"));

    super.onInit();
  }
}
