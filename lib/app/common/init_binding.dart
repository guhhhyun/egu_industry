
import 'package:get/get.dart';

import '../net/home_api.dart';
import 'global_service.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
    Get.log('InitBinding start');
    Get.put(GlobalService());
    Get.put(HomeApi());
    Get.log('InitBinding end');
  }
}
