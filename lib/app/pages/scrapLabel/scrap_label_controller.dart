import 'package:egu_industry/app/net/home_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class ScrapLabelController extends GetxController {
  var textController = TextEditingController();
  var weighingTextController = TextEditingController(); // 계근중량
  RxBool isLabelBtn = false.obs; // 라벨 발행


  RxMap<String, String> selectedIndustryMap = {'CODE':'', 'NAME': ''}.obs;
  RxMap<String, String> selectedScrapNmMap = {'CODE':'', 'NAME': ''}.obs;
  RxMap<String, String> selectedRmNmMap = {'CODE':'', 'NAME': ''}.obs;
  RxMap<String, String> selectedScLocMap = {'RACK_BARCODE':'', 'NAME': ''}.obs;
  RxMap<String, String> selectedTareMap = {'CODE':'', 'NAME': ''}.obs;
  RxList<dynamic> industryList = [].obs;
  RxList<dynamic> scrapNmList = [].obs;
  RxList<dynamic> rmNmList = [].obs;
  RxList<dynamic> scLocList = [].obs;
  RxList<dynamic> tareList = [].obs;
  RxList<String> scrapGubunList = ['선택해주세요', '스크랩', '지금류'].obs; // 하드코딩 하는건가 흠
  RxString selectedGubun = '선택해주세요'.obs;
  RxList<String> scrapTypeList = ['선택해주세요', '매입', '공정회수', '외주'].obs;
  RxString selectedScrapType = '선택해주세요'.obs;
  RxList<String> goldList = ['선택해주세요', '무도금', '도금', '박리'].obs;
  RxString selectedGold = '선택해주세요'.obs;
  RxList meansNumList = [].obs;
  RxBool isCheck = false.obs;


  Future<void> checkButton() async {
    var a = await HomeApi.to.PROC('USP_SCS0300_R01', {'@p_WORK_TYPE':'Q_MEAS', '@p_MEAS_NO': ''}).then((value) =>
    {
      meansNumList.value = value['DATAS']
    });

    Get.log('계량번호 조회: $a');
  }

  Future<void> convert() async {
    selectedScLocMap.clear();
    selectedScLocMap.addAll({'RACK_BARCODE':'', 'NAME': '선택해주세요'}); // 적재위치

    selectedIndustryMap.clear();
    selectedIndustryMap.addAll({'CODE':'', 'NAME': '선택해주세요'});

    var a = await HomeApi.to.PROC('USP_SCS0300_R01', {'@p_WORK_TYPE':'Q_PROC'}).then((value) => // 공정정보
    {
      value['DATAS'].insert(0, {'CODE':'', 'NAME': '선택해주세요'}),
      industryList.value = value['DATAS'],
    });
    Get.log('공장정보::::: $a');
    selectedScrapNmMap.clear();
    selectedScrapNmMap.addAll({'CODE':'', 'NAME': '선택해주세요'});
    var b = await HomeApi.to.PROC('USP_SCS0300_R01', {'@p_WORK_TYPE':'Q_ITEM', '@p_WHERE1':'SC'}).then((value) => // 스크랩품명
    {
      value['DATAS'].insert(0, {'CODE':'', 'NAME': '선택해주세요'}),
      scrapNmList.value = value['DATAS'],
    });
    Get.log('스크랩품명::::: $b');
    selectedRmNmMap.clear();
    selectedRmNmMap.addAll({'CODE':'', 'NAME': '선택해주세요'});
    var c = await HomeApi.to.PROC('USP_SCS0300_R01', {'@p_WORK_TYPE':'Q_ITEM', '@p_WHERE1':'RM'}).then((value) => // 지금류품명
    {
      value['DATAS'].insert(0, {'CODE':'', 'NAME': '선택해주세요'}),
      rmNmList.value = value['DATAS'],
    });
    Get.log('지금류품명::::: $c');
    selectedTareMap.clear();
    selectedTareMap.addAll({'CODE':'', 'NAME': '선택해주세요'});
    /*var d = await HomeApi.to.PROC('USP_SCS0300_R01', {'@p_WORK_TYPE':'Q_TARE'}).then((value) => // 설통번호
    {
      value['DATAS'].insert(0, {'CODE':'', 'NAME': '선택해주세요'}),
      tareList.value = value['DATAS'],
    });
    Get.log('설통번호::::: $c');*/
  }


  @override
  void onInit() {
    convert();
  }

  @override
  void onClose() {}

  @override
  void onReady() {
  }
}
