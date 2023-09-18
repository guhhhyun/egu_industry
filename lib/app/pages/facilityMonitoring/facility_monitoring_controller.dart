
import 'package:egu_industry/app/net/home_api.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class FacilityMonitoringController extends GetxController {

  RxList<String> gubun = ['선택해주세요', '400', '600'].obs;
  RxString selectedLine = '선택해주세요'.obs;
  RxString selectedLineCd = '400'.obs;
  RxList<dynamic> monitoringList = [].obs;
  RxBool isLoading = false.obs;

  Future<void> checkButton() async {
    try {
      isLoading.value = true;
      var a = await HomeApi.to.PROC('USP_MBR1000_R01', {'@p_WORK_TYPE':'Q', '@p_LINE':selectedLineCd.value}).then((value) =>
      {
        if(value['DATAS'] != null) {
          monitoringList.value = value['DATAS'],
        }
      });
    }catch (err) {
      Get.log('USP_MBR1000_R01 @p_WORK_TYPE Q err = ${err.toString()} ', isError: true);
    }finally {
      isLoading.value = false;
    }
  }


  @override
  void onInit() async{
    await HomeApi.to.PROC('USP_MBR1000_R01', {'@p_WORK_TYPE':'Q', '@p_LINE':selectedLineCd.value}).then((value) =>
    {
      if(value['DATAS'] != null) {
        monitoringList.value = value['DATAS'],
      }
    });

  }

  @override
  void onClose() {
  }

  @override
  void onReady() {
  }
}
