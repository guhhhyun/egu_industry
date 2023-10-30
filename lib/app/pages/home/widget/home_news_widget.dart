import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/pages/home/home_controller.dart';
import 'package:egu_industry/app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


class HomeNewsWidget extends StatelessWidget {
  HomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
         // _alarmItem('알림'),
          _newItem('공지사항'),
        ],
      ),
    );
  }
  Widget _alarmItem(String title) {
    return Obx(() => Container(

        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 24),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppTheme.gray_c_gray_100.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            border: Border.all(color: AppTheme.gray_c_gray_100),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
        ),
        child: controller.noticeList.isNotEmpty ? Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppTheme.a16700.copyWith(color: AppTheme.black)),
                IconButton(onPressed: () {
                  Get.log('$title 더보기 클릭');
                  Get.toNamed(Routes.ALARM);
                }, icon: const Icon(Icons.add, size: 18, color: AppTheme.black,))
              ],
            ),
            const SizedBox(height: 16,),
            /// 여긴 api 불러와서 list 최신 3개만 뿌려줘야함 --------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${controller.noticeList[0]['GUBUN']}', style: AppTheme.a14400.copyWith(color: AppTheme.a6c6c6c)),
                SizedBox(
                  width: 152,
                  child: Row(
                    children: [
                      SizedBox(width: 12,),
                      Expanded(
                        child: Container(
                            child: Text('${controller.noticeList[0]['TITLE']}', style: AppTheme.a14400.copyWith(color: AppTheme.a6c6c6c),
                              overflow: TextOverflow.ellipsis,), alignment: Alignment.centerRight
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${controller.noticeList[1]['GUBUN']}', style: AppTheme.a14400.copyWith(color: AppTheme.a6c6c6c)),
                Container(
                  width: 152,
                  child: Row(
                    children: [
                      SizedBox(width: 12,),
                      Expanded(child: Container(
                          child: Text('${controller.noticeList[1]['TITLE']}', style: AppTheme.a14400.copyWith(color: AppTheme.a6c6c6c), overflow: TextOverflow.ellipsis), alignment: Alignment.centerRight)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${controller.noticeList[2]['GUBUN']}', style: AppTheme.a14400.copyWith(color: AppTheme.a6c6c6c)),
                Container(
                  width: 152,
                  child: Row(
                    children: [
                      SizedBox(width: 12,),
                      Expanded(child: Container( child: Text('${controller.noticeList[2]['TITLE']}', style: AppTheme.a14400.copyWith(color: AppTheme.a6c6c6c), overflow: TextOverflow.ellipsis), alignment: Alignment.centerRight,)),
                    ],
                  ),
                ),
              ],
            ),
            /// ---------------------------------------------------
          ],
        ) : Container()
    ));
  }
  
  Widget _newItem(String title) {
    return Obx(() => Container(

        margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 24),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppTheme.gray_c_gray_100.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            border: Border.all(color: AppTheme.gray_c_gray_100),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
        ),
        child: controller.noticeList.isNotEmpty ? Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppTheme.a16700.copyWith(color: AppTheme.black)),
                IconButton(onPressed: () {
                    Get.log('$title 더보기 클릭');
                    Get.toNamed(Routes.NOTICE);
              }, icon: Icon(Icons.add, size: 18, color: AppTheme.black,))
              ],
            ),
            const SizedBox(height: 16,),
            /// 여긴 api 불러와서 list 최신 3개만 뿌려줘야함 --------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${controller.noticeList[0]['GUBUN']}', style: AppTheme.a14400.copyWith(color: AppTheme.a6c6c6c)),

                Container(
                  width: 152,
                  child: Row(
                    children: [
                      SizedBox(width: 12,),
                      Expanded(
                        child: Container(
                          child: Text('${controller.noticeList[0]['TITLE']}', style: AppTheme.a14400.copyWith(color: AppTheme.a6c6c6c),
                            overflow: TextOverflow.ellipsis,), alignment: Alignment.centerRight
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${controller.noticeList[1]['GUBUN']}', style: AppTheme.a14400.copyWith(color: AppTheme.a6c6c6c)),
                Container(
                  width: 152,
                  child: Row(
                    children: [
                      SizedBox(width: 12,),
                      Expanded(child: Container(
                          child: Text('${controller.noticeList[1]['TITLE']}', style: AppTheme.a14400.copyWith(color: AppTheme.a6c6c6c), overflow: TextOverflow.ellipsis), alignment: Alignment.centerRight)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${controller.noticeList[2]['GUBUN']}', style: AppTheme.a14400.copyWith(color: AppTheme.a6c6c6c)),
               Container(
                 width: 152,
                 child: Row(
                   children: [
                     SizedBox(width: 12,),
                     Expanded(child: Container( child: Text('${controller.noticeList[2]['TITLE']}', style: AppTheme.a14400.copyWith(color: AppTheme.a6c6c6c), overflow: TextOverflow.ellipsis), alignment: Alignment.centerRight,)),
                   ],
                 ),
               ),
              ],
            ),
            /// ---------------------------------------------------
          ],
        ) : Container()
    ));
  }
}
