import 'package:egu_industry/app/pages/blueTooth/blue_tooth_binding.dart';
import 'package:egu_industry/app/pages/blueTooth/blue_tooth_page.dart';
import 'package:egu_industry/app/pages/dolbal/facility_binding.dart';
import 'package:egu_industry/app/pages/dolbal/facility_page.dart';
import 'package:egu_industry/app/pages/facilityFirst/facility_first_binding.dart';
import 'package:egu_industry/app/pages/facilityFirst/facility_first_step1_page.dart';
import 'package:egu_industry/app/pages/inventoryCounting/inventory_counting_binding.dart';
import 'package:egu_industry/app/pages/inventoryCounting/inventory_counting_page.dart';
import 'package:egu_industry/app/pages/main/main_binding.dart';
import 'package:egu_industry/app/pages/main/main_page.dart';
import 'package:egu_industry/app/pages/productLocation/product_location_binding.dart';
import 'package:egu_industry/app/pages/productLocation/product_location_page.dart';

import 'package:get/get.dart';

import '../pages/splash/splash_binding.dart';
import '../pages/splash/splash_page.dart';

abstract class Routes {
  static const PERMISSION = _PathName.PERMISSION;
  static const MAIN = _PathName.MAIN;
  static const SPLASH = _PathName.SPLASH;
  static const FACILITY = _PathName.FACILITY;
  static const FACILITY_FIRST = _PathName.FACILITY_FIRST;
  static const PRODUCT_LOCATION = _PathName.PRODUCT_LOCATION;
  static const INVENTORY_COUNTING = _PathName.INVENTORY_COUNTING;


}

abstract class _PathName {
  static const String PERMISSION = '/permission'; // 권한 요청 페이지
  static const String MAIN = '/main'; // MAIN 페이지
  static const String SPLASH = '/splash'; // SPLASH 페이지
  static const String FACILITY = '/facility'; // FACILITY 페이지
  static const String FACILITY_FIRST = '/facility_first'; // FACILITY 페이지
  static const String PRODUCT_LOCATION = '/product_location'; // 제품이동 페이지
  static const String INVENTORY_COUNTING = '/inventoty_counting'; // 재고실사 페이지
}

class AppRoute {
  static final routes = [
    GetPage(
        name: _PathName.SPLASH,
        page: () => SplashPage(),
        binding: SplashBinding()),
    GetPage(
        name: _PathName.MAIN, page: () => MainPage(), binding: MainBinding()),
    GetPage(
        name: _PathName.FACILITY, page: () => FacilityPage(), binding: FacilityBinding()),
    GetPage(
        name: _PathName.FACILITY_FIRST, page: () => FacilityFirstStep1Page(), binding: FacilityFirstBinding()),
    GetPage(
        name: _PathName.PRODUCT_LOCATION, page: () => ProductLocationPage(), binding: ProductLocationBinding()),
    GetPage(
        name: _PathName.INVENTORY_COUNTING, page: () => InventoryCountingPage(), binding: InventoryCountingBinding()),
  ];
}
