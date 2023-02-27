import 'package:bandapp/navigation/app_route_maps.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    Future.delayed(
      const Duration(
        seconds: 2,
      ),
      () {
        AppRouteMaps.goTowalkthrough();
        // AppRouteMaps.goToDashbaordScreen("");
      },
    );

    super.onInit();
  }
}
