import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socio_univ/src/mainpage.dart';
import 'package:socio_univ/src/views/login/login.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 4), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getBool('login') == true) {
        Get.off(() => const MainPage());
      } else {
        Get.to(() => const ViewLogin());
      }
    });
  }
}
