

import 'package:egu_industry/app/net/home_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlarmController extends GetxController with GetSingleTickerProviderStateMixin {

  late TabController tabController;
  RxList<dynamic> alarmList = [].obs;
  RxString chkYn = ''.obs;


  Future<void> checkList() async {
    var a = await HomeApi.to.PROC('USP_MBR1100_R01', {'@p_WORK_TYPE':'Q', '@p_CHK_YN': chkYn.value
      , '@p_USER':'admin',}).then((value) =>
    {
    });
    Get.log('알림 조회::::::::: $a');

  }

  @override
  void onClose() {
    Get.log('AlarmController - onClose !!');
    super.onClose();
  }

  @override
  void onInit() async {
    Get.log('AlarmController - onInit !!');
    super.onInit();
    checkList();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void onReady() {
    Get.log('AlarmController - onReady !!');

  }
}
