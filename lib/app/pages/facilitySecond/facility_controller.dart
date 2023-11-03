import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/dialog_widget.dart';
import 'package:egu_industry/app/common/utils.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:egu_industry/app/pages/facilitySecond/modal_part_list_widget.dart';
import 'package:egu_industry/app/pages/facilitySecond/modal_user_list_widget.dart';
import 'package:egu_industry/app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


class FacilityController extends GetxController {

  var textController = TextEditingController();
  var textContentController = TextEditingController();
  var textItemNameController = TextEditingController();
  var textItemSpecController = TextEditingController();


  RxInt otherPartQty = 1.obs;
  Rx<DateTime> selectedDay = DateTime.now().obs; // 선택된 날짜
  Rx<DateTime> selectedStartDay = DateTime.now().obs; // 선택된 날짜
  Rx<DateTime> selectedEndDay = DateTime.now().obs; // 선택된 날짜
  RxString dayValue = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxString step1DayStartValue = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxString step1DayEndValue = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxString dayStartValue = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxString dayEndValue = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxInt choiceButtonVal = 1.obs;
  RxBool isShowCalendar = false.obs;
  RxString pResultFg = 'A'.obs; /// A: 전체, N: 미조치, Y: 조치완료
  RxInt datasLength = 0.obs;
  RxList datasList = [].obs;
  RxList test = [].obs;
  RxBool registButton = false.obs;
  RxList selectedContainer = [].obs;
  RxList<String> engineerList = [''].obs;
  RxList<String> engineerIdList = [''].obs;
  RxString selectedEnginner = '정비자를 선택해주세요'.obs;
  RxString selectedEnginnerCd = ''.obs;
  RxInt selectedEnginnerIndex = 0.obs;
  RxList<String> irfgList = [''].obs;
  RxString selectedIrFq = '선택해주세요'.obs;
  RxString irfqCd = ''.obs;
  RxList<String> resultFgList = ['전체','정비 진행중', '정비완료', '미조치'].obs;
  RxString selectedResultFg = '전체'.obs;
  RxString selectedCheckResultFg = '전체'.obs;
  RxList<String> resultIrFqList = ['돌발정비', '예방정비'].obs; /// ////////////////////////////////////// //////////////////////////////////////
  RxString selectedCheckIrFg = '돌발정비'.obs; /// ////////////////////////////////////// //////////////////////////////////////
  RxString irFgCd = '010'.obs; /// ////////////////////////////////////// //////////////////////////////////////
  RxString resultFgCd = ''.obs;
  RxList<String> noReasonList = [''].obs;
  RxString selectedNoReason = '선택해주세요'.obs;
  RxString noReasonCd = ''.obs;
  RxBool isStep2RegistBtn = false.obs; // step2 정비등록 버튼 활성화
  RxString rpUser = ''.obs;
  RxList<String> urgencyList = ['전체','보통', '긴급'].obs;
  RxString selectedUrgency = '보통'.obs;
  RxString selectedReadUrgency = '전체'.obs;
  RxString urgencyReadCd = ''.obs;
  RxList<String> insList = ['선택해주세요', '설비점검', '안전점검'].obs;
  RxString selectedIns = '선택해주세요'.obs;
  RxString selectedReadIns = '선택해주세요'.obs;
  RxString insReadCd = ''.obs;
  RxList<String> engineTeamList = [''].obs;
  RxString selectedEngineTeam = '선택해주세요'.obs;
  RxString selectedReadEngineTeam = '전체'.obs;
  RxString engineTeamReadCd = ''.obs;
  RxList<bool> isEngineerSelectedList = [false].obs;
  RxList<dynamic> engineerSelectedList = [].obs;
  RxList partList = [].obs; // 부품리스트
  RxList<bool> isPartSelectedList = [false].obs;
  RxList partSelectedList = [].obs;
  RxList<int> partQtyList = [1].obs;
  RxList<int> partSelectedQtyList = [1].obs;
  RxList<dynamic> otherPartList = [].obs;
 // RxMap<String, String> otherPartMap = {'ITEM_SPEC':'', 'ITEM_NAME': '', 'QTY': ''}.obs;
  RxList<dynamic> machList = [].obs;
  RxString selectedMach = '선택해주세요'.obs;
  RxInt selectedMachIndex = 0.obs;
  RxMap<String, String> selectedMachMap = {'MACH_CODE':'', 'MACH_NAME': ''}.obs;
  RxList<String> machCdList = [''].obs;
  RxString selectedMachCd = ''.obs;
  RxList<dynamic> engineer2List = [].obs;


  // 날짜를 선택했는지 확인
  RxBool bSelectedDayFlag = false.obs;
  RxBool bSelectedStartDayFlag = false.obs; // 작업 시작일 날짜
  RxBool bSelectedEndDayFlag = false.obs; // 작업 종료일 날짜


  /// 정비자랑
  Future<void> saveButton() async {
    var a = await HomeApi.to.PROC('USP_MBS0300_S01', {'@p_WORK_TYPE':'N', '@p_RP_CODE':'', '@p_IR_CODE':'${selectedContainer[0]['IR_CODE']}'
      , '@p_IR_FG':'$irfqCd', '@p_MACH_CODE':'${selectedContainer[0]['MACH_CODE']}', '@p_RP_USER':selectedEnginnerCd.value,
      '@p_RP_CONTENT':textContentController.text, '@p_START_DT':'$dayStartValue', '@p_END_DT':'$dayEndValue',
      '@p_RESULT_FG':'$resultFgCd', '@p_NO_REASON':'$noReasonCd',
      '@p_RP_DEPT':'9999', '@p_USER':'admin',});
    var b = a['DATAS'][0].toString().replaceFirst('{: ', '').replaceFirst('}', '');

    Get.log('저장 결과값::::: ${a['DATAS'][0].toString().replaceFirst('{: ', '').replaceFirst('}', '')}');

    // 부품 저장 프로시저
    if(partSelectedList.isNotEmpty) {
      for(var i = 0; i < partSelectedList.length; i++) {
        await HomeApi.to.PROC('USP_MBS0300_S01', {'@p_WORK_TYPE':'PART_N', '@p_RP_CODE':b, '@p_ITEM_CODE':'${partSelectedList[i]['ITEM_CODE']}'
          , '@p_ITEM_NAME':'${partSelectedList[i]['ITEM_NAME']}', '@p_ITEM_SPEC':'${partSelectedList[i]['ITEM_SPEC']}', '@p_USE_QTY':'${partSelectedQtyList[i]}',});
      }
    }
    if(otherPartList.isNotEmpty) {
      for(var i = 0; i < otherPartList.length; i++) {
        await HomeApi.to.PROC('USP_MBS0300_S01', {'@p_WORK_TYPE':'PART_N', '@p_RP_CODE':b, '@p_ITEM_CODE':''
          , '@p_ITEM_NAME':'${otherPartList[i]['ITEM_NAME']}', '@p_ITEM_SPEC':'${otherPartList[i]['ITEM_SPEC']}', '@p_USE_QTY':'${otherPartList[i]['QTY']}',});
      }
    }
   /* await HomeApi.to.PROC('USP_MBS0300_S01', {'@p_WORK_TYPE':'PART_N', '@p_RP_CODE':'', '@p_ITEM_CODE':''
      , '@p_ITEM_NAME':'', '@p_ITEM_SPEC':'', '@p_USE_QTY':'',});*/

  }



  void clear() {
    partList.clear();
    partQtyList.clear();
    partSelectedQtyList.clear();
    isPartSelectedList.clear();
    textContentController.clear();
    dayStartValue.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
    dayEndValue.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  Future<void> partConvert(String machCode) async {
    var part = await HomeApi.to.PROC('USP_MBS0300_R01', {'@p_WORK_TYPE':'Q_PART',  '@p_MACH_CODE':'${selectedContainer[0]['MACH_CODE']}',}).then((value) =>
    {
      if(value['DATAS'] != null) {
        for(var i = 0; i < value['DATAS'].length; i++) {
          isPartSelectedList.add(false),
          partQtyList.add(1),
          partList.addAll(value['DATAS']),
        },
      },
    });
    Get.log('part:  ${part}');
  }


  Future<void> irfgConvert() async{
    irfgList.clear();
    noReasonList.clear();
    engineer2List.clear();
    engineerList.clear();
    machList.clear();
    engineerSelectedList.clear();
    isEngineerSelectedList.clear();
    engineerIdList.clear();
    engineTeamList.clear();
    engineTeamList.add('전체');
    irfgList.add('선택해주세요');
    noReasonList.add('선택해주세요');

    try{
      /// 정비자 리스트
      var engineer = await HomeApi.to.BIZ_DATA('L_USER_001').then((value) =>
      {
        for(var i = 0; i < value['DATAS'].length; i++) {

          engineerList.add(value['DATAS'][i]['USER_NAME'].toString()),
          engineerIdList.add(value['DATAS'][i]['USER_ID'].toString()),
          isEngineerSelectedList.add(false)
        },
        engineer2List.value = value['DATAS'],
      });
      /// 설비
      var engineer2 = await HomeApi.to.BIZ_DATA('L_MACH_001').then((value) =>
      {
        // Get.log('우웅ㅇ ${value}'),
        machList.value = value['DATAS']
      });
      Get.log('이거봥 ${engineer2}');
      var test = await HomeApi.to.BIZ_DATA('LCT_MR004').then((value) =>
      {
        for(var i = 0; i < value['DATAS'].length; i++) {
          irfgList.add(value['DATAS'][i]['TEXT'].toString()),
        }
      });

      var test2 = await HomeApi.to.BIZ_DATA('LCT_MR112').then((value) =>
      {
        for(var i = 0; i < value['DATAS'].length; i++) {
          noReasonList.add(value['DATAS'][i]['TEXT'].toString()),
        }
      });
      /// 점검부서
      var engineTeam = await HomeApi.to.BIZ_DATA('LCT_MR006').then((value) =>
      {
        //Get.log('우웅ㅇ ${value}'),
        for(var i = 0; i < value['DATAS'].length; i++) {
          engineTeamList.add(value['DATAS'][i]['TEXT'].toString()),
        }
      });
    }catch(err) {
      Utils.gErrorMessage('네트워크 오류');
    }

  }

  void readCdConvert() {
    switch(selectedReadUrgency.value) {
      case "보통":
        urgencyReadCd.value = 'N';
        break;
      case "긴급":
        urgencyReadCd.value = 'U';
        break;
      default:
        urgencyReadCd.value = '';
    }
    switch(selectedReadEngineTeam.value) {
      case "생산팀":
        engineTeamReadCd.value = '1110';
        break;
      case "공무팀":
        engineTeamReadCd.value = '1160';
        break;
      case "전기팀":
        engineTeamReadCd.value = '1170';
        break;
      case "기타":
        engineTeamReadCd.value = '9999';
      default:
        engineTeamReadCd.value = '';
    }
  }

  void cdConvert() {
    switch(selectedIrFq.value) {
      case "돌발 정비":
        irfqCd.value = '010';
        break;
      case "예방정비":
        irfqCd.value = '020';
        break;
      case "개조/개선":
        irfqCd.value = '030';
        break;
      case "공사성(신설)":
        irfqCd.value = '040';
        break;
      case "기타":
        irfqCd.value = '999';
      default:
        irfqCd.value = '';
    }
    switch(selectedResultFg.value) {
      case "정비 진행중":
        resultFgCd.value = 'I';
        break;
      case "정비완료":
        resultFgCd.value = 'Y';
        break;
      case "미조치":
        resultFgCd.value = 'N';
        break;
      default:
        resultFgCd.value = '';
    }
    switch(selectedNoReason.value) {
      case "부품재고 없음":
        noReasonCd.value = 'A01';
        break;
      case "내부정비불가":
        noReasonCd.value = 'A02';
        break;
      case "담당자부재":
        noReasonCd.value = 'A03';
        break;
      case "협력사 AS요청":
        noReasonCd.value = 'A04';
        break;
      case "기타":
        noReasonCd.value = 'Z99';
      default:
        noReasonCd.value = '';
    }
  }

  void step2RegistBtn() {
    if(selectedIrFq.value != '선택해주세요' && selectedResultFg.value != '전체'
        && selectedNoReason.value != '선택해주세요') {
      isStep2RegistBtn.value = true;
    }else {
      isStep2RegistBtn.value = false;
    }
  }

  void showModalUserChoice({required BuildContext context}) {
    Get.log('showModalUserChoice');

    Get.bottomSheet(
        backgroundColor: Colors.white,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25.0), topLeft: Radius.circular(25.0))),
        ModalUserListWidget()
    );
  }
  void showModalPartChoice({required BuildContext context}) {
    Get.log('showModalUserChoice');

    Get.bottomSheet(
        backgroundColor: Colors.white,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25.0), topLeft: Radius.circular(25.0))),
        ModalPartListWidget()
    );
  }




  @override
  void onInit() {
    readCdConvert();
    datasList.clear();
    HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${step1DayStartValue.value}','@p_IR_DATE_TO':'${step1DayEndValue.value}','@p_URGENCY_FG':'${urgencyReadCd.value}'
      , '@p_INS_DEPT' : '${engineTeamReadCd.value}', '@p_RESULT_FG' : pResultFg.value, '@p_IR_FG' : irFgCd.value}).then((value) =>
    {
      Get.log('value[DATAS]: ${value['DATAS']}'),
      if(value['DATAS'] != null) {
        datasLength.value = value['DATAS'].length,
        for(var i = 0; i < datasLength.value; i++){
          datasList.add(value['DATAS'][i]),
        },
      },
      Get.log('datasList: ${datasList}'),
    });
    irfgConvert();
    clear();
  }

  @override
  void onClose() {
  }

  @override
  void onReady() {
    datasList.clear();
  }
}
