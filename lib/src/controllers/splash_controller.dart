import 'package:get/get.dart';
import 'package:socio_univ/src/views/login/login.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 4), () {
      Get.to(() => const ViewLogin());
    });
  }
}
