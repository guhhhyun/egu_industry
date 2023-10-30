
import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/common/common_loading.dart';
import 'package:egu_industry/app/common/dialog_widget.dart';
import 'package:egu_industry/app/pages/gagongFacility/gagong_facility_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';


class GagongFacilityPage extends StatelessWidget {
  GagongFacilityPage({Key? key}) : super(key: key);

  GagongFacilityController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                CommonAppbarWidget(title: '가공설 검수', isLogo: false, isFirstPage: true,),
                _bodyArea(context),
                Obx(() => controller.datasList.length == 0 ? SliverToBoxAdapter(child: Container()) :
                _topTitle(context)),
                _listArea2()
                //   _listArea()
              ],
            ),
            Obx(() => CommonLoading(bLoading: controller.isLoading.value))
          ],
        ),
      ),
      bottomNavigationBar: _bottomButton(context), // 공정이동 등록
    );
  }

  Widget _bodyArea(BuildContext context) {
    return SliverToBoxAdapter(
        child: Obx(() => Container(
          color: AppTheme.white,
          padding: const EdgeInsets.only(left: 18, right: 18, top: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _calendarItem(context),
              const SizedBox(height: 24,),

            ],
          ),
        ),)
    );
  }

  Widget _calendarItem(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 30,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  child: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                    ),
                    onPressed: () async{
                      var datePicked = await DatePicker.showSimpleDatePicker(
                        titleText: '날짜 선택',
                        itemTextStyle: AppTheme.a16400.copyWith(color: AppTheme.black),
                        context,
                        confirmText: '확인',
                        cancelText: '취소',
                        textColor: AppTheme.black,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2060),
                        dateFormat: "yyyy-MM-dd",
                        locale: DateTimePickerLocale.ko,
                        looping: true,
                      );

                      if(datePicked != null) {
                        int startIndex = datePicked.toString().indexOf(' ');
                        int lastIndex = datePicked.toString().length;
                        controller.dayStartValue.value = datePicked.toString().replaceRange(startIndex, lastIndex, '');
                      }else {
                        controller.dayStartValue.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
                      }
                      if(datePicked.toString() == '1994-01-01 00:00:00.000') {
                        controller.dayStartValue.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all( color: AppTheme.ae2e2e2)),
                      padding: const EdgeInsets.only(right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(controller.dayStartValue.value, style: AppTheme.a12500
                              .copyWith(color: AppTheme.a6c6c6c
                              , fontSize: 17),),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12,),
                SizedBox(height: 50, width: 15, child: Center(
                  child: Text('~',style: AppTheme.a14500
                      .copyWith(color: AppTheme.black)),
                ),),
                const SizedBox(width: 12,),
                Container(
                  width: 120,
                  child: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          )),
                    ),
                    onPressed: () async{
                      var datePicked = await DatePicker.showSimpleDatePicker(
                        titleText: '날짜 선택',
                        itemTextStyle: AppTheme.a16400.copyWith(color: AppTheme.black),
                        context,
                        confirmText: '확인',
                        cancelText: '취소',
                        textColor: AppTheme.black,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2060),
                        dateFormat: "yyyy-MM-dd",
                        locale: DateTimePickerLocale.ko,
                        looping: true,
                      );
                      if(datePicked != null) {
                        int startIndex = datePicked.toString().indexOf(' ');
                        int lastIndex = datePicked.toString().length;
                        controller.dayEndValue.value = datePicked.toString().replaceRange(startIndex, lastIndex, '');
                      }else {
                        controller.dayEndValue.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
                      }
                      if(datePicked.toString() == '1994-01-01 00:00:00.000') {
                        controller.dayEndValue.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
                      }

                      Get.log("Date Picked ${datePicked.toString()}");
                      //  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppTheme.ae2e2e2)),
                      width: 150,
                      padding: const EdgeInsets.only( right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(controller.dayEndValue.value, style: AppTheme.a14500
                              .copyWith(color: AppTheme.a6c6c6c
                              , fontSize: 17),),
                        ],
                      ),

                    ),
                  ),
                ),
                const SizedBox(width: 12,),
                _choiceButtonItem(),
              ],
            ),
          ),
        ),

      ],
    );
  }

  Widget _choiceButtonItem() {
    return Row(
      children: [
        TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  AppTheme.light_ui_background
              ),
              padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      side: controller.choiceButtonVal.value == 1 ? BorderSide(color: Colors.black, width: 2): BorderSide(color: AppTheme.ae2e2e2),
                      borderRadius: BorderRadius.circular(10)
                  )),
            ),
            onPressed: () {
              Get.log('검수자 미확인 클릭');
              controller.choiceButtonVal.value = 1;
              controller.movCd.value = 'A';

              controller.datasList.clear();

            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.only(top: 14, bottom: 14, left: 12, right: 12),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('검수자 미확인', style: AppTheme.a14700.copyWith(color: AppTheme.a6c6c6c),),
                  ],
                ),
              ),
            )
        ),
        const SizedBox(width: 10,),
        TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  AppTheme.light_ui_background
              ),
              padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      side: controller.choiceButtonVal.value == 2 ? BorderSide(color: Colors.black, width: 2): BorderSide(color: AppTheme.ae2e2e2),
                      borderRadius: BorderRadius.circular(10)
                  )),
            ),
            onPressed: () {
              Get.log('지게차 미호출 클릭');
              controller.choiceButtonVal.value = 2;
              controller.movCd.value = 'N';

              controller.datasList.clear();


            },
            child: Container(
              padding: const EdgeInsets.only(top: 14, bottom: 14, left: 12, right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('지게차 미호출', style: AppTheme.a14700.copyWith(color: AppTheme.a6c6c6c),),
                  ],
                ),
              ),
            )
        ),
        const SizedBox(width: 10,),
        TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  AppTheme.light_ui_background
              ),
              padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      side: controller.choiceButtonVal.value == 3 ? const BorderSide(color: Colors.black, width: 2): const BorderSide(color: AppTheme.ae2e2e2),
                      borderRadius: BorderRadius.circular(10)
                  )),
            ),
            onPressed: () {
              Get.log('전체 클릭');
              controller.choiceButtonVal.value = 3;
              controller.movCd.value = 'Y';
              controller.datasList.clear();
            },
            child: Container(
              padding: const EdgeInsets.only(top: 14, bottom: 14, left: 12, right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('전체', style: AppTheme.a14700.copyWith(color: AppTheme.a6c6c6c),),
                  ],
                ),
              ),
            )
        ),

      ],
    );
  }



  Widget _bottomButton(BuildContext context) {
    return Obx(() => BottomAppBar(
      color: AppTheme.white,
      surfaceTintColor: AppTheme.white,
      child: Row(
        children: [
          Expanded(
            child: TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    backgroundColor: controller.registButton.value ?
                    MaterialStateProperty.all<Color>(AppTheme.a1f1f1f) :
                    MaterialStateProperty.all<Color>(AppTheme.light_cancel),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(0))),
                onPressed: controller.registButton.value ?  () async{
                  Get.log('저장 클릭!!');
                  for(var i = 0; i < controller.processSelectedList.length; i++) {
                    await controller.saveButton(i);
                  }
                  SchedulerBinding.instance!.addPostFrameCallback((_) {
                    Get.dialog(CommonDialogWidget(contentText: '저장되었습니다', flag: 1, pageFlag: 5,));
                    controller.processSelectedList.clear();
                  });
                } : null,
                child: Container(
                  height: 56,
                  child: Center(
                      child: Text(
                        '저장',
                        style: AppTheme.bodyBody2.copyWith(
                          color: const Color(0xfffbfbfb),
                        ),
                      )),
                )),
          ),
        ],
      ),
    ));
  }


  Widget _listArea2() {
    return Obx(() => SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {

          return _listItem2(index: index, context: context);
        }, childCount: controller.datasList.length,)));
  }
  Widget _listItem2({required BuildContext context,required int index}) {

    return Obx(() => Container(
      margin: const EdgeInsets.only(left: 4, right: 4),
      padding: const EdgeInsets.only( left: 18, right: 18),
      child: Container(
          decoration: const BoxDecoration(
            color: AppTheme.white,
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppTheme.white,
                    border: Border(
                        left:
                        const BorderSide(color: AppTheme.ae2e2e2),
                        top: const BorderSide(color: AppTheme.ae2e2e2),
                        right: const BorderSide(
                            color: AppTheme.ae2e2e2),
                        bottom: index == controller.datasList.length -1 ? const BorderSide(color: AppTheme.ae2e2e2) :  const BorderSide(color: Colors.transparent))),
                height: 80,
                width: 60,
                child: Center(
                  child: Text('${index + 1}',
                    style: AppTheme.a16500
                        .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                ),

              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          top: const BorderSide(color: AppTheme.ae2e2e2),
                          right: const BorderSide(
                              color: AppTheme.ae2e2e2),
                          bottom: index == controller.datasList.length -1 ? const BorderSide(color: AppTheme.ae2e2e2) :  const BorderSide(color: Colors.transparent))),
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(controller.datasList[index]['FROM_DATE'].toString().substring(0, 10),
                        style: AppTheme.a16500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                      Text(controller.datasList[index]['FROM_DATE'].toString().substring(11, 16),
                        style: AppTheme.a16500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                    ],
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
                          bottom: index == controller.datasList.length -1 ? BorderSide(color: AppTheme.ae2e2e2) :  BorderSide(color: Colors.transparent))),
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(controller.datasList[index]['FROM_DATE'].toString().substring(0, 10),
                        style: AppTheme.a16500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                      Text(controller.datasList[index]['FROM_DATE'].toString().substring(11, 16),
                        style: AppTheme.a16500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                    ],
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
                          bottom: index == controller.datasList.length -1 ? BorderSide(color: AppTheme.ae2e2e2) :  BorderSide(color: Colors.transparent))),
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(controller.datasList[index]['FROM_DATE'].toString().substring(0, 10),
                        style: AppTheme.a16500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                      Text(controller.datasList[index]['FROM_DATE'].toString().substring(11, 16),
                        style: AppTheme.a16500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                    ],
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
                          bottom: index == controller.datasList.length -1 ? BorderSide(color: AppTheme.ae2e2e2) :  BorderSide(color: Colors.transparent))),
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(controller.datasList[index]['FROM_DATE'].toString().substring(0, 10),
                        style: AppTheme.a16500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                      Text(controller.datasList[index]['FROM_DATE'].toString().substring(11, 16),
                        style: AppTheme.a16500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                    ],
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
                          bottom: index == controller.datasList.length -1 ? BorderSide(color: AppTheme.ae2e2e2) :  BorderSide(color: Colors.transparent))),
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(controller.datasList[index]['FROM_DATE'].toString().substring(0, 10),
                        style: AppTheme.a16500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                      Text(controller.datasList[index]['FROM_DATE'].toString().substring(11, 16),
                        style: AppTheme.a16500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  controller.isDatasSelectedList[index] == false ? controller.isDatasSelectedList[index] = true
                      : controller.isDatasSelectedList[index] = false;
                  controller.isDatasSelectedList[index] == true
                      ? controller.processSelectedList.add(controller.datasList[index])
                      : controller.processSelectedList.remove(controller.datasList[index]);
                  for(var i = 0; i < controller.isDatasSelectedList.length; i++) {
                    if(controller.isDatasSelectedList2[i].toString().contains('true') || controller.isDatasSelectedList[i].toString().contains('true')) {
                      controller.registButton.value = true;
                    }else{
                      controller.registButton.value = false;
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                          bottom: index == controller.datasList.length -1 ? BorderSide(color: AppTheme.ae2e2e2) :  BorderSide(color: Colors.transparent))),
                  height: 80,
                  width: 90,
                  child: Center(
                      child: controller.isDatasSelectedList.isEmpty ?  Container() : controller.isDatasSelectedList[index] ? Icon(Icons.check, color: AppTheme.red_red_800, size: 35,)
                          : Container()
                  ),

                ),
              ),
              InkWell(
                onTap: () {
                  controller.isDatasSelectedList2[index] == false ? controller.isDatasSelectedList2[index] = true
                      : controller.isDatasSelectedList2[index] = false;
                  controller.isDatasSelectedList2[index] == true
                      ? controller.processSelectedList2.add(controller.datasList[index])
                      : controller.processSelectedList2.remove(controller.datasList[index]);
                  for(var i = 0; i < controller.isDatasSelectedList2.length; i++) {
                    if(controller.isDatasSelectedList2[i].toString().contains('true') || controller.isDatasSelectedList[i].toString().contains('true')) {
                      controller.registButton.value = true;
                    }else{
                      controller.registButton.value = false;
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2),
                          bottom: index == controller.datasList.length -1 ? BorderSide(color: AppTheme.ae2e2e2) :  BorderSide(color: Colors.transparent))),
                  height: 80,
                  width: 90,
                  child:Center(
                      child: controller.isDatasSelectedList2.isEmpty ?  Container() : controller.isDatasSelectedList2[index] ? Icon(Icons.check, color: AppTheme.red_red_800, size: 35,)
                          : Container()
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
                          bottom: index == controller.datasList.length -1 ? BorderSide(color: AppTheme.ae2e2e2) :  BorderSide(color: Colors.transparent))),
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(controller.datasList[index]['FROM_DATE'].toString().substring(0, 10),
                        style: AppTheme.a16500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                      Text(controller.datasList[index]['FROM_DATE'].toString().substring(11, 16),
                        style: AppTheme.a16500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                    ],
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
                          bottom: index == controller.datasList.length -1 ? BorderSide(color: AppTheme.ae2e2e2) :  BorderSide(color: Colors.transparent))),
                  height: 80,
                  child: Center(
                    child: Text(controller.datasList[index]['CMP_NM'].toString(),
                      style: AppTheme.a16500
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
                        bottom: index == controller.datasList.length -1 ? BorderSide(color: AppTheme.ae2e2e2) :  BorderSide(color: Colors.transparent),

                      )),
                  height: 80,
                  child: Center(
                      child: controller.isDatasSelectedList.isEmpty ?  Container() : controller.isDatasSelectedList[index] ? Icon(Icons.check, color: AppTheme.red_red_800, size: 35,)
                          : Container()
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }



  Widget _topTitle(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(left: 4, right: 4),
        padding: EdgeInsets.only(left: 18, right: 18),
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: AppTheme.blue_blue_300,
                  border: Border(
                      left:
                      BorderSide(color: AppTheme.gray_c_gray_200),
                      top: BorderSide(color: AppTheme.gray_c_gray_200),
                      right: BorderSide(
                          color: AppTheme.gray_c_gray_200))),
              height: 80,
              width: 60,
              child: Center(
                child: Text('번호',
                    style: AppTheme.a16700
                        .copyWith(color: AppTheme.light_text_primary),
                    textAlign: TextAlign.left),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: AppTheme.blue_blue_300,
                  border: Border(
                      top: BorderSide(color: AppTheme.gray_c_gray_200),
                      right: BorderSide(
                          color: AppTheme.gray_c_gray_200))),
              height: 80,
              width: 90,
              child: Center(
                child: Text(
                  '계량순번',
                  style: AppTheme.a16700
                      .copyWith(color: AppTheme.light_text_primary),
                ),
              ),

            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(

                        top: BorderSide(color: AppTheme.gray_c_gray_200),
                        right: BorderSide(
                            color: AppTheme.gray_c_gray_200))),
                height: 80,
                child: Center(
                  child: Text('차량번호',
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
                    color: AppTheme.blue_blue_300,
                    border: Border(

                        top: BorderSide(color: AppTheme.gray_c_gray_200),
                        right: BorderSide(
                            color: AppTheme.gray_c_gray_200))),
                height: 80,
                child: Center(
                  child: Text('품목',
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
                        top: BorderSide(color: AppTheme.gray_c_gray_200),
                        right: BorderSide(
                            color: AppTheme.gray_c_gray_200))),
                height: 80,
                child: Center(
                  child: Text('거래처',
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
                    color: AppTheme.blue_blue_300,
                    border: Border(

                        top: BorderSide(color: AppTheme.gray_c_gray_200),
                        right: BorderSide(
                            color: AppTheme.gray_c_gray_200))),
                height: 80,
                child: Center(
                  child: Text('중량',
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
                    color: AppTheme.blue_blue_300,
                    border: Border(
                        top: BorderSide(color: AppTheme.gray_c_gray_200),
                        right: BorderSide(
                            color: AppTheme.gray_c_gray_200))),
                height: 80,
                child: Center(
                  child: Text('입차 계량 시간',
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
                    color: AppTheme.blue_blue_300,
                    border: Border(

                        top: BorderSide(color: AppTheme.gray_c_gray_200),
                        right: BorderSide(
                            color: AppTheme.gray_c_gray_200))),
                height: 80,
                child: Center(
                  child: Text('검수자 확인',
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

                        top: BorderSide(color: AppTheme.gray_c_gray_200),
                        right: BorderSide(
                            color: AppTheme.gray_c_gray_200))),
                height: 80,
                child: Center(
                  child: Text('지게차 호출',
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

                        top: BorderSide(color: AppTheme.gray_c_gray_200),
                        right: BorderSide(
                            color: AppTheme.gray_c_gray_200))),
                height: 80,
                child: Center(
                  child: Text('검수자',
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

                        top: BorderSide(color: AppTheme.gray_c_gray_200),
                        right: BorderSide(
                            color: AppTheme.gray_c_gray_200))),
                height: 80,
                child: Center(
                  child: Text('검수자확인 일시',
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

                        top: BorderSide(color: AppTheme.gray_c_gray_200),
                        right: BorderSide(
                            color: AppTheme.gray_c_gray_200))),
                height: 80,
                child: Center(
                  child: Text('지게차 호출 일시',
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
}