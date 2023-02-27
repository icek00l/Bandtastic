// ignore_for_file: file_names

import 'package:bandapp/screen/DashboardScreens/sessionScreen/sessionMultiScreen/exerciseSessionReview/exerciseReview_controller.dart';
import 'package:get/get.dart';

class ReviewExerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ReviewExerController.new);
  }
}
