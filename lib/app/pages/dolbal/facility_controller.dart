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


class FacilityController extends GetxController {

  var textController = TextEditingController();
  var textContentController = TextEditingController();


  Rx<DateTime> selectedDay = DateTime.now().obs; // 선택된 날짜
  Rx<DateTime> selectedStartDay = DateTime.now().obs; // 선택된 날짜
  Rx<DateTime> selectedEndDay = DateTime.now().obs; // 선택된 날짜
  RxString dayValue = '날짜를 선택해주세요'.obs;
  RxString dayStartValue = '선택해주세요'.obs;
  RxString dayEndValue = '선택해주세요'.obs;
  RxInt choiceButtonVal = 0.obs;
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
  RxInt selectedEnginnerIndex = 0.obs;
  RxList<String> irfgList = [''].obs;
  RxString selectedIrFq = '선택해주세요'.obs;
  RxString irfqCd = ''.obs;
  RxList<String> resultFgList = ['전체','정비 진행중', '정비완료', '미조치'].obs;
  RxString selectedResultFg = '전체'.obs;
  RxString resultFgCd = ''.obs;
  RxList<String> noReasonList = [''].obs;
  RxString selectedNoReason = '선택해주세요'.obs;
  RxString noReasonCd = ''.obs;
  RxBool isStep2RegistBtn = false.obs; // step2 정비등록 버튼 활성화
  RxString rpUser = ''.obs;
  RxList<String> urgencyList = ['선택해주세요', '보통', '긴급'].obs;
  RxString selectedUrgency = '선택해주세요'.obs;
  RxString selectedReadUrgency = '선택해주세요'.obs;
  RxString urgencyReadCd = ''.obs;
  RxList<String> insList = ['선택해주세요', '설비점검', '안전점검'].obs;
  RxString selectedIns = '선택해주세요'.obs;
  RxString selectedReadIns = '선택해주세요'.obs;
  RxString insReadCd = ''.obs;
  RxList<String> engineTeamList = [''].obs;
  RxString selectedEngineTeam = '선택해주세요'.obs;
  RxString selectedReadEngineTeam = '선택해주세요'.obs;
  RxString engineTeamReadCd = ''.obs;
  RxList<bool> isEngineerSelectedList = [false].obs;
  RxList<String> engineerSelectedList = [''].obs;
  RxList partList = [].obs; // 부품리스트
  RxList<bool> isPartSelectedList = [false].obs;
  RxList partSelectedList = [].obs;
  RxList<int> partQtyList = [1].obs;
  RxList<int> partSelectedQtyList = [1].obs;
  RxList<String> machList = [''].obs;
  RxString selectedMach = '선택해주세요'.obs;
  RxInt selectedMachIndex = 0.obs;
  RxList<String> machCdList = [''].obs;
  RxString selectedMachCd = ''.obs;

  // 날짜를 선택했는지 확인
  RxBool bSelectedDayFlag = false.obs;
  RxBool bSelectedStartDayFlag = false.obs; // 작업 시작일 날짜
  RxBool bSelectedEndDayFlag = false.obs; // 작업 종료일 날짜



  Future<void> saveButton() async {
    await HomeApi.to.PROC('USP_MBS0300_S01', {'@p_WORK_TYPE':'N', '@p_RP_CODE':'', '@p_IR_CODE':'${selectedContainer[0]['IR_CODE']}'
      , '@p_IR_FG':'$irfqCd', '@p_MACH_CODE':'${selectedContainer[0]['MACH_CODE']}', '@p_RP_USER':rpUser.value,
      '@p_RP_CONTENT':textContentController.text, '@p_START_DT':'$dayStartValue', '@p_END_DT':'$dayEndValue',
      '@p_RESULT_FG':'$resultFgCd', '@p_NO_REASON':'$noReasonCd',
      '@p_RP_DEPT':'9999', '@p_USER':'admin',});

    // 부품 저장 프로시저
   /* await HomeApi.to.PROC('USP_MBS0300_S01', {'@p_WORK_TYPE':'PART_N', '@p_RP_CODE':'', '@p_ITEM_CODE':''
      , '@p_ITEM_NAME':'', '@p_ITEM_SPEC':'', '@p_USE_QTY':'',});*/

  }



  void clear() {
    partList.clear();
    partQtyList.clear();
    partSelectedQtyList.clear();
    isPartSelectedList.clear();
    textContentController.clear();
    dayStartValue.value = '선택해주세요';
    dayEndValue.value = '선택해주세요';
  }

  Future<void> partConvert(String machCode) async {
    var part = await HomeApi.to.PROC('USP_MBS0300_R01', {'@p_WORK_TYPE':'Q_PART',  '@p_MACH_CODE':'${selectedContainer[0]['MACH_CODE']}',}).then((value) =>
    {
      for(var i = 0; i < value['DATAS'].length; i++) {
        isPartSelectedList.add(false),
        partQtyList.add(1)
      },
      partList.addAll(value['DATAS']),
    });
    Get.log('part:  ${part}');
  }


  Future<void> irfgConvert() async{
    irfgList.clear();
    noReasonList.clear();
    engineerList.clear();
    machList.clear();
    engineerSelectedList.clear();
    isEngineerSelectedList.clear();
    engineerIdList.clear();
    engineTeamList.clear();
    irfgList.add('선택해주세요');
    noReasonList.add('선택해주세요');
    machList.add('선택해주세요');
    engineTeamList.add('선택해주세요');


    /// 정비자 리스트
    var engineer = await HomeApi.to.BIZ_DATA('L_USER_001').then((value) =>
    {
      for(var i = 0; i < value['DATAS'].length; i++) {
        engineerList.add(value['DATAS'][i]['USER_NAME'].toString()),
        engineerIdList.add(value['DATAS'][i]['USER_ID'].toString()),
        isEngineerSelectedList.add(false)
      }
    });
    /// 설비
    var engineer2 = await HomeApi.to.BIZ_DATA('L_MACH_001').then((value) =>
    {
      // Get.log('우웅ㅇ ${value}'),
      for(var i = 0; i < value['DATAS'].length; i++) {
        machList.add(value['DATAS'][i]['MACH_NAME']),
        machCdList.add(value['DATAS'][i]['MACH_CODE'].toString()),
      }
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
