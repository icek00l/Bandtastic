// ignore_for_file: file_names

import 'package:bandapp/model/exerciseModel.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
   List<AddExerciseModel> exerciseList = List.empty(growable: true);
   
  @override
  void onInit() async {
    exerciseList.clear();
    exerciseList.add(AddExerciseModel(bodyName: "LEGS", exerciseName: "Straight leg deadlifts", value: 2));
    exerciseList.add(AddExerciseModel(bodyName: "CHESTS", exerciseName: "Chest Press",value: 4));
    exerciseList.add(AddExerciseModel(bodyName: "BACK", exerciseName: "Wide grip row",value: 1));
    exerciseList.add(AddExerciseModel(bodyName: "SHOULDERS", exerciseName: "Shoulder press",value: 5));
    exerciseList.add(AddExerciseModel(bodyName: "BICEPS", exerciseName: "Reverse bicep curl",value: 3));
    exerciseList.add(AddExerciseModel(bodyName: "TRICEPS", exerciseName: "Overhead tricep extension",value: 2));


    super.onInit();
  }
 
  
}
