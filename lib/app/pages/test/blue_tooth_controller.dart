import 'package:get/get.dart';


class BlueToothController extends GetxController {

  // 선택된 날짜
  Rx<DateTime> selectedDay = DateTime.now().obs;

  // 날짜를 선택했는지 확인
  RxBool bSelectedDayFlag = false.obs;



  @override
  void onInit() {

  }

  @override
  void onClose() {}

  @override
  void onReady() {}
}
