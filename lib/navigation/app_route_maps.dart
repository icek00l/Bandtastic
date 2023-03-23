
import 'package:get/route_manager.dart';

import 'app_pages.dart';

abstract class AppRouteMaps {
  
  static void goTowalkthrough() {
    Get.offNamed(
      Routes.walkThrough,
    );
  }
  static void goToLoginPage() {
    Get.offNamed(
      Routes.login,
    );
  }
  static void goToNameScreenPage(dynamic code) {
    Get.toNamed(
      Routes.nameView,arguments: {
        "boxCode": code,
      }
    );
  }
  static void goToEmailScreenPage(String name, dynamic code) {
    Get.toNamed(
      Routes.emailView,arguments: {
        "userName": name,
        "codeGet": code,
      }
    );
  }
  static void goToWelcomeScreenPage() {
    Get.offNamed(
      Routes.welcomeView,
    );
  }
  static void goToTrainingScreenPage() {
    Get.toNamed(
      Routes.trainingExplain,
    );
  }
  static void goToSelectTwoThree() {
    Get.toNamed(
      Routes.trainingTwoThree,
    );
  }
  static void goToSelectExerciseDay() {
    Get.toNamed(
      Routes.exerciseDaySelect
    );
  }
  static void goToRestWeekScreen() {
    Get.toNamed(
      Routes.restWeekScreen
    );
  }
  static void goToTrainVideoScreen() {
    Get.toNamed(
      Routes.trainIntroVideo
    );
  }
  static void goToDashbaordScreen(String number) {
    Get.offNamedUntil('bottomBar', (route) => false,arguments: {
      "FirstTime": number
    });

  }

  static void goToSessionPrepareView(String name,String number) {
    Get.toNamed(
      Routes.sessionPrepare,arguments: {
        "exerciseName": name,
        "exerciseNumber": number,
      }

    );
  }
  
}
