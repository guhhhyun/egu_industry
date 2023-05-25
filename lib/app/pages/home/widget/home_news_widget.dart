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
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('LATEST NEWS', style: AppTheme.titleDisplay2)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('동국제강의 최신 소식을 확인해보세요.', style: AppTheme.titleSubhead4.copyWith(color: AppTheme.gray_c_gray_400))
                  ],
                ),
                const SizedBox(height: 32,),

              ],
            ),
          ),
          _newItem('공지사항'),
          _newItem('SGS 성적서'),
          _newItem('전자공고'),
        ],
      ),
    );
  }
  Widget _newItem(String title) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 24),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black12
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 18
              ),),
              IconButton(onPressed: () {
                Get.log('$title 더보기 클릭');
              }, icon: Icon(Icons.add))
            ],
          ),
          const SizedBox(height: 12,),
          /// 여긴 api 불러와서 list 최신 3개만 뿌려줘야함 --------------------
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ㄴㅇㄴㅇㄴㅇㄴㅇ', style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                  fontSize: 18
              ),),
              Text('ㄴㅇㄴㅇㄴㅇ', style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                  fontSize: 18
              ),),
            ],
          ),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ㄴㅇㄴㅇㄴㅇㄴㅇ', style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                  fontSize: 18
              ),),
              Text('ㄴㅇㄴㅇㄴㅇ', style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                  fontSize: 18
              ),),
            ],
          ),
          /// ---------------------------------------------------
        ],
      ),
    );
  }
}
