// ignore_for_file: file_names

import 'package:bandapp/model/bandsModel.dart';
import 'package:get/get.dart';

class ExerciseLogController extends GetxController {
  dynamic argumentData = Get.arguments;
  String 
   bandName = 'Select one',selectSet ='Prep Set',thisSelectSet ='Prep Set',getValue='',getBandPosition = '', getMat = '', getReps = '',getBeyondFailure= '';
  List<LastSessionPrepData> prepDataList = List.empty(growable: true);
  List<LastSessionPrepData> magicDataList = List.empty(growable: true);
  List<ThisSessionData> thisSesstionList = List.empty(growable: true);
  @override
  void onInit() async {
   
    prepDataList.clear();
    prepDataList.add(LastSessionPrepData(names: "BAND", value: "GREEN"));
    prepDataList.add(LastSessionPrepData(names: "BAND POSITION", value: "TWO 2"));
    prepDataList.add(LastSessionPrepData(names: "REPS", value: "11"));
    prepDataList.add(LastSessionPrepData(names: "POWER", value: "47"));

        magicDataList.clear();
    magicDataList.add(LastSessionPrepData(names: "BAND", value: "GREEN"));
    magicDataList.add(LastSessionPrepData(names: "BAND POSITION", value: "TWO 2"));
    magicDataList.add(LastSessionPrepData(names: "REPS", value: "11"));
    magicDataList.add(LastSessionPrepData(names: "BEYOND FAILURE", value: "3 half reps"));
    magicDataList.add(LastSessionPrepData(names: "POWER", value: "47"));
    
    thisSesstionList.clear();
    thisSesstionList.add(ThisSessionData(names: "BAND POSITION"));
    thisSesstionList.add(ThisSessionData(names: "MAT POSITION"));
    thisSesstionList.add(ThisSessionData(names: "REPS"));
    thisSesstionList.add(ThisSessionData(names: "BEYOND FAILURE"));

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
}
