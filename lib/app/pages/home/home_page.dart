


import 'package:egu_industry/app/pages/blueTooth/blue_tooth_controller.dart';
import 'package:egu_industry/app/pages/home/widget/home_news_widget.dart';
import 'package:egu_industry/app/pages/home/widget/main_icon_widget.dart';
import 'package:egu_industry/app/pages/home/widget/main_read_more_widget.dart';
import 'package:egu_industry/app/pages/home/widget/main_slide_widget.dart';
import 'package:egu_industry/app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../common/app_theme.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  HomeController controller = Get.find();
  BlueToothController controller2 = Get.find();


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
      //  controller.reqMarketList();
        return Future.value();
      },
      child: CustomScrollView(
        slivers: [
          //MainHeader(),
          MainSlideWidget(),
          const MainIconWidget(),

          const SliverToBoxAdapter(
            child: SizedBox(height: AppTheme.spacing_xxxl_40),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppTheme.spacing_xxxl_40),
          ),
          // 공지 리스트
          HomeNewsWidget(),

          const SliverToBoxAdapter(
            child: SizedBox(height: AppTheme.spacing_xxxl_40),
          ),
          MainReadMoreWidget()
        ],
      ),
    );
  }
}
