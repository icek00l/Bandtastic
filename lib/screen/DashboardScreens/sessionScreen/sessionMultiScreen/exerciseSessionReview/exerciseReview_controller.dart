// ignore_for_file: file_names

import 'package:bandapp/model/bandsModel.dart';
import 'package:get/get.dart';

class ReviewExerController extends GetxController {
  List<LastSessionPrepData> magicDataList = List.empty(growable: true);
  @override
  void onInit() {
            magicDataList.clear();
    magicDataList.add(LastSessionPrepData(names: "Notes"));
    magicDataList.add(LastSessionPrepData(names: "BAND", value: "GREEN"));
    magicDataList.add(LastSessionPrepData(names: "BAND POSITION", value: "TWO 2"));
    magicDataList.add(LastSessionPrepData(names: "REPS", value: "11"));
    magicDataList.add(LastSessionPrepData(names: "BEYOND FAILURE", value: "3 half reps"));
    magicDataList.add(LastSessionPrepData(names: "POWER", value: "+3"));

    super.onInit();
  }
}
