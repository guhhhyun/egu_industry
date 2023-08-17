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


class ProcessCheckController extends GetxController {

  RxList<String> gubun = ['선택해주세요', '작업조회(400)', '작업조회(600)', '비가동내역'].obs;
  RxString selectedGubun = '선택해주세요'.obs;
  RxString selectedGubunCd = ''.obs;
  RxList<dynamic> processList = [].obs;

  Future<void> checkButton() async {
    var a = await HomeApi.to.PROC('USP_MBR0800_R01', {'@p_WORK_TYPE':'Q', '@p_GUBUN':'${selectedGubunCd.value}'}).then((value) =>
    {
      if(value['DATAS'] != null) {
        processList.value = value['DATAS'],
      }
    });

    Get.log('공정 조회: $a');
  }



  Future<void> convert() async {
    switch(selectedGubun.value) {
      case "작업조회(400)":
        selectedGubunCd.value = '400';
        break;
      case "작업조회(600)":
        selectedGubunCd.value = '600';
        break;
      case "비가동내역":
        selectedGubunCd.value = 'N';
        break;
      default:
        selectedGubunCd.value = '';
    }
  }

  @override
  void onInit() {
  }

  @override
  void onClose() {
  }

  @override
  void onReady() {
  }
}
