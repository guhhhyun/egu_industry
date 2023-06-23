import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:web_socket_channel/io.dart';
//import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../common/global_service.dart';
import '../../net/home_api.dart';
import '../../routes/app_route.dart';

class MainController extends GetxController with GetTickerProviderStateMixin {
  static MainController get to => Get.find();

  /// 공통 변수
  RxInt selected = 0.obs;
  RxString appBarTitle = ''.obs;

  RxBool readOnly = false.obs;
  RxString resultText = ''.obs;



  TextEditingController roomNameController = TextEditingController();

  void changeMenu(int param) {
    if (param == 0) {
      appBarTitle.value = '';
    } else if (param == 1) {
      appBarTitle.value = '웹뷰';
    } else if (param == 2) {
      appBarTitle.value = '마이페이지';
    }

  }


  @override
  void onInit() {
  }

  @override
  void onClose() {}

  @override
  void onReady() {}
}
