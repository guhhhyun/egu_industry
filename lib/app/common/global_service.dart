import 'dart:async';

import 'package:egu_industry/app/common/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


import '../net/home_api.dart';
import '../net/http_util.dart';
import '../routes/app_route.dart';

class GlobalService extends GetxService {
  static GlobalService get to => Get.find();


  String authToken = '';
  RxBool isLogin = false.obs;
  var loginId = ''.obs;
  var loginPassword = ''.obs;

  // var userInfo = UserModel();

   /// 로그인 정보 불러오기
   void _loadLoginInfo() async {
    try {
      if (Utils.getStorage.hasData('userId') &&
           Utils.getStorage.hasData('userPw')) {

         String status = await HomeApi.to.LOGIN_MOB(Utils.getStorage.read('userId'), Utils.getStorage.read('userPw'));

         Get.log('로그인~~~~~~~~~~~~~~~~~~~~ $status');

         isLogin.value = true;
         Get.offAllNamed(Routes.MAIN);
       }
     } catch (err) {
       Get.log('GlobalService - onInit Err ', isError: true);
       Get.log(err.toString(), isError: true);
     }
   }

  /*


  void logout() async {
    await Utils.getStorage.erase();
    isLogin.value = false;
    userInfo = UserModel();

    HttpUtil.setToken(token: '');
    Get.offAllNamed(Routes.LOGIN);

    Utils.gErrorMessage('로그아웃');
  }

  /// 로그인 정보 저장
  void setLoginInfo({required UserModel userModel}) async {
    try {
      userInfo = userModel;

      await Utils.getStorage.write('userModel', userInfo.toJson());

      isLogin.value = true;
    } catch (err) {
      Get.log('GlobalService - setLoginInfo Err ', isError: true);
      Get.log(err.toString(), isError: true);
    }
  }

   */
  void setLoginInfo({required String id, required String password}) async {
    try {
      loginId.value = id;
      loginPassword.value = password;

      await Utils.getStorage.write('userId', loginId.value);
      await Utils.getStorage.write('userPw', loginPassword.value);
    } catch (err) {
      Get.log('GlobalService - setLoginInfo Err ', isError: true);
      Get.log(err.toString(), isError: true);
    }
  }


  void logout() async {
    await Utils.getStorage.erase();
    isLogin.value = false;
    loginId.value = '';
    loginPassword.value = '';
    Get.offAllNamed(Routes.LOGIN_PAGE);

    Utils.gErrorMessage('로그아웃');
  }

  /// 로그인 정보 저장
  void setLoginInfo2() async {
    try {

   //   await Utils.getStorage.write('userModel', userInfo.toJson());

      isLogin.value = true;
      Utils.gErrorMessage('로그인');
    } catch (err) {
      Get.log('GlobalService - setLoginInfo Err ', isError: true);
      Get.log(err.toString(), isError: true);
    }
  }

  @override
  void onClose() {
    Get.log('GlobalService - onClose !!');

    super.onClose();
  }

  @override
  void onInit() async {
    Get.log('GlobalService - onInit !!');
    _loadLoginInfo();
    super.onInit();
  }

  @override
  void onReady() {
    Get.log('GlobalService - onReady !!');
  }
}