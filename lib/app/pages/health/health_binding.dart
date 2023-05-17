
import 'package:egu_industry/app/pages/blue_tooth/blue_tooth_controller.dart';
import 'package:get/get.dart';

import 'health_controller.dart';

class HealthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HealthController());
    Get.lazyPut(() => BlueToothController());
  }
}
