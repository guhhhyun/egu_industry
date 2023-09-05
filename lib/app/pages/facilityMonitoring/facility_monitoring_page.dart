
import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/pages/facilityMonitoring/facility_monitoring_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';


class FacilityMonitoringPage extends StatelessWidget {
  FacilityMonitoringPage({Key? key}) : super(key: key);

  FacilityMonitoringController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CommonAppbarWidget(title: '설비가동 모니터링', isLogo: false, isFirstPage: true,),
            _bodyArea(context),
             Obx(() => controller.monitoringList.length == 0 ? SliverToBoxAdapter(child: Container()) :
            _topTitle(context)),
            _listArea2()
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
            const SizedBox(height: 12,),
          //  _listItem(context: context, index: 1),
          ],
        ),
      ),
    );
  }

  Widget _cmpAndSttItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('공정라인',
            style: AppTheme.a15700
                .copyWith(color: AppTheme.black)),
        const SizedBox(height: 8,),
        Row(
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
                    value: controller.selectedLine.value,
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
                      controller.selectedLine.value = value!;
                      Get.log('$value 선택!!!!');
                      controller.convert();
                    }),
              ),
            ),
          ],
        ),
      ],
    );
  }



  Widget _checkButton() {
    return TextButton(
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
        ));
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
                    color: AppTheme.blue_blue_300,
                    border: Border(
                        left:
                        BorderSide(color: AppTheme.light_text_primary),
                        top: BorderSide(color: AppTheme.light_text_primary),
                        right: BorderSide(
                            color: AppTheme.light_text_primary))),
                height: 34,
                child: Center(
                  child: Text('설비',
                      style: AppTheme.titleSubhead1
                          .copyWith(color: AppTheme.light_text_primary),
                      textAlign: TextAlign.left),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(
                        top: BorderSide(color: AppTheme.light_text_primary),
                        right: BorderSide(
                            color: AppTheme.light_text_primary))),
                height: 34,
                child: Center(
                  child: Text(
                    '상태',
                    style: AppTheme.titleSubhead1
                        .copyWith(color: AppTheme.light_text_primary),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(

                        top: BorderSide(color: AppTheme.light_text_primary),
                        right: BorderSide(
                            color: AppTheme.light_text_primary))),
                height: 34,
                child: Center(
                  child: Text('시간',
                      style: AppTheme.titleSubhead1
                          .copyWith(color: AppTheme.light_text_primary),
                      textAlign: TextAlign.left),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(

                        top: BorderSide(color: AppTheme.light_text_primary),
                        right: BorderSide(
                            color: AppTheme.light_text_primary))),
                height: 34,
                child: Center(
                  child: Text('알람코드',
                      style: AppTheme.titleSubhead1
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
        }, childCount: controller.monitoringList.length)));
  }
  Widget _listItem2({required BuildContext context,required int index}) {

    return Obx(() => Container(
      margin: EdgeInsets.only(left: 4, right: 4),
      padding: EdgeInsets.only( left: 18, right: 18),
      child: Container(
          decoration: BoxDecoration(
              color: AppTheme.white,
              border: Border(
                  bottom: controller.monitoringList.length == index ? BorderSide(color: AppTheme.light_text_primary) : BorderSide()
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
                  height: 40,
                  child: Center(
                    child:   Text(controller.monitoringList[index]['CMH_NM'],
                            style: AppTheme.a12500
                                .copyWith(color: AppTheme.black)),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: controller.monitoringList[index]['STATUS_NM'] == '가동'
                          ? AppTheme.a18b858 : controller.monitoringList[index]['STATUS_NM'] == '비가동'
                          ? AppTheme.affd15b : controller.monitoringList[index]['STATUS_NM'] == '설비이상'
                          ? AppTheme.af34f39 : AppTheme.a18b858,
                      border: Border(
                          top: BorderSide(color: AppTheme.light_text_primary),
                          right: BorderSide(
                              color: AppTheme.light_text_primary))),
                  height: 40,
                  child: Center(
                      child: Text(
                          controller.monitoringList[index]['STATUS_NM'],
                        style: AppTheme.a12500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,)
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
                  height: 40,
                  child: Center(
                    child: Text(controller.monitoringList[index]['LEAD_TIME'].toString(),
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
                  height: 40,
                  child: Center(
                    child: Text(controller.monitoringList[index]['ALARM_VAL'] != '' ? '${controller.monitoringList[index]['ALARM_VAL']}' : '',
                      style: AppTheme.a12500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }


 /* Widget _listArea() {
    return Obx(() => SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _listItem(index: index, context: context);
        }, childCount: controller.monitoringList.length)
    )

    );
  }

  /// obx 추가
  Widget _listItem({required BuildContext context, required int index}) {
    return Container(
      margin: const EdgeInsets.only(left: 18, right: 18, bottom: 18),
      padding: const EdgeInsets.only(top: 20, bottom: 18, left: 24, right: 24),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppTheme.aE2E2E2),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: const [0.025, 0],
            colors: [controller.monitoringList[index]['STATUS_NM'] == '가동'
                ? AppTheme.a18b858 : controller.monitoringList[index]['STATUS_NM'] == '비가동'
                ? AppTheme.affd15b : controller.monitoringList[index]['STATUS_NM'] == '설비이상'
                ? AppTheme.af34f39 : AppTheme.a18b858, AppTheme.white], // List of colors
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.gray_c_gray_100.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: controller.monitoringList[index]['STATUS_NM'] == '가동'
                    ? AppTheme.a18b858 : controller.monitoringList[index]['STATUS_NM'] == '비가동'
                    ? AppTheme.affd15b : controller.monitoringList[index]['STATUS_NM'] == '설비이상'
                    ? AppTheme.af34f39 : AppTheme.a18b858
            ),
            child: Text(controller.monitoringList[index]['STATUS_NM'], /// 가동, 비가동, 설비이상
                style: AppTheme.a12700
                    .copyWith(color: AppTheme.white)),
          ),
          const SizedBox(height: 8,),
          controller.monitoringList.isNotEmpty ?
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(controller.monitoringList[index]['CMH_NM'],
                  style: AppTheme.a16700
                      .copyWith(color: AppTheme.black)),
            ],
          )
              : Container(),
          const SizedBox(height: 12,),
          controller.monitoringList.isNotEmpty ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(controller.monitoringList[index]['ALARM_VAL'] != '' ? '알람코드: ${controller.monitoringList[index]['ALARM_VAL']}' : '',
                      style: AppTheme.a14400
                          .copyWith(color: AppTheme.a959595)),
                ],
              ),
              Row(
                children: [
                  Text(controller.monitoringList[index]['LEAD_TIME'].toString(),
                      style: AppTheme.a14400
                          .copyWith(color: AppTheme.a959595)),
                ],
              ),

              *//*Container(
                  child: (() {
                    return Text(
                        controller.monitoringList[index]['IST_DT']
                            .toString(),
                        style: AppTheme.a14400
                            .copyWith(color: AppTheme.a959595));
                  })()
              ),*//*
            ],
          ) : Container(),
        ],
      ),


    );
  }
*/

}