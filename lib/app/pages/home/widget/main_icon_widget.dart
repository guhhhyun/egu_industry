import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/routes/app_route.dart';

class MainIconWidget extends StatelessWidget {
  const MainIconWidget({Key? key}) : super(key: key);

  Widget _buttonArea(
      {required String title,
        required String subTitle,
        required String imgUrl,
        required Function() onPressed}) {
    return Container(
        child: Container(
          child: InkWell(
            onTap: onPressed,
            child: Container(
                  decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: AppTheme.gray_c_gray_200)
                  ),
                  padding: EdgeInsets.only(top: 16, bottom: 16, left: 20, right: 20),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: AppTheme.bodyBody2.copyWith(
                                  color: AppTheme.light_text_cto,
                                ),
                              ),
                              Text(
                                subTitle,
                                style: AppTheme.bodyBody2.copyWith(
                                  color: AppTheme.light_text_cto,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Ink.image(
                            image: AssetImage(imgUrl),
                            width: 24,
                            height: 24,
                          ),
                        ],
                      ),

                    ],
                  ),
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
          left: AppTheme.spacing_l_20,
          top: AppTheme.spacing_xl_24,
          right: AppTheme.spacing_l_20,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('WORK MENU', style: AppTheme.titleDisplay2)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('원하시는 작업을 선택해주세요', style: AppTheme.titleSubhead4.copyWith(color: AppTheme.gray_c_gray_400))
              ],
            ),
            const SizedBox(height: 32,),
            Row(
              children: [
                Expanded(child: _buttonArea(
                    imgUrl: 'assets/app/phone.png',
                    title: '설비/안전',
                    subTitle: '점검의뢰',
                    onPressed: () {
                      Get.log('돌발정비');
                      Get.toNamed(Routes.FACILITY_FIRST);
                    }),),
                const SizedBox(width: 16,),
                Expanded(child: _buttonArea(
                    imgUrl: 'assets/app/phone.png',
                    title: '설비/안전',
                    subTitle: '내역등록',
                    onPressed: () {
                      Get.log('설비/안전 내역 등록');
                      Get.toNamed(Routes.FACILITY);
                      //  Get.toNamed(Routes.BAR_MAIN);
                    }),),
                const SizedBox(width: 16,),
                Expanded(child: _buttonArea(
                    imgUrl: 'assets/app/icon-delivery-24-on.png',
                    title: '제품',
                    subTitle: '위치이동',
                    onPressed: () {
                      Get.log('제품 위치이동');
                      //  Get.toNamed(Routes.BAR_MAIN);
                    }),),


              ],
            ),
            const SizedBox(height: 16,),
            Row(
              children: [
                Expanded(child: _buttonArea(
                    imgUrl: 'assets/app/icon_box_24.png',
                    title: '재고실사',
                    subTitle: '',
                    onPressed: () {
                      Get.log('재고실사');
                      //  Get.toNamed(Routes.BAR_MAIN);
                    }),),
                const SizedBox(width: 16,),
                Expanded(child: _buttonArea(
                    imgUrl: 'assets/app/icon_factory_24.png',
                    title: '공정이동',
                    subTitle: '',
                    onPressed: () {
                      Get.log('제품위치이동');
                      //  Get.toNamed(Routes.BAR_MAIN);
                    }),),
                const SizedBox(width: 16,),
                Expanded(child: _buttonArea(
                    imgUrl: 'assets/app/icon_factory_24.png',
                    title: '공정이동',
                    subTitle: '',
                    onPressed: () {
                      Get.log('제품위치이동');
                      //  Get.toNamed(Routes.BAR_MAIN);
                    }),),
              ],
            ),
            const SizedBox(height: 16,),
            Row(
              children: [
                Expanded(child: _buttonArea(
                    imgUrl: 'assets/app/icon_factory_24.png',
                    title: '공정조회',
                    subTitle: '',
                    onPressed: () {
                      Get.log('재고실사등록');
                      //  Get.toNamed(Routes.BAR_MAIN);
                    }),),
                const SizedBox(width: 16,),
                Expanded(child: _buttonArea(
                    imgUrl: 'assets/app/icon-notice-24.png',
                    title: '제품포장',
                    subTitle: '검수',
                    onPressed: () {
                      Get.log('포승공정 조회');
                      //  Get.toNamed(Routes.BAR_MAIN);
                    }),),
                const SizedBox(width: 16,),
                Expanded(child: _buttonArea(
                    imgUrl: 'assets/app/icon-receive-24-on.png',
                    title: '스크랩',
                    subTitle: '라벨 발행',
                    onPressed: () {
                      Get.log('제품 제고현황');
                      //  Get.toNamed(Routes.BAR_MAIN);
                    }),),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
