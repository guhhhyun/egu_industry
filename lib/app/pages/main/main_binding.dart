
import 'package:egu_industry/app/pages/blue_tooth/blue_tooth_controller.dart';
import 'package:egu_industry/app/pages/home/home_controller.dart';
import 'package:egu_industry/app/pages/setting/setting_controller.dart';
import 'package:get/get.dart';

import 'main_controller.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SettingController());
    Get.lazyPut(() => BlueToothController());
  }
}
