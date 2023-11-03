import 'dart:async';
import 'dart:convert';
import 'dart:developer';


import 'package:egu_industry/app/common/global_service.dart';
import 'package:egu_industry/app/common/utils.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class HomeController extends GetxController with GetTickerProviderStateMixin {
  GlobalService gs = Get.find();

  RxBool isLoading = false.obs;
  RxList<dynamic> noticeList = [].obs;
  RxList<dynamic> alarmNList = [].obs;

  Future<void> reqNoticeList() async {
    var a = await HomeApi.to.PROC('USP_MBR0100_R01',
        {'@p_WORK_TYPE': 'Q'}).then((value) =>
    {
      if(value['DATAS'] != null) {
        noticeList.value = value['DATAS'],
      }
    });
    Get.log('공지사항 ::::: ${noticeList.value}');
  }

  Future<void> reqListAlarm() async {

    alarmNList.clear();
    try{
      isLoading.value = true;
      var a = await HomeApi.to.PROC("PS_PERIOD_USR_MSG", {"@p_WORK_TYPE":"Q_LIST","@p_RCV_USER":gs.loginId.value,"@p_CHK_YN": 'N'/*,"@p_TYPE_MSG":''*/}).then((value) =>
      {
        alarmNList.value = value['DATAS'],

      });
      Get.log('알림 조회::::::::: $a');
    }catch(err) {
      Get.log('PS_PERIOD_USR_MSG err = ${err.toString()} ', isError: true);
      Utils.gErrorMessage('네트워크 오류');
    }finally{
      isLoading.value = false;
    }

  }


  @override
  void onInit() {
    reqNoticeList();
    reqListAlarm();
  }

  @override
  void onClose() {}

  @override
  void onReady() {
  }
}
