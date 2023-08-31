import 'package:egu_industry/app/common/common_confirm_widget.dart';
import 'package:egu_industry/app/common/global_service.dart';
import 'package:egu_industry/app/common/home_widget.dart';
import 'package:egu_industry/app/common/utils.dart';

import 'package:egu_industry/app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_widget/home_widget.dart';

class LoginController extends GetxController {
  RxBool isCheckBox = false.obs;
  var idTextController = TextEditingController();
  var pwTextController = TextEditingController();

  GlobalService gs = Get.find();

  // late PackageInfo packageInfo;
  RxString strersion = '0.0.0'.obs;


  void checkBoxBtnTrue() {
    isCheckBox.value = true;
    Get.log('아이디 저장!!!');
  }

  void checkBoxBtnFalse() {
    isCheckBox.value = false;
  }

  void btnLogin() async {
    Get.log('로그인 버튼 클릭');
    Get.offAllNamed(Routes.MAIN);
    gs.setLoginInfo();

    try {
    } catch (e) {
      Get.log('btnLogin catch !!!!');
      Get.log(e.toString());
    } finally {
    }
  }




  @override
  void onClose() {
    Get.log('LoginController - onClose !!');
    super.onClose();
  }

  @override
  void onInit() async {
    Get.log('LoginController - onInit !!');
    super.onInit();
  }

  @override
  void onReady() {
    Get.log('LoginController - onReady !!');
    super.onReady();
    if (Get.arguments != null) {
      var msg = Get.arguments['msg'] ?? false;

      if (msg == true) {
        Utils.showToast(msg: '로그인이 필요한 서비스 입니다.');
      }
    }
  }
}
