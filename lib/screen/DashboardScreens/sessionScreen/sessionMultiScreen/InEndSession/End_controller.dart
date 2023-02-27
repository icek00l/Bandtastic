// ignore_for_file: file_names

import 'package:bandapp/model/bandsModel.dart';
import 'package:get/get.dart';

class EndSessionController extends GetxController {
 
  List<ExerciseVideoList> exerciseVideo = List.empty(growable: true);
  List<ExtraDataList> extraData = List.empty(growable: true);
  List<LastSessionPrepData> endSessionData = List.empty(growable: true);

 @override
 void onInit()async {

    endSessionData.clear();
    endSessionData.add(LastSessionPrepData(names: "Session Time", value: "45:30"));
    endSessionData.add(LastSessionPrepData(names: "Power increase", value: "+17"));
   exerciseVideo.clear();
    exerciseVideo.add(ExerciseVideoList(
        exerciseName: "Straight leg \ndeadlifts", value: 1));
    exerciseVideo.add(ExerciseVideoList(exerciseName: "Chest Press", value: 2));
    exerciseVideo
        .add(ExerciseVideoList(exerciseName: "Wide grip row", value: 3));
    exerciseVideo
        .add(ExerciseVideoList(exerciseName: "Shoulder press", value: 4));
    exerciseVideo
        .add(ExerciseVideoList(exerciseName: "Reverse bicep curl", value: 5));
    exerciseVideo.add(ExerciseVideoList(
        exerciseName: "Overhead \ntricep extension", value: 6));

         extraData.clear();
    extraData.add(ExtraDataList(
        name: "Band", value: "gr"));
    extraData.add(ExtraDataList(name: "Position", value: "2"));
    extraData
        .add(ExtraDataList(name: "Reps", value: "11"));
    extraData
        .add(ExtraDataList(name: "Beyond failure", value: "3"));
    extraData
        .add(ExtraDataList(name: "Power", value: "+3"));

        super.onInit();
 }
}
