import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/dialog_widget.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:egu_industry/app/pages/facilityFirst/facility_first_modify_page.dart';
import 'package:egu_industry/app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


class FacilityFirstController extends GetxController {

  var textTitleController = TextEditingController();
  var textContentController = TextEditingController();
  var textFacilityController = TextEditingController();
  /// 수정 페이지--------------------------------------------------
  var modifyTextFacilityController = TextEditingController();
  var modifyTextTitleController = TextEditingController();
  var modifyTextContentController = TextEditingController();

  String modifyIrCode = '';
  Rx<DateTime> selectedDay = DateTime.now().obs; // 선택된 날짜
  RxList<String> insList = ['설비점검', '안전점검'].obs;
  RxString selectedIns = '설비점검'.obs;
  RxString selectedReadIns = '선택해주세요'.obs;
  RxString insCd = ''.obs;
  RxString insReadCd = ''.obs;
  RxList<String> urgencyList = ['보통', '긴급'].obs;
  RxString selectedUrgency = '보통'.obs;
  RxString selectedReadUrgency = '보통'.obs;
  RxString urgencyCd = ''.obs;
  RxString urgencyReadCd = ''.obs;
  RxList<dynamic> machList = [].obs;
  RxString selectedMach = '선택해주세요'.obs;
  RxMap<String, String> selectedMachMap = {'MACH_CODE':'', 'MACH_NAME': ''}.obs;
  RxInt selectedMachIndex = 0.obs;
  RxList<String> machCdList = [''].obs;
  RxString selectedMachCd = ''.obs;
  RxList<String> irfgList = [''].obs;
  RxString selectedIrFq = '선택해주세요'.obs;
  RxString selectedReadIrFq = '선택해주세요'.obs;
  RxString irfqCd = ''.obs;
  RxList<String> engineTeamList = [''].obs;
  RxString selectedEngineTeam = '전기팀'.obs;
  RxString selectedReadEngineTeam = '전기팀'.obs;
  RxString engineTeamCd = ''.obs;
  RxString engineTeamReadCd = ''.obs;
  RxString errorTime = ''.obs;
  RxString errorTime2 = ''.obs;
  RxBool isStep2RegistBtn = false.obs; // step2 정비등록 버튼 활성화

  RxString irFileCode = ''.obs; // 파일 저장을 위한 ir코드
  RxString pResultFg = 'A'.obs; /// A: 전체, N: 미조치, Y: 조치완료
  RxString filePath = ''.obs;
  RxString filePath2 = ''.obs;
  RxList<String> filePathList = [''].obs;





  RxString dayValue = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxString dayStartValue = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxString dayEndValue = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxInt choiceButtonVal = 1.obs;
  RxBool isShowCalendar = false.obs;
  RxInt datasLength = 0.obs;
  RxInt modifyDatasLength = 0.obs;
  RxList datasList = [].obs;
  RxList<dynamic> modifyDatasList = [].obs;
  RxList test = [].obs;
  RxBool registButton = false.obs;
  RxList selectedContainer = [].obs;
  RxList<String> engineerList = [''].obs;
  RxList<String> engineerIdList = [''].obs;
  RxString selectedEnginner = '정비자를 선택해주세요'.obs;
  RxInt selectedEnginnerIndex = 0.obs;
  RxList<String> resultFgList = ['전체','정비 진행중', '정비완료', '미조치'].obs;
  RxString selectedResultFg = '전체'.obs;
  RxString resultFgCd = ''.obs;
  RxList<String> noReasonList = [''].obs;
  RxString selectedNoReason = '전체'.obs;
  RxString noReasonCd = ''.obs;
  RxString rpUser = ''.obs;

  /// 수정 페이지 ----------------------------
  RxList<String> modifyInsList = ['설비점검', '안전점검'].obs;
  RxString modifyEngineTeamCd = ''.obs;
  RxString modifySelectedIns = '설비점검'.obs;
  RxString modifySelectedReadIns = '선택해주세요'.obs;
  RxString modifyInsCd = ''.obs;
  RxString modifyInsReadCd = ''.obs;
  RxList<String> modifyUrgencyList = ['보통', '긴급'].obs;
  RxString modifySelectedUrgency = '보통'.obs;
  RxString modifySelectedReadUrgency = '보통'.obs;
  RxString modifyUrgencyCd = ''.obs;
  RxList<dynamic> modifyMachList = [].obs;
  RxString modifySelectedMach = '선택해주세요'.obs;
  RxMap<String, String> modifySelectedMachMap = {'MACH_CODE':'', 'MACH_NAME': ''}.obs;
  RxList<String> modifyIrfgList = [''].obs;
  RxString modifySelectedIrFq = '선택해주세요'.obs;
  RxString modifySelectedReadIrFq = '선택해주세요'.obs;
  RxString modifyIrfqCd = ''.obs;
  RxString modifyErrorTime = ''.obs;
  RxString modifyErrorTime2 = ''.obs;
  RxList<String> modifyEngineerList = [''].obs;
  RxList<String> modifyEngineerIdList = [''].obs;
  RxString modifySelectedEnginner = '정비자를 선택해주세요'.obs;
  RxInt modifySelectedEnginnerIndex = 0.obs;
  RxList<String> modifyResultFgList = ['전체','정비 진행중', '정비완료', '미조치'].obs;
  RxString modifySelectedResultFg = '전체'.obs;
  RxString selectedCheckResultFg = '전체'.obs;
  RxList<String> resultIrFqList = ['전체','돌발정비', '예방정비'].obs; /// ////////////////////////////////////// //////////////////////////////////////
  RxString selectedCheckIrFg = '전체'.obs; /// ////////////////////////////////////// //////////////////////////////////////
  RxString modifyResultFgCd = ''.obs;
  RxBool isModifyErrorDateChoice = false.obs;
  RxList<String> modifyEngineTeamList = [''].obs;
  RxString modifySelectedEngineTeam = '전기팀'.obs;
  RxString modifySelectedReadEngineTeam = '전기팀'.obs;
  RxString modifyeEngineTeamCd = ''.obs;
  RxString modifyEngineTeamReadCd = ''.obs;
  /// --------------------------------------------------------------------------

  // 날짜를 선택했는지 확인
  RxBool bSelectedDayFlag = false.obs;
  RxBool bSelectedStartDayFlag = false.obs; // 작업 시작일 날짜
  RxBool bSelectedEndDayFlag = false.obs; // 작업 종료일 날짜

  RxBool isErrorDateChoice = false.obs;
  // Future<List> userIdNameList = HomeApi.to.BIZ_DATA('L_USER_001');

  void test2() async {
    await Get.dialog(CommonDialogWidget( contentText: '등록되었습니다.', pageFlag: 1,
    ));
  }
  Future<void> saveButton() async {
    var a = await HomeApi.to.PROC('USP_MBS0200_S01', {'@p_WORK_TYPE':'N', '@p_IR_CODE':''
      , '@p_INS_FG':insCd.value, '@p_MACH_CODE':selectedMachMap['MACH_CODE'], '@p_MACH_ETC':selectedMachMap['MACH_NAME'] == '전체' ? textFacilityController.text : '',
      '@p_IR_TITLE':textTitleController.text, '@p_IR_CONTENT':'${textContentController.text}', '@p_IR_USER':'admin',
      '@p_FAILURE_DT':errorTime.value, '@p_IR_FG':irfqCd.value, '@p_URGENCY_FG':urgencyCd.value,
      '@p_INS_DEPT':engineTeamCd.value, '@p_USER':'admin',});
    Get.log('신규등록 :::::::: $a');
    // irFileCode.value = a.toString();


    /// 사진파일 프로시저 추가해야함

  }
  Future<void> modifySaveButton() async {
    var a = await HomeApi.to.PROC('USP_MBS0200_S01', {'@p_WORK_TYPE':'U', '@p_IR_CODE': modifyIrCode
      , '@p_INS_FG':insCd.value, '@p_MACH_CODE':modifySelectedMachMap['MACH_CODE'], '@p_MACH_ETC': modifySelectedMachMap['MACH_NAME'] == '전체' ? modifyTextFacilityController.text : '',
      '@p_IR_TITLE':modifyTextTitleController.text, '@p_IR_CONTENT':'${modifyTextContentController.text}', '@p_IR_USER':'admin',
      '@p_FAILURE_DT': modifyErrorTime.value, '@p_IR_FG':modifyIrfqCd.value, '@p_URGENCY_FG': modifyUrgencyCd.value,
      '@p_INS_DEPT': modifyEngineTeamCd.value, '@p_USER':'admin',});
    Get.log('수정 :::::::: $a');
    // irFileCode.value = a.toString();


    /// 사진파일 프로시저 추가해야함

  }

  void modifyIrfqCdCv() {
    switch(modifyIrfqCd.value) {
      case "010":
        modifySelectedIrFq.value = '돌발 정비';
        break;
      case "020":
        modifySelectedIrFq.value = '예방정비';
        break;
      case "030":
        modifySelectedIrFq.value = '개조/개선';
        break;
      case "040":
        modifySelectedIrFq.value = '공사성(신설)';
        break;
      case "999":
        modifySelectedIrFq.value = '기타';
      default:
        modifySelectedIrFq.value = '돌발 정비';
    }

    switch(modifyEngineTeamCd.value) {
      case "1110":
        modifySelectedReadEngineTeam.value = '생산팀';
        break;
      case "1160":
        modifySelectedReadEngineTeam.value = '공무팀';
        break;
      case "1170":
        modifySelectedReadEngineTeam.value = '전기팀';
        break;
      case "9999":
        modifySelectedReadEngineTeam.value = '기타';
      default:
        modifySelectedReadEngineTeam.value = '전기팀';
    }
  }

  Future<void> convert() async{
    machList.clear();
    modifyMachList.clear();
    irfgList.clear();
    modifyIrfgList.clear();
    engineTeamList.clear();
    modifyEngineTeamList.clear();
    machCdList.clear();
    selectedMachMap.clear();
    modifySelectedMachMap.clear();
    irfgList.add('선택해주세요');
    modifyIrfgList.add('선택해주세요');
    selectedMachMap.addAll({'MACH_CODE':'00', 'MACH_NAME': '전체'});
    modifySelectedMachMap.addAll({'MACH_CODE':'00', 'MACH_NAME': '전체'});

    /// 설비
    var muc = await HomeApi.to.BIZ_DATA('L_MACH_001').then((value) =>
    {
     // Get.log('우웅ㅇ ${value}'),
      value['DATAS'].insert(0, {'MACH_CODE':'00', 'MACH_NAME': '전체'}),
      machList.value = value['DATAS'],
      modifyMachList.value = value['DATAS']
    });
    Get.log('설비 :  : : $muc');
    /// 정비유형
    var engineCategory = await HomeApi.to.BIZ_DATA('LCT_MR004').then((value) =>
    {
      //Get.log('우웅ㅇ ${value}'),
      for(var i = 0; i < value['DATAS'].length; i++) {
        irfgList.add(value['DATAS'][i]['TEXT'].toString()),
        modifyIrfgList.add(value['DATAS'][i]['TEXT'].toString()),
      }
    });

    /// 점검부서
    var engineTeam = await HomeApi.to.BIZ_DATA('LCT_MR006').then((value) =>
    {
      for(var i = 0; i < value['DATAS'].length; i++) {
        engineTeamList.add(value['DATAS'][i]['TEXT'].toString()),
        modifyEngineTeamList.add(value['DATAS'][i]['TEXT'].toString()),
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
    switch(modifySelectedIrFq.value) {
      case "돌발 정비":
        modifyIrfqCd.value = '010';
        break;
      case "예방정비":
        modifyIrfqCd.value = '020';
        break;
      case "개조/개선":
        modifyIrfqCd.value = '030';
        break;
      case "공사성(신설)":
        modifyIrfqCd.value = '040';
        break;
      case "기타":
        modifyIrfqCd.value = '999';
      default:
        modifyIrfqCd.value = '';
    }
    switch(selectedIns.value) {
      case "설비점검":
        insCd.value = 'M';
        break;
      case "안전점검":
        insCd.value = 'S';
        break;
      default:
        insCd.value = '';
    }
    switch(modifySelectedIns.value) {
      case "설비점검":
        modifyInsCd.value = 'M';
        break;
      case "안전점검":
        modifyInsCd.value = 'S';
        break;
      default:
        modifyInsCd.value = '';
    }
    switch(selectedReadUrgency.value) {
      case "보통":
        urgencyCd.value = 'N';
        break;
      case "긴급":
        urgencyCd.value = 'U';
        break;
      default:
        urgencyCd.value = '';
    }
    switch(modifySelectedReadUrgency.value) {
      case "보통":
        modifyUrgencyCd.value = 'N';
        break;
      case "긴급":
        modifyUrgencyCd.value = 'U';
        break;
      default:
        modifyUrgencyCd.value = '';
    }
    switch(selectedReadEngineTeam.value) {
      case "생산팀":
        engineTeamCd.value = '1110';
        break;
      case "공무팀":
        engineTeamCd.value = '1160';
        break;
      case "전기팀":
        engineTeamCd.value = '1170';
        break;
      case "기타":
        engineTeamCd.value = '9999';
      default:
        engineTeamCd.value = '';
    }
    switch(modifySelectedReadEngineTeam.value) {
      case "생산팀":
        modifyEngineTeamCd.value = '1110';
        break;
      case "공무팀":
        modifyEngineTeamCd.value = '1160';
        break;
      case "전기팀":
        modifyEngineTeamCd.value = '1170';
        break;
      case "기타":
        modifyEngineTeamCd.value = '9999';
      default:
        modifyEngineTeamCd.value = '';
    }
  }





  void step2RegistBtn() {
    if(selectedIrFq.value != '전체' && selectedResultFg.value != '전체'
        && selectedNoReason.value != '전체') {
      isStep2RegistBtn.value = true;
    }else {
      isStep2RegistBtn.value = false;
    }
  }

  void check() {
    HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${dayStartValue.value}','@p_IR_DATE_TO':'${dayEndValue.value}','@p_URGENCY_FG':'${urgencyReadCd.value}', '@p_INS_DEPT' : '${engineTeamReadCd.value}', '@p_RESULT_FG' : pResultFg.value}).then((value) =>
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
  }

  /// 선택된 설비/안전 조회 정보
  void modifyCheck() {
    HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q1', 'p_IR_CODE':'${selectedContainer[0]['IR_CODE']}'}).then((value) =>
    {
      Get.log('value[DATAS]: ${value['DATAS']}'),
      modifyDatasList.value = value['DATAS'],
      if(modifyDatasList.isNotEmpty) {
          modifyIrfqCd.value = modifyDatasList[0]['IR_FG'],
          modifyIrfqCdCv(),
        modifyDatasList[0]['MACH_ETC'] != null ?
        modifyTextFacilityController.text = modifyDatasList[0]['MACH_ETC'] :  modifyTextFacilityController.text = '',
        modifyEngineTeamCd.value = modifyDatasList[0]['INS_DEPT'],
        modifyIrCode = modifyDatasList[0]['IR_CODE'],
        modifyTextContentController.text = modifyDatasList[0]['IR_CONTENT'],
      },

      Get.log('modifyDatasList: $modifyDatasList'),
    });
  }




  @override
  void onInit() {
    readCdConvert();
    datasList.clear();
    HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${dayStartValue.value}','@p_IR_DATE_TO':'${dayEndValue.value}','@p_URGENCY_FG':'${urgencyReadCd.value}', '@p_INS_DEPT' : '${engineTeamReadCd.value}', '@p_RESULT_FG' : pResultFg.value}).then((value) =>
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
    convert();
  }

  @override
  void onClose() {}

  @override
  void onReady() {
  }
}
