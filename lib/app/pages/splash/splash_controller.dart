
import 'package:get/get.dart';

import '../../routes/app_route.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Get.log('SplashController- onInit');
  }

  @override
  void onClose() {
    Get.log('SplashController - onClose');
    super.onClose();
  }

  @override
  void onReady() async {
    Get.log('SplashController- onReady');
    await Future.delayed(Duration(milliseconds: 1000));
    Get.offAndToNamed(Routes.MAIN);
  }
}
