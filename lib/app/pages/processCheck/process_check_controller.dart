
import 'package:egu_industry/app/net/home_api.dart';
import 'package:flutter/animation.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';


/// 이게 작업조회
class ProcessCheckController extends GetxController {

  RxList<String> gubun = ['선택해주세요', '작업조회(400)', '작업조회(600)', '비가동내역'].obs;
  RxString selectedGubun = '선택해주세요'.obs;
  RxString selectedGubunCd = '400'.obs;
  RxList<dynamic> processList = [].obs;
  RxList<dynamic> lastList = [].obs;
  RxList<dynamic> currentList = [].obs;
  List<PlutoRow> rowDatas = [];
  late final PlutoGridStateManager gridStateMgr;


  RxBool isLoading = false.obs;

  /// 400 조회
  Future<void> check400Button() async {
    try {
      isLoading.value = true;
      var a = await HomeApi.to.PROC('USP_MBR1600_R02', {'@p_WORK_TYPE':'Q'}).then((value) =>
      {
        if(value['DATAS'] != null) {
          processList.value = value['DATAS'],
        },

      });
      var lastDate = await HomeApi.to.PROC('USP_MBR1600_R02', {'@p_WORK_TYPE':'Q_CNT', '@p_INP_DT':'${DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 1)))}'}).then((value) =>
      {
        if(value['DATAS'] != null) {
          lastList.value = value['DATAS'],
        },
      });
      var currentDate = await HomeApi.to.PROC('USP_MBR1600_R02', {'@p_WORK_TYPE':'Q_CNT', '@p_INP_DT':'${DateFormat('yyyy-MM-dd').format(DateTime.now())}'}).then((value) =>
      {
        if(value['DATAS'] != null) {
          currentList.value = value['DATAS'],
        },
      });
      Get.log('작업조회 200:::::::::::::: ${a}');
      Get.log('작업조회 200 전일:::::::::::::: ${lastDate}');
      Get.log('작업조회 200 금일:::::::::::::: ${currentDate}');

    }catch (err) {
      Get.log('USP_MBR1600_R02 err = ${err.toString()} ', isError: true);
    }finally {
      isLoading.value = false;
      plutoRow();
   }
  }

  Future<void> plutoRow() async {
    rowDatas = List<PlutoRow>.generate(processList.length, (index) =>
        PlutoRow(cells:
        Map.from((processList[index]).map((key, value) =>
            MapEntry(key, PlutoCell(value:  key == 'P_TIME' ? lastList[index]['BE_CNT'] : key == 'SHP_ID' ? currentList[index]['BE_CNT']
                :  key == 'DT' ? '${value.substring(8, 10)}일 ${value.substring(11, 16)}'

                : value)),
        )))
    );
    gridStateMgr.removeAllRows();
    gridStateMgr.appendRows(rowDatas);
    gridStateMgr.scroll.vertical?.animateTo(25, curve: Curves.bounceIn, duration: Duration(milliseconds: 100));
    }

  /// 600 조회
  Future<void> check600Button() async {
    try {
      isLoading.value = true;
      var a = await HomeApi.to.PROC('USP_MBR1600_R01', {'@p_WORK_TYPE':'Q'}).then((value) =>
      {
        if(value['DATAS'] != null) {
          processList.value = value['DATAS'],
        }
      });
      var lastDate = await HomeApi.to.PROC('USP_MBR1600_R01', {'@p_WORK_TYPE':'Q_CNT', '@p_INP_DT':'${DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 1)))}'}).then((value) =>
      {
        if(value['DATAS'] != null) {
          lastList.value = value['DATAS'],
        }
      });
      var currentDate = await HomeApi.to.PROC('USP_MBR1600_R01', {'@p_WORK_TYPE':'Q_CNT', '@p_INP_DT':'${DateFormat('yyyy-MM-dd').format(DateTime.now())}'}).then((value) =>
      {
        if(value['DATAS'] != null) {
          currentList.value = value['DATAS'],
        }
      });
      Get.log('작업조회 600 :::::::::::::: ${a}');
    }catch (err) {
      Get.log('USP_MBR1600_R01 err = ${err.toString()} ', isError: true);
    }finally {
      isLoading.value = false;
      plutoRow();
    }

  }



  Future<void> convert() async {
    switch(selectedGubun.value) {
      case "작업조회(400)":
        selectedGubunCd.value = '400';
        break;
      case "작업조회(600)":
        selectedGubunCd.value = '600';
        break;
      case "비가동내역":
        selectedGubunCd.value = 'N';
        break;
      default:
        selectedGubunCd.value = '';
    }
  }

  @override
  void onInit() {
    check400Button();
  }

  @override
  void onClose() {
  }

  @override
  void onReady() {
    check400Button();
  }
}
