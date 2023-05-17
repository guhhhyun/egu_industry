import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/routes/app_route.dart';

class MainIconWidget extends StatelessWidget {
  const MainIconWidget({Key? key}) : super(key: key);

  Widget _buttonArea(
      {required String title,
        required String imgUrl,
        required Function() onPressed}) {
    return Material(
      // elevation: 1,
      color: Colors.transparent,
      child: SizedBox(
        // width: 72,
        // height: 72,
        child: InkWell(
          // radius: 100,
          onTap: onPressed,
          child: Column(
            children: [
              Container(
                child: Ink.image(
                  image: AssetImage(imgUrl),
                  width: 68,
                  height: 68,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                child: Text(
                  title,
                  style: AppTheme.bodyBody1.copyWith(
                    color: AppTheme.light_text_cto,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.only(
          left: AppTheme.spacing_m_16,
          top: AppTheme.spacing_xxl_32,
          right: AppTheme.spacing_m_16,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buttonArea(
                    imgUrl: 'assets/ico/01.png',
                    title: '1',
                    onPressed: () {
                      Get.log('철근');
                    //  Get.toNamed(Routes.BAR_MAIN);
                    }),
                _buttonArea(
                    imgUrl: 'assets/ico/02.png',
                    title: '2',
                    onPressed: () {
                      Get.log('코일철근');
                    //  Get.toNamed(Routes.COIL_MAIN);
                    }),
                _buttonArea(
                    imgUrl: 'assets/ico/03.png',
                    title: '3',
                    onPressed: () {
                      Get.log('형강직판');
                    //  Get.toNamed(Routes.SECTION_DIRECT_MAIN);
                    }),
                _buttonArea(
                    imgUrl: 'assets/ico/04.png',
                    title: '4',
                    onPressed: () {
                      Get.log('형강유통');
                    //  Get.toNamed(Routes.SECTION_CIRCUL_MAIN);
                    }),
              ],
            ),
            const SizedBox(
              height: AppTheme.spacing_m_16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buttonArea(
                    imgUrl: 'assets/ico/05.png',
                    title: '5',
                    onPressed: () {
                      Get.log('후판주문품');
                    //  Get.toNamed(Routes.PLATE_ORDER_MAIN);
                    }),
                _buttonArea(
                    imgUrl: 'assets/ico/06.png',
                    title: '6',
                    onPressed: () {
                      Get.log('후판계획품');
                    //  Get.toNamed(Routes.PLATE_PLAN_MAIN);
                    }),
                _buttonArea(
                    imgUrl: 'assets/ico/07.png',
                    title: '7',
                    onPressed: () {
                      Get.log('냉연도금');
                    //  Get.toNamed(Routes.COLD_PLATED_MAIN);
                    }),
                _buttonArea(
                    imgUrl: 'assets/ico/08.png',
                    title: '8',
                    onPressed: () {
                      Get.log('컬러');
                    //  Get.toNamed(Routes.COLD_COLOR_MAIN);
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
