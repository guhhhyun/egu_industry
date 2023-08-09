import 'package:egu_industry/app/net/home_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class InventoryCountingController extends GetxController {
  var textController = TextEditingController();

  Rx<DateTime> selectedDay = DateTime.now().obs; // 선택된 날짜
  RxString dayValue = '날짜를 선택해주세요'.obs;
  RxBool bSelectedDayFlag = false.obs;
  RxBool isShowCalendar = false.obs;
  RxList productList = [].obs; // 제품 정보
  RxList<dynamic> locationList = [].obs; // 위치 정보 리스트
  RxList locationCdList = [''].obs; // 위치 정보 리스트
  RxString selectedLocation = '선택해주세요'.obs;
  RxMap<String, String> selectedLocationMap = {'FKF_NO':'', 'FKF_NM': ''}.obs;
  RxBool isButton = false.obs;




  /// 수정 필요 user 고정값 빼고 p_RACK_BARCODE도 여쭤보고 수정
  Future<void> saveButton() async {
    await HomeApi.to.PROC('USP_MBS0500_S01', {'@p_WORK_TYPE':'N', '@p_BARCODE_NO': textController.text
      , '@p_RACK_BARCODE':'W01RA000000', '@p_GUBUN':'2', '@p_USER':'admin'});
  }

  Future<void> loactionConvert() async {
    locationList.clear();
    selectedLocationMap.clear();
    selectedLocationMap.addAll({'FKF_NO':'', 'FKF_NM': '선택해주세요'});
    var location = await HomeApi.to.BIZ_DATA('L_BSS030').then((value) =>
    {
      value['DATAS'].insert(0, {'FKF_NO':'', 'FKF_NM': '선택해주세요'}),

      locationList.value = value['DATAS']
    });
    Get.log('위치 : $locationList');
  }



  @override
  void onInit() {
    loactionConvert();
  }

  @override
  void onClose() {}

  @override
  void onReady() {
  }
}
