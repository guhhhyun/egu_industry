
import 'package:egu_industry/app/pages/blueTooth/blue_tooth_controller.dart';
import 'package:egu_industry/app/pages/dolbal/facility_controller.dart';
import 'package:egu_industry/app/pages/facilityFirst/facility_first_controller.dart';
import 'package:egu_industry/app/pages/home/home_controller.dart';
import 'package:egu_industry/app/pages/setting/setting_controller.dart';
import 'package:get/get.dart';

import 'main_controller.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => SettingController(), fenix: true);
    Get.lazyPut(() => BlueToothController(), fenix: true);
    Get.lazyPut(() => FacilityController(), fenix: true);
    Get.lazyPut(() => FacilityFirstController(),  fenix: true);
  }
}
