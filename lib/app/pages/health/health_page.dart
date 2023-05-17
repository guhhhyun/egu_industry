


import 'package:egu_industry/app/pages/blue_tooth/blue_tooth_controller.dart';
import 'package:egu_industry/app/pages/health/widget/main_icon_widget.dart';
import 'package:egu_industry/app/pages/health/widget/main_slide_widget.dart';
import 'package:egu_industry/app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../common/app_theme.dart';
import 'health_controller.dart';

class HealthPage extends StatelessWidget {
  HealthPage({Key? key}) : super(key: key);

  HealthController controller = Get.find();
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
            child: SizedBox(height: 44),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: AppTheme.spacing_xl_24),
          ),
          // 철강 시장 정보

          const SliverToBoxAdapter(
            child: SizedBox(height: AppTheme.spacing_xxl_32),
          ),


/*
          SliverToBoxAdapter(
            child: Obx(
              () => Container(
                child:
                    Text('noticeList.length = ${controller.noticeList.length}'),
              ),
            ),
          ),
          */
          const SliverToBoxAdapter(
            child: SizedBox(height: AppTheme.spacing_xxxl_40),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 28,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                // color: Colors.red,
              ),
              child: Text(
                '공지사항',
                style: AppTheme.titleHeadline
                    .copyWith(color: AppTheme.light_text_primary),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppTheme.spacing_xl_24),
          ),
          // 공지 리스트

          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(
                  height: AppTheme.spacing_xl_24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      constraints:
                      const BoxConstraints(minHeight: 32, minWidth: 96),
                      child: TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.only(left: 10, right: 10),
                          ),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: const BorderSide(
                                      color: AppTheme.navy_navy_600))),
                        ),
                        onPressed: () {
                          Get.log('이전 구매정보 클릭!!');
                        //  Get.toNamed(Routes.NOTICE);
                        },
                        child: Row(
                          children: [
                            Text(
                              '전체공지 보기',
                              style: AppTheme.titleSubhead1
                                  .copyWith(color: AppTheme.navy_navy_600),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            SvgPicture.asset(
                              'assets/app/arrowRight.svg',
                              width: 14,
                              color: AppTheme.navy_navy_600,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // MainTrandWidget(),
          // MainVideoLibraryWidget(),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppTheme.spacing_xxxl_40),
          ),

        ],
      ),
    );
  }
}
