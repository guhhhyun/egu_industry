import 'package:egu_industry/app/net/home_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class ScrapLabelController extends GetxController {
  var textController = TextEditingController();
  RxList<String> scrapGubun = ['선택해주세요', '스크랩', '지금류'].obs; // 하드코딩 하는건가 흠
  RxList<String> scrapType = ['선택해주세요', '매입', '공정회수', '외주'].obs;
  RxList insNumList = [].obs;
  RxBool isCheck = false.obs;


  Future<void> checkButton() async {
    var a = await HomeApi.to.PROC('USP_SCS0300_R01', {'@p_WORK_TYPE':'Q_MEAS', '@p_MEAS_NO': ''}).then((value) =>
    {
      insNumList.value = value['DATAS']
    });

    Get.log('계량번호 조회: $a');
  }



  @override
  void onInit() {}

  @override
  void onClose() {}

  @override
  void onReady() {
  }
}
