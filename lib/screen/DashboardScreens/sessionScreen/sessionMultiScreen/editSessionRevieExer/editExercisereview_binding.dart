// ignore_for_file: file_names

import 'package:bandapp/screen/DashboardScreens/sessionScreen/sessionMultiScreen/editSessionRevieExer/editExerciseReview_controller.dart';
import 'package:get/get.dart';

class EditReviewSessionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(EditReviewSessionController.new);
  }
}
