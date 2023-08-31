import 'package:egu_industry/app/net/home_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class ScrapLabelController extends GetxController {
  var textController = TextEditingController();
  var weighingTextController = TextEditingController(); // 계근중량
  var qtyTextController = TextEditingController(); // 수량
  var partWeiTextController = TextEditingController(); // 단위중량
  var weighingInfoTextController = TextEditingController(); // 계량정보
  var otherScrapTextController = TextEditingController(); // 외주스크랩
  RxBool isLabelBtn = false.obs; // 라벨 발행


  RxString barcodeScanResult = '바코드를 스캔해주세요'.obs; /// 외주 스크랩
  RxString barcodeScanResult2 = '바코드를 스캔해주세요'.obs; /// 계량정보
  RxMap<String, String> selectedIndustryMap = {'CODE':'', 'NAME': ''}.obs;
  RxMap<String, String> selectedScrapNmMap = {'CODE':'', 'NAME': ''}.obs;
  RxMap<String, String> selectedRmNmMap = {'CODE':'', 'NAME': ''}.obs;
  RxMap<String, String> selectedScLocMap = {'RACK_BARCODE':'', 'NAME': ''}.obs;
  RxMap<String, String> selectedTareMap = {'CODE':'', 'NAME': '', 'WEIGHT': ''}.obs;
  RxList<dynamic> industryList = [].obs;
  RxList<dynamic> scrapNmList = [].obs;
  RxList<dynamic> rmNmList = [].obs;
  RxList<dynamic> scLocList = [].obs;
  RxList<dynamic> tareList = [].obs;
  RxList<dynamic> measList = [].obs;
  RxList<dynamic> outScrapList = [].obs;
  RxList<String> scrapGubunList = ['선택해주세요', '스크랩', '지금류'].obs; // 하드코딩 하는건가 흠
  RxString selectedGubun = '선택해주세요'.obs;
  RxList<String> scrapTypeList = ['선택해주세요', '매입', '공정회수', '외주'].obs;
  RxString selectedScrapType = '선택해주세요'.obs;
  RxList<String> goldList = ['선택해주세요', '무도금', '도금', '박리'].obs;
  RxString selectedGold = '선택해주세요'.obs;
  RxList meansNumList = [].obs;
  RxBool isCheck = false.obs;
  RxString matlGb = ''.obs;
  RxString scrapFg = ''.obs;


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
    selectedTareMap.addAll({'CODE':'', 'NAME': '설통번호 선택', 'WEIGHT': ''});
    var d = await HomeApi.to.PROC('USP_SCS0300_R01', {'@p_WORK_TYPE':'Q_SLT'}).then((value) => // 설통번호
    {
      value['DATAS'].insert(0, {'CODE':'', 'NAME': '설통번호 선택', 'WEIGHT':'' }),
      tareList.value = value['DATAS'],
    });
    Get.log('설통번호::::: $d'); // 값 x
  }

  void checkLogic() {
    if(selectedGubun.value == '지금류') {
      if(measList.isNotEmpty && selectedRmNmMap['NAME'] != '선택해주세요' && selectedScLocMap['NAME'] != '선택해주세요'
        && qtyTextController.text != '' && partWeiTextController.text != ''){
        isLabelBtn.value = true;
      }else {
        isLabelBtn.value = false;
      }
    }else if(selectedGubun.value == '스크랩') {
      switch(selectedScrapType.value) {
        case "매입":
          scrapFg.value = 'DD';
          if(measList.isNotEmpty && selectedGold.value != '선택해주세요' && selectedScrapNmMap['NAME'] != '선택해주세요'
            && selectedScLocMap['NAME'] != '선택해주세요' && weighingTextController.text != ''
            && selectedTareMap['WEIGHT'] != ''){
            isLabelBtn.value = true;
          }else {
            isLabelBtn.value = false;
          }
          break;
        case "공정회수":
          if(selectedIndustryMap['NAME'] == '[미노면삭(WK220), 이쿠다면삭(WK410)]') {
            scrapFg.value = 'BB';
          }else {
            scrapFg.value = 'CC';
          }
          if(selectedIndustryMap['NAME'] != '선택해주세요' && selectedGold.value != '선택해주세요' && selectedScrapNmMap['NAME'] != '선택해주세요'
              && selectedScLocMap['NAME'] != '선택해주세요' && weighingTextController.text != ''
              && selectedTareMap['WEIGHT'] != ''){
            isLabelBtn.value = true;
          }else {
            isLabelBtn.value = false;
          }
          break;
        case "외주":
          /*scrapFg.value = '${outScrapList[0]['SCRAP_FG']}';
          if(selectedGold.value == '도금') {
            scrapFg.value = 'F1';
          }else if(selectedGold.value == '박리') {
            scrapFg.value = 'FF';
          }else if(selectedGold.value == '무도금') {
            scrapFg.value = 'DD';
          }*/
          if(measList.isNotEmpty && selectedGold.value != '선택해주세요' && selectedScrapNmMap['NAME'] != '선택해주세요'
              && selectedScLocMap['NAME'] != '선택해주세요' && weighingTextController.text != ''
              && selectedTareMap['WEIGHT'] != '' && outScrapList.isNotEmpty){
            isLabelBtn.value = true;
          }else {
            isLabelBtn.value = false;
          }
          break;
        default:
          break;
      }
    }
  }
  /// 지금류
  /*EXEC USP_SCS0300_S01
  @p_WORK_TYPE = 'N_SCR', @p_MATL_GB = '구분선택값',
  @P_SCRAP_FG = 'AA' , @p_ITEM_CODE = '지금류품목코드',
  @P_CST_ID ='계량 거래처코드',@p_CST_NAME ='계량 거래처명',
  @P_MEAS_NO = '계량번호', @p_WEIGHT = 차감중량,
  @P_QTY = 수량, @p_UNIT_WEIGHT = 단위중량,
  @P_WH_NO = 'WH02',
  @p_RACK_BARCODE = '적재위치 RACK_BARCODE',
  @p_USER_ID = '로그인 사용자 ID’,
  @p_result_row_count = @p_result_row_count OUTPUT,
  @p_return_message = @p_return_message OUTPUT*/

  /// 스크랩
 /* EXEC USP_SCS0300_S01
  @p_WORK_TYPE = 'N_SCR', @p_MATL_GB = '구분선택값',
  @p_SCRAP_TYPE = '유형선택값',
  @P_SCRAP_FG = 유형이 외주 시 외주 스크랩 스캔값의 SCRAP_FG설정. 그 외 도금의 선택이 [도금]일 경우 'F1', [박리] 'FF', [무도금]일 경우 유형이 [매입]일 경우 'DD', [공정회수] 선택시 공정정보가 [미노면삭(WK220), 이쿠다면삭(WK410)] 일 경우 'BB', 그외 'CC' ,  저장 전 해당 값이 없으면 오류 발생,
  @p_ITEM_CODE = '지금류품목코드',
  @p_PROC_CODE = '공정정보 선택코드'
  @P_CST_ID ='계량 거래처코드',@p_CST_NAME ='계량 거래처명',
  @P_MEAS_NO = '계량번호', @p_PLATE_FG = '도금 선택값',
  @p_TARE_NO = '설통번호', @p_TARE_WEIGHT = 설통중량,
  @p_WEIGH_WEIGHT = 계근중량,
  @p_WEIGHT = 차감중량, @P_WH_NO = 'WH04',
  @p_RACK_BARCODE = '적재위치 RACK_BARCODE',
  @p_OUTS_NO = '외주스크랩’,
  @p_USER_ID = '로그인 사용자 ID’,
  @p_result_row_count = @p_result_row_count OUTPUT,
  @p_return_message = @p_return_message OUTPUT*/


  // 지금류 라벨발행
  Future<void> saveButton() async {
    var a = await HomeApi.to.PROC('USP_SCS0300_S01', {'@p_WORK_TYPE':'N_SCR', '@p_MATL_GB': '${matlGb}',
      '@P_SCRAP_FG':'AA', '@p_ITEM_CODE':'${selectedRmNmMap['CODE']}', '@P_CST_ID':'${measList[0]['CST_ID']}'
      , '@p_CST_NAME' : '${measList[0]['CUST_NM']}', '@P_MEAS_NO' : weighingInfoTextController.text, '@p_WEIGHT' : '${int.parse(qtyTextController.text) * int.parse(partWeiTextController.text)}',
      '@P_QTY' : qtyTextController.text, '@p_UNIT_WEIGHT' : partWeiTextController.text, '@P_WH_NO' : 'WH02',
      '@p_RACK_BARCODE' : '${selectedScLocMap['RACK_BARCODE']}', '@p_USER_ID' : 'admin'}).then((value) =>
    {
      Get.log('라밸 성공::::::::::: $value')
    });
  }

  // 스크랩 라벨발행
  Future<void> scrapSaveButton() async {
    var a = await HomeApi.to.PROC('USP_SCS0300_S01', {'@p_WORK_TYPE':'N_SCR', '@p_MATL_GB': '${matlGb}', '@p_SCRAP_TYPE': '',
      '@P_SCRAP_FG':'AA', '@p_ITEM_CODE':'', '@p_PROC_CODE': '', '@P_CST_ID':'${measList[0]['CST_ID']}', '@p_CST_NAME' : '${measList[0]['CUST_NM']}'
      , '@P_MEAS_NO' : weighingInfoTextController.text, '@p_PLATE_FG' : '', '@p_TARE_NO' : '', '@p_TARE_WEIGHT' : '',
      '@p_WEIGH_WEIGHT' : '', '@p_OUTS_NO' : '', '@P_WH_NO' : 'WH04',
      '@p_RACK_BARCODE' : '${selectedScLocMap['RACK_BARCODE']}', '@p_USER_ID' : 'admin'}).then((value) =>
    {
      Get.log('라밸 성공::::::::::: $value')
    });
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
