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


class ProcessTransferController extends GetxController {
  RxList test = [].obs;
  RxList<String> movIds = [''].obs;
  RxList<dynamic> processList = [].obs;
  RxList<bool> isprocessSelectedList = [false].obs;
  RxList<dynamic> processSelectedList = [].obs;
  RxString dayValue = '날짜를 선택해주세요'.obs;
  RxString dayStartValue = '시작날짜'.obs;
  RxString dayEndValue = '마지막날짜'.obs;
  RxList<String> movYnList = ['선택해주세요','처리','미처리'].obs;
  RxString selectedMovYn = '선택해주세요'.obs;
  RxString selectedMovYnCd = ''.obs; // 처리: y, 미처리: n
  RxMap<String, String> selectedFkfNm = {'FKF_NO':'', 'FKF_NM': ''}.obs;
  RxMap<String, String> selectedSaveFkfNm = {'FKF_NO':'', 'FKF_NM': ''}.obs;
  RxMap<String, String> selectedMachMap = {'MACH_CODE':'', 'MACH_NAME': ''}.obs;
  RxList fkfNoList = [''].obs; // 위치 정보 리스트
  RxString selectedFkf = '선택해주세요'.obs;
  RxString selectedMach = '선택해주세요'.obs;
  RxList<dynamic> fkfList = [].obs;
  RxList<dynamic> machList = [].obs;
  RxBool registButton = false.obs;

  Future<void> convert() async {

  }

  Future<void> checkButton() async {
    movIds.clear();
    isprocessSelectedList.clear();
    processList.clear();
    var a = await HomeApi.to.PROC('USP_MBS0600_R01', {'@p_WORK_TYPE':'Q', '@p_DATE_FR': '$dayStartValue'
      , '@p_DATE_TO': '$dayEndValue', '@p_MOV_YN':'$selectedMovYnCd', '@p_FKF_NO':selectedFkfNm['FKF_NO'], '@p_FROM_MACH': selectedMachMap['MACH_CODE']}).then((value) =>
    {
      for(var i = 0; i < value['DATAS'].length; i++) {
        isprocessSelectedList.add(false)
      },
      processList.value = value['DATAS'],
      Get.log('aa ${processList.value}')

    });

    Get.log('공정이동 조회: $a');
  }



  Future<void> loactionConvert() async {
    fkfList.clear();
    machList.clear();
    selectedFkfNm.clear();
    selectedSaveFkfNm.clear();
    selectedMachMap.clear();
    selectedSaveFkfNm.addAll({'FKF_NO':'', 'FKF_NM': '선택해주세요'});
    selectedFkfNm.addAll({'FKF_NO':'', 'FKF_NM': '선택해주세요'});
    selectedMachMap.addAll({'MACH_CODE':'', 'MACH_NAME': '선택해주세요'});
    var fkfList2 = await HomeApi.to.BIZ_DATA('L_BSS032').then((value) =>
    {
      value['DATAS'].insert(0, {'FKF_NO':'', 'FKF_NM': '선택해주세요'}),

      fkfList.value = value['DATAS']
    });
    Get.log('위치 : $fkfList2');
    /// 작업위치
    var engineer = await HomeApi.to.BIZ_DATA('L_MACH_001').then((value) =>
    {
      value['DATAS'].insert(0, {'MACH_CODE':'', 'MACH_NAME': '선택해주세요'}),
      machList.value = value['DATAS']
    });
    Get.log('$engineer');
  }

  Future<void> saveButton(int index) async {
    var a = await HomeApi.to.PROC('USP_MBS0600_S01', {'@p_WORK_TYPE':'U', '@p_MOV_ID': movIds[index] // 리스트로는 안들어감.
      , '@p_FKF_NO': selectedSaveFkfNm['FKF_NO'], '@p_MOV_YN':'Y', '@p_USER':'admin'});

    Get.log('공정이동 저장: $a');
  }





  @override
  void onInit() {
    loactionConvert();
  }

  @override
  void onClose() {
  }

  @override
  void onReady() {
  }
}
