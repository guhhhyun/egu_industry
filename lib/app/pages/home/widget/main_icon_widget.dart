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
    return SizedBox(
        child: InkWell(
          onTap: onPressed,
          child: Container(
                padding: EdgeInsets.only(top: 21, bottom: 21),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppTheme.gray_c_gray_200)
                ),
                child: Column(
                  children: [
                    Ink.image(
                      image: AssetImage(imgUrl),
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(height: 4,),
                    Text(
                      title,
                      style: AppTheme.bodyBody1.copyWith(
                        color: AppTheme.light_text_cto,
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
          top: AppTheme.spacing_xl_24,
          right: AppTheme.spacing_m_16,
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
                    title: '돌발정비',
                    onPressed: () {
                      Get.log('돌발정비');
                      //  Get.toNamed(Routes.BAR_MAIN);
                    }),),
                const SizedBox(width: 8,),
                Expanded(child: _buttonArea(
                    imgUrl: 'assets/app/phone.png',
                    title: '스크랩입고',
                    onPressed: () {
                      Get.log('스크랩입고');
                      //  Get.toNamed(Routes.BAR_MAIN);
                    }),),
                const SizedBox(width: 8,),
                Expanded(child:  _buttonArea(
                    imgUrl: 'assets/app/phone.png',
                    title: '스크랩투입대기',
                    onPressed: () {
                      Get.log('스크랩투입대기');
                      //  Get.toNamed(Routes.COIL_MAIN);
                    }),),
              ],
            ),
            const SizedBox(height: 8,),
            Row(
              children: [
                Expanded(child: _buttonArea(
                    imgUrl: 'assets/app/phone.png',
                    title: '슬라브입고',
                    onPressed: () {
                      Get.log('슬라브입고');
                      //  Get.toNamed(Routes.BAR_MAIN);
                    }),),
                const SizedBox(width: 8,),
                Expanded(child: _buttonArea(
                    imgUrl: 'assets/app/phone.png',
                    title: '제품외주이동',
                    onPressed: () {
                      Get.log('제품외주이동');
                      //  Get.toNamed(Routes.BAR_MAIN);
                    }),),
                const SizedBox(width: 8,),
                Expanded(child:  _buttonArea(
                    imgUrl: 'assets/app/phone.png',
                    title: '제품입고',
                    onPressed: () {
                      Get.log('제품입고');
                      //  Get.toNamed(Routes.COIL_MAIN);
                    }),),
              ],
            ),
            const SizedBox(height: 8,),
            Row(
              children: [
                Expanded(child: _buttonArea(
                    imgUrl: 'assets/app/phone.png',
                    title: '제품위치이동',
                    onPressed: () {
                      Get.log('제품위치이동');
                      //  Get.toNamed(Routes.BAR_MAIN);
                    }),),
                const SizedBox(width: 8,),
                Expanded(child: _buttonArea(
                    imgUrl: 'assets/app/phone.png',
                    title: '재고실사등록',
                    onPressed: () {
                      Get.log('재고실사등록');
                      //  Get.toNamed(Routes.BAR_MAIN);
                    }),),
                const SizedBox(width: 8,),
                Expanded(child:  _buttonArea(
                    imgUrl: 'assets/app/phone.png',
                    title: '공정이동등록',
                    onPressed: () {
                      Get.log('공정이동등록');
                      //  Get.toNamed(Routes.COIL_MAIN);
                    }),),

              ],
            ),
            const SizedBox(height: 8,),
            Row(
              children: [
                Expanded(child: _buttonArea(
                    imgUrl: 'assets/app/phone.png',
                    title: '포승공정 조회',
                    onPressed: () {
                      Get.log('포승공정 조회');
                      //  Get.toNamed(Routes.BAR_MAIN);
                    }),),
                const SizedBox(width: 8,),
                Expanded(child: _buttonArea(
                    imgUrl: 'assets/app/phone.png',
                    title: '제품 제고현황',
                    onPressed: () {
                      Get.log('제품 제고현황');
                      //  Get.toNamed(Routes.BAR_MAIN);
                    }),),
                const SizedBox(width: 8,),
                Expanded(child:  _buttonArea(
                    imgUrl: 'assets/app/phone.png',
                    title: '설비가동 모니터링',
                    onPressed: () {
                      Get.log('설비가동 모니터링');
                      //  Get.toNamed(Routes.COIL_MAIN);
                    }),),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
