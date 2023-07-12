
import 'package:egu_industry/app/pages/blueTooth/blue_tooth_controller.dart';
import 'package:egu_industry/app/pages/dolbal/facility_controller.dart';
import 'package:get/get.dart';

class FacilityBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FacilityController());
  }
}