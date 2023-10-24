
import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/common/common_loading.dart';
import 'package:egu_industry/app/pages/gongjungCheck/gongjung_check_controller.dart';
import 'package:egu_industry/app/pages/inventoryCheck/inventory_check_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';


class GongjungCheckDetailPage extends StatelessWidget {
  GongjungCheckDetailPage({Key? key}) : super(key: key);

  GongjungCheckController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  titleSpacing: 0,
                  leading: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: SvgPicture.asset('assets/app/arrow2Left.svg', color: AppTheme.black,),
                  ),
                  centerTitle: false,
                  title: Text(
                    '상세공정',
                    style: AppTheme.a18700.copyWith(color: Colors.black),
                  ),
                  backgroundColor: Colors.white,
                  iconTheme: const IconThemeData(
                    color: Colors.black,
                  ),
                  floating: true,

                  expandedHeight: 30.0,
                  //bottom: bottom,
                ),
                _topData(),
                Obx(() => controller.processList.isEmpty ? SliverToBoxAdapter(child: Container()) :
                _topTitle(context),),
                _listArea2(),
                SliverToBoxAdapter(child: SizedBox(height: 100,))
                //   _listArea()
              ],
            ),
            Obx(() => CommonLoading(bLoading: controller.isLoading.value))
          ],
        ),
      ),
      //    bottomNavigationBar: _bottomButton(context), // 점검의뢰 등록
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
            child: DropdownButton(
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
                value: controller.selectedCmpMap['FG_NAME'],
                //  flag == 3 ? controller.selectedNoReason.value :
                items: controller.cmpList.map((value) {
                  return DropdownMenuItem<String>(
                    value: value['FG_NAME'],
                    child: Text(
                      value['FG_NAME'],
                      style: AppTheme.a16500
                          .copyWith(color: value['FG_NAME'] == '품명 선택' ? AppTheme.light_placeholder : AppTheme.a6c6c6c),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.cmpList.map((e) {
                    if(e['FG_NAME'] == value) {
                      controller.selectedCmpMap['FG_CODE'] = e['FG_CODE'];
                      controller.selectedCmpMap['FG_NAME'] = e['FG_NAME'];
                    }
                  }).toList();
                  Get.log('$value 선택!!!!');

                }),
          ),
        ),
        SizedBox(width: 16,),
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: AppTheme.ae2e2e2
                )),
            padding: const EdgeInsets.only(left: 16, right: 12),
            child: DropdownButton(
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
                value: controller.selectedSttMap['STT_NM'],
                //  flag == 3 ? controller.selectedNoReason.value :
                items: controller.sttList.map((value) {
                  return DropdownMenuItem<String>(
                    value: value['STT_NM'],
                    child: Text(
                      value['STT_NM'],
                      style: AppTheme.a16500
                          .copyWith(color: value['STT_NM'] == '강종 선택' ? AppTheme.light_placeholder : AppTheme.a6c6c6c),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.sttList.map((e) {
                    if(e['STT_NM'] == value) {
                      controller.selectedSttMap['STT_ID'] = e['STT_ID'];
                      controller.selectedSttMap['STT_NM'] = e['STT_NM'];
                    }
                    //  Get.log('${ controller.selectedLocationMap} 선택!!!!');
                  }).toList();

                  Get.log('$value 선택!!!!');
                  // Get.log('${HomeApi.to.BIZ_DATA('L_USER_001')}');
                }),
          ),
        ),
      ],
    );
  }


  Widget _choiceGb(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 34,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                controller.gubunCd.value = '1';
                controller.checkButton();
              },
              child: Container(
                width: 120,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color:  controller.gubunCd.value == '1' ? AppTheme.black : AppTheme.ae2e2e2,
                        width: controller.gubunCd.value == '1' ? 2 : 1
                    )),
                child: Center(
                  child: Text('공정조회(400)', style: AppTheme.a14500.copyWith(color: AppTheme.a6c6c6c)),
                ),
              ),
            ),
            const SizedBox(width: 12,),
            InkWell(
              onTap: () {
                controller.gubunCd.value = '3';
                controller.checkButton();
              },
              child: Container(
                width: 120,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color:  controller.gubunCd.value == '3' ? AppTheme.black : AppTheme.ae2e2e2,
                        width: controller.gubunCd.value == '3' ? 2 : 1
                    )),
                child: Center(
                  child: Text('공정조회(600)', style: AppTheme.a14500.copyWith(color: AppTheme.a6c6c6c)),
                ),
              ),
            ),
            /*const SizedBox(width: 12,),
            InkWell(
              onTap: () {
                controller.selectedGubunCd.value = 'N';
                controller.checkButton();
              },
              child: Container(
                width: 120,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color:  controller.selectedGubunCd.value == 'N' ? AppTheme.black : AppTheme.ae2e2e2,
                        width: controller.selectedGubunCd.value == 'N' ? 2 : 1
                    )),
                child: Center(
                  child: Text('비가동내역', style: AppTheme.a14500.copyWith(color: AppTheme.a6c6c6c)),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  Widget _cstField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.ae2e2e2),
                  borderRadius: BorderRadius.circular(10)
              ),
              width: double.infinity,
              child: TextFormField(
                style:  AppTheme.a16400.copyWith(color: AppTheme.a6c6c6c),
                // maxLines: 5,
                controller: controller.textController,
                //   textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.none,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: '거래처명을 입력해주세요',
                  hintStyle: AppTheme.a16400.copyWith(color: AppTheme.aBCBCBC),
                  border: InputBorder.none,
                ),
                showCursor: true,

                // onChanged: ((value) => controller.submitSearch(value)),
              ),
            ),
          ),
        ),
        SizedBox(height: 10,),
      ],
    );
  }

  Widget _thicField() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
            border: Border.all(color: AppTheme.ae2e2e2),
            borderRadius: BorderRadius.circular(10)
        ),
        width: double.infinity,
        child: TextFormField(
          style:  AppTheme.a16400.copyWith(color: AppTheme.a6c6c6c),
          // maxLines: 5,
          controller: controller.textController2,
          //   textAlignVertical: TextAlignVertical.center,
          textInputAction: TextInputAction.none,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0),
            fillColor: Colors.white,
            filled: true,
            hintText: '두께를 입력해주세요',
            hintStyle: AppTheme.a16400.copyWith(color: AppTheme.aBCBCBC),
            border: InputBorder.none,
          ),
          showCursor: true,

          // onChanged: ((value) => controller.submitSearch(value)),
        ),

      ),
    );
  }

  Widget _checkButton() {
    return Expanded(
      child: Container(
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
              height: 50,
              child: Center(
                  child: Text(
                    '검색',
                    style: AppTheme.bodyBody2.copyWith(
                      color: const Color(0xfffbfbfb),
                    ),
                  )),
            )),
      ),
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
          /// 마노압연기 뭐시기뭐시기
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
              Text(controller.processList[index]['CMP_NM'].toString(),
                  style: AppTheme.a14500
                      .copyWith(color: AppTheme.a6c6c6c)),
            ],
          ),
          SizedBox(height: 12,),

          controller.processList.isNotEmpty ?
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              Text(controller.processList[index]['STT_NM'].toString(),
                  style: AppTheme.a14400
                      .copyWith(color: AppTheme.a6c6c6c)),
              const SizedBox(width: 4,),
              Text('|', style: AppTheme.a16400
                  .copyWith(color: AppTheme.light_ui_05)),
              const SizedBox(width: 4,),
              Text('${controller.processList[index]['THIC'].toString()} (두께)',
                  style: AppTheme.a14400
                      .copyWith(color: AppTheme.a6c6c6c)),
              const SizedBox(width: 4,),
              Text('|', style: AppTheme.a14400
                  .copyWith(color: AppTheme.light_ui_05)),
              const SizedBox(width: 4,),
              Text('${controller.processList[index]['THIC_ACT'].toString()} (실두께)',
                  style: AppTheme.a14400
                      .copyWith(color: AppTheme.a6c6c6c)),
              const SizedBox(width: 4,),
              Text('|', style: AppTheme.a14400
                  .copyWith(color: AppTheme.light_ui_05)),
              const SizedBox(width: 4,),
              Text('${controller.processList[index]['WIDTH'].toString()} (폭)',
                  style: AppTheme.a14400
                      .copyWith(color: AppTheme.a6c6c6c)),
              const SizedBox(width: 4,),
              Text('|', style: AppTheme.a14400
                  .copyWith(color: AppTheme.light_ui_05)),
              const SizedBox(width: 4,),
              Text('${controller.processList[index]['HARDNESS_ACT'].toString()} (경도)',
                  style: AppTheme.a14400
                      .copyWith(color: AppTheme.a6c6c6c)),
              const SizedBox(width: 4,),
              Text('|', style: AppTheme.a14400
                  .copyWith(color: AppTheme.light_ui_05)),
              const SizedBox(width: 4,),
              Text('${controller.processList[index]['STOCK_QTY'].toString()} (중량)',
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
                  Text('QC메모: ${controller.processList[index]['PP_REMARK'].toString()}',
                      style: AppTheme.a14400
                          .copyWith(color: AppTheme.a959595)),
                ],
              ),
              Container(
                  child: (() {
                    return Text(
                        controller.processList[index]['IN_DATE']
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
    );
  }

  Widget _topData() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(left: 24, right: 24,  bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('번호: ', style: AppTheme.a16400,),
                Text('${controller.selectedContainer[0]['CARD_LIST_NO']}', style: AppTheme.a16700,),
                SizedBox(width: 12,),
                Text('소재: ', style: AppTheme.a16400,),
                Text('${controller.selectedContainer[0]['COIL_ID']}', style: AppTheme.a16700,),
              ],
            )
 
      ),
    );
  }

  Widget _topTitle(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(left: 4, right: 4),
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(
                        left:
                        BorderSide(color: AppTheme.ae2e2e2),
                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 34,
                child: Center(
                  child: Text('공정명',
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.light_text_primary),
                      textAlign: TextAlign.left),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(
                        left:  MediaQuery.of(context).size.width <= 450 ? BorderSide(color: AppTheme.ae2e2e2) :
                        BorderSide(color: Colors.transparent),
                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 34,
                child: Center(
                  child: Text('목표치',
                      style: AppTheme.a16700
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
                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 34,
                child: Center(
                  child: Text(
                    '실측값',
                    style: AppTheme.a16700
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
                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 34,
                child: Center(
                  child: Text(
                    '호기',
                    style: AppTheme.a16700
                        .copyWith(color: AppTheme.light_text_primary),
                  ),
                ),
              ),
            ),
            MediaQuery.of(context).size.width <= 450 ? Container() :
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(
                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 34,
                child: Center(
                  child: Text(
                    '작업일자',
                    style: AppTheme.a16700
                        .copyWith(color: AppTheme.light_text_primary),
                  ),
                ),
              ),
            ),
            MediaQuery.of(context).size.width <= 450 ? Container() :
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(
                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 34,
                child: Center(
                  child: Text(
                    '작업자',
                    style: AppTheme.a16700
                        .copyWith(color: AppTheme.light_text_primary),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(
                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 34,
                child: Center(
                  child: Text(
                    '공급소재',
                    style: AppTheme.a16700
                        .copyWith(color: AppTheme.light_text_primary),
                  ),
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
        }, childCount: controller.processDetailList.length)));
  }
  Widget _listItem2({required BuildContext context,required int index}) {

    return Obx(() => Container(
      margin: EdgeInsets.only(left: 4, right: 4),
      padding: EdgeInsets.only( left: 18, right: 18),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration:  BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          left:
                          BorderSide(color: AppTheme.ae2e2e2),
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                          bottom: index == controller.processDetailList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent)
                      )),
                  height: 60,
                  child: Center(
                    child: Text(controller.processDetailList[index]['CPR_NM'].toString(),
                      style: AppTheme.a12500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                          bottom: index == controller.processDetailList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent)
                      )),
                  height: 60,
                  child: Center(
                    child: Text(controller.processDetailList[index]['GOAL'].toString(),
                      style: AppTheme.a12500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                          bottom: index == controller.processDetailList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent))),
                  height: 60,
                  child: Center(
                    child: Text(controller.processDetailList[index]['ACT'].toString(),
                      style: AppTheme.a12500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                          bottom: index == controller.processDetailList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent))),
                  height: 60,
                  child: Center(
                    child: Text(controller.processDetailList[index]['CMH_NM'].toString(),
                      style: AppTheme.a12500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),
              MediaQuery.of(context).size.width <= 450 ? Container() :
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                          bottom: index == controller.processDetailList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent))),
                  height: 60,
                  child: Center(
                    child: Text(controller.processDetailList[index]['IST_DT'].toString(),
                      style: AppTheme.a12500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),
              MediaQuery.of(context).size.width <= 450 ? Container() :
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                          bottom: index == controller.processDetailList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent))),
                  height: 60,
                  child: Center(
                    child: Text(controller.processDetailList[index]['WRK_NM'].toString(),
                      style: AppTheme.a12500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                          bottom: index == controller.processDetailList.length -1 ? BorderSide(
                              color: AppTheme.ae2e2e2) : BorderSide(
                              color: Colors.transparent)

                      )),
                  height: 60,
                  child: Center(
                    child: Text(controller.processDetailList[index]['COIL_ID'].toString(),
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