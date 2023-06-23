import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/dialog_widget.dart';
import 'package:egu_industry/app/net/home_api.dart';
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
  RxString dayStartValue = '시작 날짜를 선택해주세요'.obs;
  RxString dayEndValue = '종료 날짜를 선택해주세요'.obs;
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
  RxInt selectedEnginnerIndex = 0.obs;
  RxList<String> irfgList = [''].obs;
  RxString selectedIrFq = '전체'.obs;
  RxString irfqCd = ''.obs;
  RxList<String> resultFgList = ['전체','정비 진행중', '정비완료', '미조치'].obs;
  RxString selectedResultFg = '전체'.obs;
  RxString resultFgCd = ''.obs;
  RxList<String> noReasonList = [''].obs;
  RxString selectedNoReason = '전체'.obs;
  RxString noReasonCd = ''.obs;
  RxBool isStep2RegistBtn = false.obs; // step2 정비등록 버튼 활성화
  RxString rpUser = ''.obs;

  // 날짜를 선택했는지 확인
  RxBool bSelectedDayFlag = false.obs;
  RxBool bSelectedStartDayFlag = false.obs; // 작업 시작일 날짜
  RxBool bSelectedEndDayFlag = false.obs; // 작업 종료일 날짜
 // Future<List> userIdNameList = HomeApi.to.BIZ_DATA('L_USER_001');

  void test2() async {
    await Get.dialog(CommonDialogWidget(title: '정비 등록', contentText: '등록되었습니다.',
    ));
  }
  Future<void> saveButton() async {
    await HomeApi.to.PROC('USP_MBS0300_S01', {'@p_WORK_TYPE':'N', '@p_RP_CODE':'', '@p_IR_CODE':'${selectedContainer[0]['IR_CODE']}'
      , '@p_IR_FG':'${irfqCd}', '@p_MACH_CODE':'${selectedContainer[0]['MACH_CODE']}', '@p_RP_USER':'${rpUser.value}',
      '@p_RP_CONTENT':'${textContentController.text}', '@p_START_DT':'$dayStartValue', '@p_END_DT':'$dayEndValue',
      '@p_RESULT_FG':'$resultFgCd', '@p_NO_REASON':'$noReasonCd',
      '@p_RP_DEPT':'9999', '@p_USER':'admin',});

    /// 수정필


   /* 저장 쿼리
    exec USP_MBS0300_S01 @p_WORK_TYPE = 'N'
    ,@p_RP_CODE      = ''
    ,@p_IR_CODE      = 'IR230609000001'
    ,@p_IR_FG      = 'IR'
    ,@p_MACH_CODE   = '1'
    ,@p_RP_USER      = 'admin'
    ,@p_RP_CONTENT   = '6단1호기 돌발 정비 요청'
    ,@p_START_DT   = '2023-06-09'
    ,@p_END_DT      = '2023-06-11'
    ,@p_RESULT_FG   = 'Y'
    ,@p_NO_REASON   = ''
    ,@p_RP_DEPT      = '9999'
    ,@p_USER      = 'admin'
    ※ 앞에 ’@p_’ 붙이는 항목은 모바일 입력 항목입니다.
    ※  @p_USER는 접속자 ID입니다.*/
  }


  Future<void> irfgConvert() async{
    irfgList.clear();
    noReasonList.clear();
    engineerList.clear();
    engineerIdList.clear();
    irfgList.add('전체');
    noReasonList.add('전체');
    engineerList.add('정비자를 선택해주세요');
    engineerIdList.add('정비자를 선택해주세요');
    /// 정비자 리스트
    var engineer = await HomeApi.to.BIZ_DATA('L_USER_001').then((value) =>
    {
      for(var i = 0; i < value['DATAS'].length; i++) {

        engineerList.add(value['DATAS'][i]['USER_NAME'].toString()),
        engineerIdList.add(value['DATAS'][i]['USER_ID'].toString()),
      }
    });
    var test = await HomeApi.to.BIZ_DATA('LCT_MR004').then((value) =>
    {
      Get.log('뭦ㅇ미인ㅇㄴㅇㄴㅇㄴㅇㄴㅇㄴㅇ ${value['DATAS']}'),
      for(var i = 0; i < value['DATAS'].length; i++) {
        irfgList.add(value['DATAS'][i]['TEXT'].toString()),
      }
    });
    var test2 = await HomeApi.to.BIZ_DATA('LCT_MR112').then((value) =>
    {
      Get.log('뭦ㅇ미인ㅇㄴㅇㄴㅇㄴㅇㄴㅇㄴㅇ ${value['DATAS']}'),
      for(var i = 0; i < value['DATAS'].length; i++) {
        noReasonList.add(value['DATAS'][i]['TEXT'].toString()),
      }
    });
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
    if(selectedIrFq.value != '전체' && selectedResultFg.value != '전체'
        && selectedNoReason.value != '전체') {
      isStep2RegistBtn.value = true;
    }else {
      isStep2RegistBtn.value = false;
    }
  }




  @override
  void onInit() {
    irfgConvert();
  }

  @override
  void onClose() {}

  @override
  void onReady() {
    datasList.clear();
  }
}
