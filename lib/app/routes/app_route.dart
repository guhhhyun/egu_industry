import 'package:egu_industry/app/pages/blueTooth/blue_tooth_binding.dart';
import 'package:egu_industry/app/pages/blueTooth/blue_tooth_page.dart';
import 'package:egu_industry/app/pages/dolbal/facility_binding.dart';
import 'package:egu_industry/app/pages/dolbal/facility_page.dart';
import 'package:egu_industry/app/pages/facilityFirst/facility_first_binding.dart';
import 'package:egu_industry/app/pages/facilityFirst/facility_first_step1_page.dart';
import 'package:egu_industry/app/pages/main/main_binding.dart';
import 'package:egu_industry/app/pages/main/main_page.dart';

import 'package:get/get.dart';

import '../pages/splash/splash_binding.dart';
import '../pages/splash/splash_page.dart';

abstract class Routes {
  static const PERMISSION = _PathName.PERMISSION;
  static const MAIN = _PathName.MAIN;
  static const SPLASH = _PathName.SPLASH;
  static const FACILITY = _PathName.FACILITY;
  static const FACILITY_FIRST = _PathName.FACILITY_FIRST;


}

abstract class _PathName {
  static const String PERMISSION = '/permission'; // 권한 요청 페이지
  static const String MAIN = '/main'; // MAIN 페이지
  static const String SPLASH = '/splash'; // SPLASH 페이지
  static const String FACILITY = '/facility'; // FACILITY 페이지
  static const String FACILITY_FIRST = '/facility_first'; // FACILITY 페이지
}

class AppRoute {
  static final routes = [
    GetPage(
        name: _PathName.SPLASH,
        page: () => SplashPage(),
        binding: SplashBinding()),
    GetPage(
        name: _PathName.MAIN, page: () => MainPage(), binding: MainBinding()),
   /* GetPage(
        name: _PathName.FACILITY, page: () => BluetoothPage(), binding: BlueToothBinding()),*/
    GetPage(
        name: _PathName.FACILITY, page: () => FacilityPage(), binding: FacilityBinding()),
    GetPage(
        name: _PathName.FACILITY_FIRST, page: () => FacilityFirstStep1Page(), binding: FacilityFirstBinding()),
  ];
}
