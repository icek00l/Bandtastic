
import 'package:get/route_manager.dart';

import 'app_pages.dart';

abstract class AppRouteMaps {
  
  static void goTowalkthrough() {
    Get.offNamed(
      Routes.walkThrough,
    );
  }
  static void goToLoginPage(bool getBool){
    Get.offNamed(
      Routes.login,arguments: {
        "changeBooleanValue": getBool
      }
    );
  }
  static void goToNameScreenPage() {
    Get.toNamed(
      Routes.nameView,
    );
  }
  static void goToEmailScreenPage(String name) {
    Get.toNamed(
      Routes.emailView,arguments: {
        "userName": name,
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
 
  static void goToRestWeekScreen() {
    Get.toNamed(
      Routes.restWeekScreen
    );
  }
  static void goToTrainVideoScreen(String videoUrl) {
    Get.toNamed(
      Routes.trainIntroVideo,arguments: {
        "videoUrl" : videoUrl
      }
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
