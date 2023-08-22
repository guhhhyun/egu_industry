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
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          child: Container(
                decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppTheme.gray_c_gray_200)
                ),
                padding: EdgeInsets.only(top: 16, bottom: 16, left: 20, right: 20),

                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Ink.image(
                          image: AssetImage(imgUrl),
                          width: 24,
                          height: 24,
                        ),
                      ],
                    ),
                    SizedBox(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: AppTheme.newBody.copyWith(
                                color: AppTheme.a787878,
                              ),
                            ),
                            Text(
                              subTitle,
                              style: AppTheme.newBody.copyWith(
                                color: AppTheme.a787878,
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),

                  ],
                ),
              ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.only(
          left: AppTheme.spacing_l_20,
          top: 12,
          right: AppTheme.spacing_l_20,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('WORK MENU', style: AppTheme.newTitle)
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('원하시는 작업을 선택해주세요', style: AppTheme.bodyBody2.copyWith(color: AppTheme.a969696))
              ],
            ),
            const SizedBox(height: 27,),
            Row(
              children: [
                Expanded(

                  child: _buttonArea(
                    imgUrl: 'assets/app/checklist-1.png',
                    title: '설비/안전',
                    subTitle: '점검의뢰',
                    onPressed: () {
                      Get.log('돌발정비');
                      Get.toNamed(Routes.FACILITY_FIRST);
                    }),),
                const SizedBox(width: 12,),
                Expanded(
                 child: _buttonArea(
                    imgUrl: 'assets/app/online-test-1.png',
                    title: '설비/안전',
                    subTitle: '내역등록',
                    onPressed: () {
                      Get.log('설비/안전 내역 등록');
                      Get.toNamed(Routes.FACILITY);
                      //  Get.toNamed(Routes.BAR_MAIN);
                    }),),
                const SizedBox(width: 12,),
                Expanded(
                  child: _buttonArea(
                    imgUrl: 'assets/app/Group-1.png',
                    title: '제품',
                    subTitle: '위치이동',
                    onPressed: () {
                      Get.log('제품 위치이동');
                      Get.toNamed(Routes.PRODUCT_LOCATION);
                    }),),


              ],
            ),
            const SizedBox(height: 12,),
            Row(
              children: [
                Expanded(child: _buttonArea(
                    imgUrl: 'assets/app/Group.png',
                    title: '재고실사',
                    subTitle: '',
                    onPressed: () {
                      Get.log('재고실사');
                      Get.toNamed(Routes.INVENTORY_COUNTING);
                    }),),
                const SizedBox(width: 12,),
                Expanded(child: _buttonArea(
                    imgUrl: 'assets/app/Group-3.png',
                    title: '공정이동',
                    subTitle: '',
                    onPressed: () {
                      Get.log('공정이동');
                      Get.toNamed(Routes.PROCESS_TRANSFER);
                    }),),
                const SizedBox(width: 12,),
                Expanded(child: _buttonArea(
                    imgUrl: 'assets/app/Group-2.png',
                    title: '공정조회',
                    subTitle: '',
                    onPressed: () {
                      Get.log('공정조회');
                      Get.toNamed(Routes.PROCESS_CHECK);
                    }),),
              ],
            ),
            const SizedBox(height: 12,),
            Row(
              children: [
                Expanded(child: _buttonArea(
                    imgUrl: 'assets/app/Group-5.png',
                    title: '제품재고',
                    subTitle: '조회',
                    onPressed: () {
                      Get.log('제품재고 조회');
                      Get.toNamed(Routes.INVENTORY_CHECK);
                    }),),
                const SizedBox(width: 16,),
                Expanded(child: _buttonArea(
                    imgUrl: 'assets/app/Group-6.png',
                    title: '제품포장',
                    subTitle: '검수',
                    onPressed: () {
                      Get.log('제품포장 검수');
                      //  Get.toNamed(Routes.PACKAGING_INSPEC);
                    }),),
                const SizedBox(width: 12,),
                Expanded(child: _buttonArea(
                    imgUrl: 'assets/app/product-development-2.png',
                    title: '스크랩',
                    subTitle: '라벨발행',
                    onPressed: () {
                      Get.log('스크랩 라벨발행');
                      Get.toNamed(Routes.SCRAP_LABEL);
                    }),),
              ],
            ),
            const SizedBox(height: 12,),
            Row(
              children: [
                Expanded(child: _buttonArea(
                    imgUrl: 'assets/app/Group-5.png',
                    title: '설비가동',
                    subTitle: '모니터링',
                    onPressed: () {
                      Get.log('설비가동 모니터링');
                      Get.toNamed(Routes.FACILITY_MONITORING);
                    }),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
