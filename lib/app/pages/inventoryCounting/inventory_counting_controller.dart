import 'package:egu_industry/app/net/home_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';



class InventoryCountingController extends GetxController {
  var textController = TextEditingController();

  RxString barcodeScanResult = '바코드를 스캔해주세요'.obs;
  Rx<DateTime> selectedDay = DateTime.now().obs; // 선택된 날짜
  RxString dayValue =  DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxBool bSelectedDayFlag = false.obs;
  RxBool isShowCalendar = false.obs;
  RxList productList = [].obs; // 제품 정보
  RxList<dynamic> locationList = [].obs; // 위치 정보 리스트
  RxList locationCdList = [''].obs; // 위치 정보 리스트
  RxString selectedLocation = '선택해주세요'.obs;
  RxMap<String, String> selectedCheckLocationMap = {'DETAIL_CD':'', 'DETAIL_NM': ''}.obs;
  RxMap<String, String> selectedSaveLocationMap = {'DETAIL_CD':'', 'DETAIL_NM': ''}.obs;
  RxBool isButton = false.obs;
  RxList<dynamic> machList = [].obs;
  RxMap<String, String> selectedMachMap = {'MACH_CODE':'', 'MACH_NAME': ''}.obs;




  /// 수정 필요 user 고정값 빼고 p_RACK_BARCODE도 여쭤보고 수정 /////// 바코드 유효성 검사도 여쭤봐야함
  Future<void> saveButton() async {
   var a = await HomeApi.to.PROC('USP_MBS0500_S01', {'@p_WORK_TYPE':'N', '@p_BARCODE_NO': textController.text
      , '@p_RACK_BARCODE': null, '@p_GUBUN':'${selectedCheckLocationMap['DETAIL_CD']}', '@p_USER':'admin'});
   Get.log('구구ㅜ : $a');
  }

  Future<void> loactionConvert() async {
    machList.clear();
    selectedMachMap.addAll({'MACH_CODE':'', 'MACH_NAME': '설비 선택'});
    locationList.clear();
    selectedSaveLocationMap.clear();
    selectedCheckLocationMap.clear();
    var location = await HomeApi.to.BIZ_DATA('L_BSS031').then((value) =>
    {
      selectedCheckLocationMap['DETAIL_CD'] =  value['DATAS'][1]['DETAIL_CD'],
      selectedCheckLocationMap['DETAIL_NM'] =  value['DATAS'][1]['DETAIL_NM'],
      locationList.value = value['DATAS']
    });
    Get.log('위치 : $locationList');
    var mach = await HomeApi.to.BIZ_DATA('L_MACH_001').then((value) =>
    {
      value['DATAS'].insert(0, {'MACH_CODE':'', 'MACH_NAME': '설비 선택'}),
      machList.value = value['DATAS']
    });
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
