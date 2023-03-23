// ignore_for_file: file_names

import 'package:bandapp/model/bandsModel.dart';
import 'package:get/get.dart';

class EditReviewSessionController extends GetxController {
    String 
   bandName = 'Select one',selectSet ='Prep Set',thisSelectSet ='Prep Set',getValue='',getBandPosition = '', getMat = '', getReps = '',getBeyondFailure= '';
  List<ThisSessionData> thisSesstionList = List.empty(growable: true);


  @override
  void onInit() async {
       thisSesstionList.clear();
    thisSesstionList.add(ThisSessionData(names: "NOTES"));
    thisSesstionList.add(ThisSessionData(names: "BAND POSITION"));
    thisSesstionList.add(ThisSessionData(names: "BAND POSITION"));
    thisSesstionList.add(ThisSessionData(names: "BAND POSITION"));
    thisSesstionList.add(ThisSessionData(names: "BAND POSITION"));
    // thisSesstionList.add(ThisSessionData(names: "MAT POSITION"));
    thisSesstionList.add(ThisSessionData(names: "REPS"));
    thisSesstionList.add(ThisSessionData(names: "BEYOND FAILURE"));
    thisSesstionList.add(ThisSessionData(names: "POWER \nINCREASE"));

    super.onInit();
  }
}
