
import 'package:egu_industry/app/pages/blue_tooth/blue_tooth_controller.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => BlueToothController());
  }
}
