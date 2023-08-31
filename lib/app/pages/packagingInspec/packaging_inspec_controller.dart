
import 'package:egu_industry/app/net/home_api.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';


class PackagingInspecController extends GetxController {

  var textController = TextEditingController();
  RxList<dynamic> productList = [].obs;
  RxList<dynamic> productDetailList = [].obs;
  RxList<dynamic> inspecDetailList = [].obs;
  RxString barcodeScanResult = ''.obs;
  RxDouble realWeight = 0.0.obs;
  RxDouble totalWeight = 0.0.obs;
  RxList<bool> isProductSelectedList = [false].obs;
  RxList productSelectedList = [].obs;

  Future<void> saveButton() async {
    for(var i = 0; i < productSelectedList.length; i++) {
      var a = await HomeApi.to.PROC('USP_MBS1300_S01',
          {'@p_WORK_TYPE': 'U', '@p_BARCODE_NO': productSelectedList[i]['BARCODE'], '@p_USER': 'admin'});
    }
  }

  Future<void> checkButton() async {
    productList.clear();
    var a = await HomeApi.to.PROC('USP_MBS1300_R01',
        {'@p_WORK_TYPE': 'Q', '@p_BARCODE_NO': textController.text}).then((value) =>
    {
      if(value['DATAS'] != null) {
        productList.value = value['DATAS'],
      }
    });
    Get.log('포장검수 첫번째: $a');
  }
  Future<void> checkButton2() async {
    productSelectedList.clear();
    productDetailList.clear();
    isProductSelectedList.clear();
    realWeight.value = 0.0;
    totalWeight.value = 0.0;
    var a = await HomeApi.to.PROC('USP_MBS1300_R01',
        {'@p_WORK_TYPE': 'Q1', '@p_BARCODE_NO': textController.text}).then((value) =>
    {
      if(value['DATAS'] != null) {
        productDetailList.value = value['DATAS'],
      },
      for(var i = 0; i < productDetailList.length; i++) {
        realWeight.value = realWeight.value + productDetailList[i]['REAL_WEIGHT'],
        totalWeight.value = totalWeight.value + productDetailList[i]['ALL_WEIGHT'],
        isProductSelectedList.add(false),
      }
    });
    Get.log('포장검수 두번째: $a');
  }
  Future<void> checkButton3() async {
    inspecDetailList.clear();
    var a = await HomeApi.to.PROC('USP_MBS1300_R01',
        {'@p_WORK_TYPE': 'Q2', '@p_BARCODE_NO': textController.text}).then((value) =>
    {
      if(value['DATAS'] != null) {
        inspecDetailList.value = value['DATAS'],
      }
    });
    Get.log('포장검수 세번째: $a');
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
