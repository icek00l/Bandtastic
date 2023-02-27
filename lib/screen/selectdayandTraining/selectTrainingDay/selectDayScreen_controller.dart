// ignore_for_file: file_names, avoid_print

import 'package:bandapp/model/weekModel.dart';
import 'package:get/get.dart';

class SelectDayScreenController extends GetxController {
  List<AddWeekModel> weekList = List.empty(growable: true);
  dynamic argumentData = Get.arguments;
  int count = 0;
  @override
  void onInit() async {
    super.onInit();
   
    weekList.clear();
    weekList.add(AddWeekModel(name: "Sunday", isSelectedWeek: false,isVisible: true));
    weekList.add(AddWeekModel(name: "Monday", isSelectedWeek: false,isVisible: true));
    weekList.add(AddWeekModel(name: "Tuesday", isSelectedWeek: false,isVisible: true));
    weekList.add(AddWeekModel(name: "Wednesday", isSelectedWeek: false,isVisible: true));
    weekList.add(AddWeekModel(name: "Thursday", isSelectedWeek: false,isVisible: true));
    weekList.add(AddWeekModel(name: "Friday", isSelectedWeek: false,isVisible: true));
    weekList.add(AddWeekModel(name: "Saturday", isSelectedWeek: false,isVisible: true));
  }
}
