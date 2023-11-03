
import 'package:egu_industry/app/common/utils.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class GagongFacilityController extends GetxController {
  RxList test = [].obs;
  RxList<String> movIds = [''].obs;
  RxList<dynamic> datasList = [].obs;
  RxList<bool> isDatasSelectedList = [false].obs;
  RxList<bool> isDatasSelectedList2 = [false].obs;
  RxList<dynamic> processSelectedList = [].obs;
  RxList<dynamic> processSelectedList2 = [].obs;
  RxString dayValue = '날짜를 선택해주세요'.obs;
  RxString dayStartValue = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxString dayEndValue = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxList fkfNoList = [''].obs; // 위치 정보 리스트
  RxString selectedFkf = '선택해주세요'.obs;
  RxString selectedMach = '선택해주세요'.obs;
  RxBool registButton = false.obs;
  RxBool isLoading = false.obs;
  RxInt choiceButtonVal = 1.obs;
  RxString movCd = ''.obs;

  Future<void> convert() async {

  }

  Future<void> checkButton() async {
    movIds.clear();
    isDatasSelectedList.clear();
    isDatasSelectedList2.clear();
    datasList.clear();

    try {
      isLoading.value = true;
      var a = await HomeApi.to.PROC('USP_MBS0600_R01', {'@p_WORK_TYPE':'Q', '@p_DATE_FR': '$dayStartValue'
        , '@p_DATE_TO': '$dayEndValue'}).then((value) =>
      {
        for(var i = 0; i < value['DATAS'].length; i++) {
          isDatasSelectedList.add(false),
          isDatasSelectedList2.add(false)
        },
        datasList.value = value['DATAS'],
        Get.log('aa ${datasList.value}')

      });
    }catch(err) {
      Get.log('USP_MBS0600_R01 err = ${err.toString()} ', isError: true);
      Utils.gErrorMessage('네트워크 오류');
    }finally {
      isLoading.value = false;
    }
  }



  Future<void> saveButton(int index) async {
    var a = await HomeApi.to.PROC('USP_MBS0600_S01', {'@p_WORK_TYPE':'U', '@p_MOV_ID': movIds[index]
      , '@p_MOV_YN':'Y', '@p_USER':'admin'});

    Get.log('가공설 저장: $a');
  }





  @override
  void onInit() async {

   /* await HomeApi.to.PROC('USP_MBS0600_R01', {'@p_WORK_TYPE':'Q'}).then((value) =>
    {
      for(var i = 0; i < value['DATAS'].length; i++) {
        isDatasSelectedList.add(false),
        isDatasSelectedList2.add(false)
      },
      datasList.value = value['DATAS'],
      Get.log('aa ${datasList.value}')

    });*/
  }

  @override
  void onClose() {
  }

  @override
  void onReady() {
  }
}
