
import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/pages/processCheck/process_check_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class ProcessCheckPage extends StatelessWidget {
  ProcessCheckPage({Key? key}) : super(key: key);

  ProcessCheckController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CommonAppbarWidget(title: '공정 조회', isLogo: false, isFirstPage: true,),
            _bodyArea(context),
            Obx(() => controller.processList.length == 0 ? SliverToBoxAdapter(child: Container()) :
            _topTitle(context),),
            _listArea2(),
            SliverToBoxAdapter(child: SizedBox(height: 100,))
            //   _listArea()
          ],
        ),
      ),
      //    bottomNavigationBar: _bottomButton(context), // 점검의뢰 등록
    );
  }

  Widget _bodyArea(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
          color: AppTheme.white,
          padding: const EdgeInsets.only(left: 18, right: 18, top: 24),
          child: Column(
            children: [
              Obx(() => _cmpAndSttItem()),
              const SizedBox(height: 12,),
              _checkButton(),
              const SizedBox(height: 24,),
            ],
          ),
        ),
    );
  }

  Widget _cmpAndSttItem() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: AppTheme.ae2e2e2
                )),
            padding: const EdgeInsets.only(left: 16, right: 12),
            child: DropdownButton<String>(
                borderRadius: BorderRadius.circular(10),
                isExpanded: true,
                underline: Container(
                  height: 1,
                  color: Colors.white,
                ),
                icon: SvgPicture.asset(
                  'assets/app/arrowBottom.svg',
                  color: AppTheme.light_placeholder,
                ),
                dropdownColor: AppTheme.light_ui_01,
                value: controller.selectedGubun.value,
                items: controller.gubun.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: AppTheme.a14500
                          .copyWith(color: value == '선택해주세요' ? AppTheme.light_placeholder : AppTheme.a6c6c6c),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedGubun.value = value!;
                  Get.log('$value 선택!!!!');
                  controller.convert();
                }),
          ),
        ),
      ],
    );
  }



  Widget _checkButton() {
    return Container(
      child: TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              backgroundColor: MaterialStateProperty.all<Color>(AppTheme.a1f1f1f),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(0))),
          onPressed: () async{
            controller.checkButton();
          },
          child: SizedBox(
            height: 56,
            child: Center(
                child: Text(
                  '검색',
                  style: AppTheme.bodyBody2.copyWith(
                    color: const Color(0xfffbfbfb),
                  ),
                )),
          )),
    );
  }



  Widget _listArea() {

    return Obx(() => SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _listItem(index: index, context: context);
        }, childCount: controller.processList.length)));
  }


  Widget _listItem({required BuildContext context, required int index}) {
    return Obx(() => Container(
      margin: EdgeInsets.only(left: 18, right: 18, bottom: 18),
      padding: EdgeInsets.only(top: 24, bottom: 18, left: 18, right: 18),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppTheme.aE2E2E2),
          color: AppTheme.white,
          boxShadow: [
            BoxShadow(
              color: AppTheme.gray_c_gray_100.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          controller.processList.isNotEmpty ?
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(controller.processList[index]['CST_NM'],
                  style: AppTheme.a16700
                      .copyWith(color: AppTheme.black)),
            ],
          )
              : Container(),
          SizedBox(height: 4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(controller.processList[index]['CRP_NAME'].toString(),
                  style: AppTheme.a14500
                      .copyWith(color: AppTheme.a6c6c6c)),
            ],
          ),
          SizedBox(height: 12,),

          controller.processList.isNotEmpty ?
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              Text(controller.processList[index]['CMH_NM'].toString(),
                  style: AppTheme.a14400
                      .copyWith(color: AppTheme.a6c6c6c)),
              const SizedBox(width: 4,),
              Text('|', style: AppTheme.a16400
                  .copyWith(color: AppTheme.light_ui_05)),
              const SizedBox(width: 4,),
              Text('${controller.processList[index]['SLB_NO'].toString()}',
                  style: AppTheme.a14400
                      .copyWith(color: AppTheme.a6c6c6c)),
              const SizedBox(width: 4,),
              Text('|', style: AppTheme.a14400
                  .copyWith(color: AppTheme.light_ui_05)),
              const SizedBox(width: 4,),
              Text('${controller.processList[index]['PRE_DT'].toString()}',
                  style: AppTheme.a14400
                      .copyWith(color: AppTheme.a6c6c6c)),
              const SizedBox(width: 4,),
              Text('|', style: AppTheme.a14400
                  .copyWith(color: AppTheme.light_ui_05)),
              const SizedBox(width: 4,),
              Text('${controller.processList[index]['CUR_DT'].toString()}',
                  style: AppTheme.a14400
                      .copyWith(color: AppTheme.a6c6c6c)),
            ],
          ) : Container(),
          SizedBox(height: 12,),
          controller.processList.isNotEmpty ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('${controller.processList[index]['WRK_NM1'].toString()}',
                      style: AppTheme.a14400
                          .copyWith(color: AppTheme.a959595)),
                ],
              ),
              Container(
                  child: (() {
                    return Text(
                        controller.processList[index]['IST_DT']
                            .toString(),
                        style: AppTheme.a14400
                            .copyWith(color: AppTheme.a959595));
                  })()
              ),
            ],
          ) : Container(),
        ],
      ),
    ),

    ); // 290 6
  }

  Widget _topTitle(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(left: 4, right: 4),
        padding: EdgeInsets.only(left: 18, right: 18),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.light_ui_03,
                    border: Border(
                        left:
                        BorderSide(color: AppTheme.light_text_primary),
                        top: BorderSide(color: AppTheme.light_text_primary),
                        right: BorderSide(
                            color: AppTheme.light_text_primary))),
                height: 45,
                child: Center(
                  child: Text('구분',
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.light_text_primary),
                      textAlign: TextAlign.left),
                ),
              ),
            ),
            MediaQuery.of(context).size.width <= 450 ? Container() :
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.light_ui_03,
                    border: Border(
                        top: BorderSide(color: AppTheme.light_text_primary),
                        right: BorderSide(
                            color: AppTheme.light_text_primary))),
                height: 45,
                child: Center(
                  child: Text(
                    '전일',
                    style: AppTheme.a16700
                        .copyWith(color: AppTheme.light_text_primary),
                  ),
                ),
              ),
            ),
            MediaQuery.of(context).size.width <= 450 ? Container() :
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.light_ui_03,
                    border: Border(

                        top: BorderSide(color: AppTheme.light_text_primary),
                        right: BorderSide(
                            color: AppTheme.light_text_primary))),
                height: 45,
                child: Center(
                  child: Text('금일',
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.light_text_primary),
                      textAlign: TextAlign.left),
                ),
              ),
            ),
            MediaQuery.of(context).size.width <= 450 ? Container() :
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.light_ui_03,
                    border: Border(

                        top: BorderSide(color: AppTheme.light_text_primary),
                        right: BorderSide(
                            color: AppTheme.light_text_primary))),
                height: 45,
                child: Center(
                  child: Text('등록시간',
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.light_text_primary),
                      textAlign: TextAlign.left),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.light_ui_03,
                    border: Border(
                        top: BorderSide(color: AppTheme.light_text_primary),
                        right: BorderSide(
                            color: AppTheme.light_text_primary))),
                height: 45,
                child: Center(
                  child: Text('거래처',
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.light_text_primary),
                      textAlign: TextAlign.left),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.light_ui_03,
                    border: Border(

                        top: BorderSide(color: AppTheme.light_text_primary),
                        right: BorderSide(
                            color: AppTheme.light_text_primary))),
                height: 45,
                child: Center(
                  child: Text('슬라브',
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.light_text_primary),
                      textAlign: TextAlign.left),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.light_ui_03,
                    border: Border(
                        top: BorderSide(color: AppTheme.light_text_primary),
                        right: BorderSide(
                            color: AppTheme.light_text_primary))),
                height: 45,
                child: Center(
                  child: Text('제품명',
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.light_text_primary),
                      textAlign: TextAlign.left),
                ),
              ),
            ),
            MediaQuery.of(context).size.width <= 450 ? Container() :
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.light_ui_03,
                    border: Border(

                        top: BorderSide(color: AppTheme.light_text_primary),
                        right: BorderSide(
                            color: AppTheme.light_text_primary))),
                height: 45,
                child: Center(
                  child: Text('작업자',
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.light_text_primary),
                      textAlign: TextAlign.left),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _listArea2() {
    return Obx(() => SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _listItem2(index: index, context: context);
        }, childCount: controller.processList.length)));
  }
  Widget _listItem2({required BuildContext context,required int index}) {

    return Obx(() => Container(
      margin: EdgeInsets.only(left: 4, right: 4),
      padding: EdgeInsets.only( left: 18, right: 18),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
              color: AppTheme.white,
              border: Border(
                  bottom: controller.processList.length == index ? BorderSide(color: AppTheme.light_text_primary) : BorderSide()
              )),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          left:
                          BorderSide(color: AppTheme.light_text_primary),
                          top: BorderSide(color: AppTheme.light_text_primary),
                          right: BorderSide(
                              color: AppTheme.light_text_primary))),
                  height: 80,
                  child: Center(
                    child: Text(controller.processList[index]['CRP_NAME'].toString(),
                      style: AppTheme.a12500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),
              MediaQuery.of(context).size.width <= 450 ? Container() :
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          top: BorderSide(color: AppTheme.light_text_primary),
                          right: BorderSide(
                              color: AppTheme.light_text_primary))),
                  height: 80,
                  child: Center(
                      child: Text(
                        controller.processList[index]['PRE_DT'].toString(),
                        style: AppTheme.a12500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,)
                  ),
                ),
              ),
              MediaQuery.of(context).size.width <= 450 ? Container() :
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppTheme.white,
                      border: Border(

                          top: BorderSide(color: AppTheme.light_text_primary),
                          right: BorderSide(
                              color: AppTheme.light_text_primary))),
                  height: 80,
                  child: Center(
                    child: Text(controller.processList[index]['CUR_DT'].toString(),
                      style: AppTheme.a12500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),
              MediaQuery.of(context).size.width <= 450 ? Container() :
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          top: BorderSide(color: AppTheme.light_text_primary),
                          right: BorderSide(
                              color: AppTheme.light_text_primary))),
                  height: 80,
                  child: Center(
                    child: Text(controller.processList[index]['IST_DT'].toString(),
                      style: AppTheme.a12500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppTheme.white,
                      border: Border(

                          top: BorderSide(color: AppTheme.light_text_primary),
                          right: BorderSide(
                              color: AppTheme.light_text_primary))),
                  height: 80,
                  child: Center(
                    child: Text(controller.processList[index]['CST_NM'].toString(),
                      style: AppTheme.a12500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppTheme.white,
                      border: Border(

                          top: BorderSide(color: AppTheme.light_text_primary),
                          right: BorderSide(
                              color: AppTheme.light_text_primary))),
                  height: 80,
                  child: Center(
                    child: Text(controller.processList[index]['SLB_NO'].toString(),
                      style: AppTheme.a12500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          top: BorderSide(color: AppTheme.light_text_primary),
                          right: BorderSide(
                              color: AppTheme.light_text_primary))),
                  height: 80,
                  child: Center(
                    child: Text(controller.processList[index]['CMH_NM'].toString(),
                      style: AppTheme.a12500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),
              MediaQuery.of(context).size.width <= 450 ? Container() :
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          top: BorderSide(color: AppTheme.light_text_primary),
                          right: BorderSide(
                              color: AppTheme.light_text_primary))),
                  height: 80,
                  child: Center(
                    child: Text(controller.processList[index]['WRK_NM1'].toString(),
                      style: AppTheme.a12500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}