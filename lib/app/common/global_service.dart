import 'package:egu_industry/app/common/utils.dart';
import 'package:get/get.dart';


import '../net/home_api.dart';
import '../net/http_util.dart';
import '../routes/app_route.dart';

class GlobalService extends GetxService {
  static GlobalService get to => Get.find();

  String authToken = '';
  RxBool isLogin = false.obs;

  // var userInfo = UserModel();

  // /// 로그인 정보 불러오기
  // void _loadLoginInfo() async {
  //   try {
  //     if (Utils.getStorage.hasData('userId') &&
  //         Utils.getStorage.hasData('userPw')) {
  //       var params = {
  //         'userId': Utils.getStorage.read('userId'),
  //         'userPw': Utils.getStorage.read('userPw'),
  //         "linkYn": "N"
  //       };
  //
  //       final retVal = await HomeApi.to.reqLogin(params);
  //
  //       isLogin.value = true;
  //
  //       if (retVal == true) {
  //         Get.log('로그인 성공');
  //         Get.offAllNamed(Routes.MAIN);
  //       }
  //     }
  //   } catch (err) {
  //     Get.log('GlobalService - onInit Err ', isError: true);
  //     Get.log(err.toString(), isError: true);
  //   }
  // }

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

  void logout() async {
    await Utils.getStorage.erase();
    isLogin.value = false;

    HttpUtil.setToken(token: '');
    Get.offAllNamed(Routes.LOGIN_PAGE);

    Utils.gErrorMessage('로그아웃');
  }

  /// 로그인 정보 저장
  void setLoginInfo() async {
    try {

   //   await Utils.getStorage.write('userModel', userInfo.toJson());

      isLogin.value = true;
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
    // await Utils.storage.erase();
    //_loadLoginInfo();

    super.onInit();
  }

  @override
  void onReady() {
    Get.log('GlobalService - onReady !!');
  }
}