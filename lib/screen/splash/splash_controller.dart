import 'package:bandapp/navigation/app_route_maps.dart';
import 'package:bandapp/screen/UserData/emailScreen/email_Verify.dart';
import 'package:bandapp/utility/sharePrefs/shared_pref_key.dart';
import 'package:bandapp/utility/sharePrefs/shared_prefs.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    SharedPrefs.getString(SharedPrefKeys.isLoggedIn).then((value) {
      print(value);
      if (value == "1") {
        SharedPrefs.getString(SharedPrefKeys.saveCode).then((value) {
          if (value.isNotEmpty) {
            var getCode = value;
            print(getCode);
            AppRouteMaps.goToNameScreenPage();
          }
        });
      } else if (value == "2") {
        Get.to(() => const EmailVerifyScreen());
      } else if (value == "3") {
        AppRouteMaps.goToWelcomeScreenPage();
      } else if (value == "4") {
        AppRouteMaps.goToDashbaordScreen("");
      } else {
        Future.delayed(
          const Duration(
            seconds: 2,
          ),
          () {
            AppRouteMaps.goTowalkthrough();
          },
        );
      }
    });

    super.onInit();
  }
}
