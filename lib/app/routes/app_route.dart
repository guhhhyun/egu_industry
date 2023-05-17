import 'package:egu_industry/app/pages/main/main_binding.dart';
import 'package:egu_industry/app/pages/main/main_page.dart';

import 'package:get/get.dart';

import '../pages/splash/splash_binding.dart';
import '../pages/splash/splash_page.dart';

abstract class Routes {
  static const PERMISSION = _PathName.PERMISSION;
  static const MAIN = _PathName.MAIN;
  static const SPLASH = _PathName.SPLASH;
}

abstract class _PathName {
  static const String PERMISSION = '/permission'; // 권한 요청 페이지
  static const String MAIN = '/main'; // MAIN 페이지
  static const String SPLASH = '/splash'; // SPLASH 페이지
}

class AppRoute {
  static final routes = [
    GetPage(
        name: _PathName.SPLASH,
        page: () => SplashPage(),
        binding: SplashBinding()),
    GetPage(
        name: _PathName.MAIN, page: () => MainPage(), binding: MainBinding()),
  ];
}
