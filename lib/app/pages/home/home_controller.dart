import 'dart:async';
import 'dart:convert';
import 'dart:developer';


import 'package:egu_industry/app/net/home_api.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class HomeController extends GetxController with GetTickerProviderStateMixin {

  RxBool isLoading = false.obs;
  RxList<dynamic> noticeList = [].obs;

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


  @override
  void onInit() {
    reqNoticeList();
  }

  @override
  void onClose() {}

  @override
  void onReady() {
  }
}
