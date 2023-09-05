import 'package:egu_industry/app/common/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


class HomeNewsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('LATEST NEWS', style: AppTheme.newTitle)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('이구산업의 공지사항을 확인해보세요.', style: AppTheme.bodyBody2.copyWith(color: AppTheme.a969696))
                  ],
                ),
                const SizedBox(height: 32,),

              ],
            ),
          ),
          _newItem('공지사항'),
        ],
      ),
    );
  }
  Widget _newItem(String title) {
    return Container(

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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppTheme.a16700.copyWith(color: AppTheme.black)),
              IconButton(onPressed: () {
                Get.log('$title 더보기 클릭');
              }, icon: Icon(Icons.add, size: 18, color: AppTheme.black,))
            ],
          ),
          const SizedBox(height: 12,),
          /// 여긴 api 불러와서 list 최신 3개만 뿌려줘야함 --------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ㄴㅇㄴㅇㄴㅇㄴㅇ', style: AppTheme.a14400.copyWith(color: AppTheme.a6c6c6c)),
              Text('ㄴㅇㄴㅇㄴㅇ', style: AppTheme.a14400.copyWith(color: AppTheme.a6c6c6c)),
            ],
          ),
          const SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ㄴㅇㄴㅇㄴㅇㄴㅇ', style: AppTheme.a14400.copyWith(color: AppTheme.a6c6c6c)),
              Text('ㄴㅇㄴㅇㄴㅇ', style: AppTheme.a14400.copyWith(color: AppTheme.a6c6c6c)),
            ],
          ),
          /// ---------------------------------------------------
        ],
      ),
    );
  }
}
