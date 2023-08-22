
import 'package:egu_industry/app/net/home_api.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';


class PackagingInspecController extends GetxController {

  var textController = TextEditingController();
  RxList<dynamic> productList = [].obs;

  Future<void> checkButton() async {
    var a = await HomeApi.to.PROC('USP_MBS1300_R01',
        {'@p_WORK_TYPE': 'Q', '@p_BARCODE_NO': textController.text}).then((value) =>
    {
      if(value['DATAS'] != null) {
        productList.value = value['DATAS'],
      }
    });
    Get.log('바코드 조회 쿼리: $a');
  }

  @override
  void onInit() {
    checkButton();
  }

  @override
  void onClose() {
  }

  @override
  void onReady() {
  }
}
