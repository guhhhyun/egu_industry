import 'package:egu_industry/app/net/home_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class ProductLocationController extends GetxController {
  var textController = TextEditingController();


  RxList productList = [].obs; // 제품 정보
  RxList<dynamic> locationList = [].obs; // 위치 정보 리스트
  RxList locationCdList = [''].obs; // 위치 정보 리스트
  RxString selectedLocation = '선택해주세요'.obs;
  RxMap<String, String> selectedLocationMap = {'RACK_BARCODE':'', 'AREA': ''}.obs;
  RxBool isButton = false.obs;
  RxBool isBcCode = false.obs;
  RxString barcodeScanResult = '바코드를 스캔해주세요'.obs;


  Future<void> checkButton() async {
    var a = await HomeApi.to.PROC('USP_MBS0400_R01',
        {'@p_WORK_TYPE': 'Q', '@p_BARCODE_NO': textController.text}).then((value) =>
    {
      if(value['DATAS'] != null) {
        productList.value = value['DATAS'],
          /*if(value['DATAS']['BARCODE_NO'] != null) {
            isBcCode.value = true
          }else {
            isBcCode.value = false
          }*/
      }
    });
    Get.log('바코드 조회 쿼리: $a');
    if(productList.isNotEmpty) {
      isBcCode.value = true;
    }else {
      isBcCode.value = false;
    }
  }

  /// 수정 필요 user 고정값 빼고 p_RACK_BARCODE도 여쭤보고 수정
  Future<void> saveButton() async {
    var a = await HomeApi.to.PROC('USP_MBS0400_S01', {'@p_WORK_TYPE':'U', '@p_BARCODE_NO': textController.text
      , '@p_RACK_BARCODE':selectedLocationMap['RACK_BARCODE'], '@p_USER':'admin'});
    Get.log('이동 결과: ${a}');
  }

  Future<void> loactionConvert() async {

    locationList.clear();
    selectedLocationMap.clear();
    selectedLocationMap.addAll({'RACK_BARCODE':'', 'AREA': '선택해주세요'});
    var location = await HomeApi.to.BIZ_DATA('L_BSS030').then((value) =>
    {
      value['DATAS'].insert(0, {'RACK_BARCODE':'', 'AREA': '선택해주세요'}),
      locationList.value = value['DATAS'],

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
