import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/dialog_widget.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:egu_industry/app/pages/dolbal/modal_part_list_widget.dart';
import 'package:egu_industry/app/pages/dolbal/modal_user_list_widget.dart';
import 'package:egu_industry/app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:table_calendar/table_calendar.dart';


class FacilityMonitoringController extends GetxController {

  RxList<String> gubun = ['선택해주세요', '400', '600'].obs;
  RxString selectedLine = '선택해주세요'.obs;
  RxString selectedLineCd = ''.obs;
  RxList<dynamic> monitoringList = [].obs;

  Future<void> checkButton() async {
    var a = await HomeApi.to.PROC('USP_MBR1000_R01', {'@p_WORK_TYPE':'Q', '@p_LINE':'${selectedLineCd.value}'}).then((value) =>
    {
      if(value['DATAS'] != null) {
        monitoringList.value = value['DATAS'],
      }
    });

    Get.log('공정 조회: $a');
  }



  Future<void> convert() async {
    switch(selectedLine.value) {
      case "400":
        selectedLineCd.value = '400';
        break;
      case "600":
        selectedLineCd.value = '600';
        break;
      default:
        selectedLineCd.value = '';
    }
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
