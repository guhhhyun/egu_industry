import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/dialog_widget.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:egu_industry/app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:table_calendar/table_calendar.dart';


class InventoryCheckController extends GetxController {

  var textController = TextEditingController(); // 거래처명
  var textController2 = TextEditingController(); // 두께

  RxMap<String, String> selectedCmpMap = {'FG_CODE':'', 'FG_NAME': ''}.obs;
  RxMap<String, String> selectedSttMap = {'STT_ID':'', 'STT_NM': ''}.obs;
  RxList<dynamic> cmpList = [].obs;
  RxList<dynamic> sttList = [].obs;
  RxList<dynamic> productSearchList = [].obs;


  Future<void> checkButton() async {
    var a = await HomeApi.to.PROC('USP_MBR0900_R01', {'@p_WORK_TYPE':'Q', '@p_CST_NM': textController.text
      , '@p_CMP_ID': selectedCmpMap['FG_NAME'] == '품명 선택' ? '' : '${selectedCmpMap['FG_CODE']}', '@p_STT_ID': selectedCmpMap['STT_NM'] == '품명 선택' ? '' : '${selectedSttMap['STT_ID']}', '@p_THIC': textController2.text == '' ? null : textController2.text}).then((value) =>
    {
      if(value['DATAS'] != null) {
        productSearchList.value = value['DATAS'],
      }
    });

    Get.log('재품재고 조회: $a');
  }


  Future<void> convert() async {
    cmpList.clear();
    sttList.clear();
    selectedCmpMap.clear();
    selectedSttMap.clear();
    selectedCmpMap.addAll({'FG_CODE':'', 'FG_NAME': '품명 선택'});
    selectedSttMap.addAll({'STT_ID':'', 'STT_NM': '강종 선택'});

    var cmpList2 = await HomeApi.to.BIZ_DATA('L_BSS028').then((value) =>
    {
      value['DATAS'].insert(0, {'FG_CODE':'', 'FG_NAME': '품명 선택'}),

      cmpList.value = value['DATAS']
    });
    Get.log('위치 : $cmpList2');
    /// 작업위치
    var sttList2 = await HomeApi.to.BIZ_DATA('L_PRS010').then((value) =>
    {
      value['DATAS'].insert(0, {'STT_ID':'', 'STT_NM': '강종 선택'}),
      sttList.value = value['DATAS']
    });
    Get.log('$sttList2');
  }

  @override
  void onInit() {
    convert();
  }

  @override
  void onClose() {
  }

  @override
  void onReady() {
  }
}
