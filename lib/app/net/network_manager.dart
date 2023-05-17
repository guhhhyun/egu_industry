import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/src/response.dart' as Response;
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../common/app_const.dart';

class NetworkManager {
  // 내부 json 테스틑 용도로 만든 json paser
  dynamic localJsonPaser(String assetsPath) async {
    var jsonString = await rootBundle.loadString(assetsPath);
    // await Future.delayed(const Duration(milliseconds: 5000));
    await Future.delayed(const Duration(milliseconds: 500));
    return json.decode(jsonString);
  }
}

