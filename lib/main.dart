
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get_storage/get_storage.dart';

import 'app/common/color_schemes.g.dart';
import 'app/common/init_binding.dart';
import 'app/common/logger_utils.dart';
import 'app/net/http_util.dart';
import 'app/routes/app_route.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  HttpUtil.init();


  initializeDateFormatting().then((_) => runApp(MyApp()));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

    return GetMaterialApp(
      color: Colors.white,
      builder: (context, child) {
        return MediaQuery(
          // 스마트폰 기기 자체 폰트 사이즈 무시하기.
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: child!);
      },
      title: "이구산업",
      debugShowCheckedModeBanner: false,
      logWriterCallback: Logger.write,
      defaultTransition: Transition.fadeIn,
      initialBinding: InitBinding(),
      getPages: AppRoute.routes,
      initialRoute: Routes.SPLASH,
      themeMode: ThemeMode.system,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          fontFamily: 'NotoSansKR'

      ),
      darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          fontFamily: 'NotoSansKR'),
      //locale: ui.window.locale,
    );
  }
}
