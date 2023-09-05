import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';

import 'package:egu_industry/app/common/dialog_widget.dart';
import 'package:egu_industry/app/pages/facilitySecond/facility_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


class FacilityStep2Page extends StatelessWidget {
  FacilityStep2Page({Key? key}) : super(key: key);

  FacilityController controller = Get.find();
  final formKey = GlobalKey<FormState>();
  final ScrollController myScrollWorks = ScrollController();
  final ScrollController myScrollWorks2 = ScrollController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CommonAppbarWidget(title: '설비/안전 점검 - 정비내역 등록', isLogo: false, isFirstPage: false ),
            _bodyArea(context),
           //_streamBuilder()

          ],
        ),
      ),
      bottomNavigationBar: _bottomButton(context), // 점검의뢰 등록
    );
  }

  Widget _bodyArea(BuildContext context) {
    return SliverToBoxAdapter(
        child: Obx(() => Container(
          color: AppTheme.white,
          child: Column(
            children: [
              _topDataItem(),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 12,
                color: AppTheme.gray_gray_100,
              ),
              _inputArea(context),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 12,
                color: AppTheme.gray_gray_100,
              ),
              _partChoiceBody(context),
              _otherPartInputBody(context),
            ],
          ),
        ),)
    );
  }

  /*Widget _streamBuilder() {
    return SliverToBoxAdapter(
      child: StreamBuilder(
          stream: Stream.periodic(const Duration(seconds: 1)),
          builder: (c, snapshot) {
            return Container(
              child: (() {
                controller.step2RegistBtn();
              }()),
            );
          }),
    );
  }
*/
  Widget _topDataItem() {
    return Container(
      padding: EdgeInsets.only(left: 18, right: 18, top: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: controller.selectedReadUrgency.value == '긴급' ? AppTheme.afef1ef :
                        AppTheme.aecf9f2
                    ),
                    child: Text(controller.selectedReadUrgency.value, /// 긴급 or 보통 으로
                        style: AppTheme.bodyBody1
                            .copyWith(color: controller.selectedReadUrgency.value == '긴급'
                            ? AppTheme.af34f39 : AppTheme.a18b858)),
                  ),
                  const SizedBox(width: 6,),
                  Container(
                    padding: const EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color:  AppTheme.af4f4f4
                    ),

                    child: Text( controller.selectedContainer[0]['INS_FG'] == 'M' ? '설비점검' : '안전점검',
                        style: AppTheme.bodyBody1
                            .copyWith(color: AppTheme.a969696)),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(_test(),
                      style: AppTheme.a22700
                          .copyWith(color: AppTheme.black)),
                ],
              ),
            ],
          ),
          SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(controller.selectedContainer[0]['IR_TITLE'].toString(),
                  style: AppTheme.a18400
                      .copyWith(color: AppTheme.a6c6c6c)),
            ],
          ),
          const SizedBox(height: 30,),
          Container(
            height: 1, color: AppTheme.gray_c_gray_100,
          ),
          const SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('번호',
                  style: AppTheme.a16400
                      .copyWith(color: AppTheme.a959595)),
              Text('${controller.selectedContainer[0]['IR_CODE']}',
                            style: AppTheme.a16400
                                .copyWith(color: AppTheme.black)),
            ],
          ),
          const SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('의뢰자',
                  style: AppTheme.a16400
                      .copyWith(color: AppTheme.a959595)),
              Text('${controller.selectedContainer[0]['IR_USER']}',
                  style: AppTheme.a16400
                      .copyWith(color: AppTheme.black)),
            ],
          ),
          const SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('점검부서',
                  style: AppTheme.a16400
                      .copyWith(color: AppTheme.a959595)),
              Text(_deptText(),
                  style: AppTheme.a16400
                      .copyWith(color: AppTheme.black)),
            ],
          ),
          const SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('구분',
                  style: AppTheme.a16400
                      .copyWith(color: AppTheme.a959595)),
              Text('${controller.selectedContainer[0]['INS_FG'].toString() == 'M' ? '설비' : '안전'}',
                  style: AppTheme.a16400
                      .copyWith(color: AppTheme.black)),
            ],
          ),
          const SizedBox(height: 12,),
         /* Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('정비유형',
                  style: AppTheme.bodyBody1
                      .copyWith(color: AppTheme.light_text_tertiary, fontSize: 18)),
              Container(
                  child: (() {
                    return Text(
                        controller.selectedContainer[0]['IR_FG'].toString(),
                        style: AppTheme.bodyBody2
                            .copyWith(color: AppTheme.black));
                  })()
              ),
            ],
          ),
          const SizedBox(height: 12,),*/
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('장애일시',
                  style: AppTheme.a16400
                      .copyWith(color: AppTheme.a959595)),
              Container(
                  child: (() {
                    var firstIndex = controller.selectedContainer[0]['IR_DATE']
                        .toString().lastIndexOf(':');
                    var lastIndex = controller.selectedContainer[0]['IR_DATE']
                        .toString().length;
                    return Text(
                        controller.selectedContainer[0]['IR_DATE']
                            .toString().replaceAll('T', ' ').replaceRange(firstIndex, lastIndex, ''),
                        style: AppTheme.a16400
                            .copyWith(color: AppTheme.black));
                  })()
              ),
            ],
          ),
          const SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('경과시간',
                  style: AppTheme.a16400
                      .copyWith(color: AppTheme.a959595)),
              Text('${_dateDifference()}h',
                  style: AppTheme.a16400
                      .copyWith(color: AppTheme.black)),
            ],
          ),
          const SizedBox(height: 40,),

        ],
      ),
    );
  }

  Widget _inputTitle(String title) {
    return Expanded(
        child: Container(
          padding: EdgeInsets.only(top: 16),
          child: Text(title, style: AppTheme.titleSubhead4.copyWith(color: AppTheme.black),),
        )
    );
  }

  Widget _inputArea(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 18, right: 18),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(height: 40,),
            Obx(() => _inputEngineerItem(context)),
            SizedBox(height: 40,),
            Row(
              children: [

                _inputTitle('정비상태'),
              ],
            ),
            const SizedBox(height: 12,),
            Row(
              children: [
                _dropDownItem(context, 2),
              ],
            ),
            SizedBox(height: 25,),
            controller.selectedResultFg.value == '미조치' ?
                Column(
                  children: [
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        _inputTitle('미조치 사유'),
                      ],
                    ),
                    const SizedBox(height: 12,),
                    Row(
                      children: [
                        _dropDownItem(context,  3),
                      ],
                    ),
                  ],
                ) : Container(),
            SizedBox(height: 40,),
            _startEndCalendarItem(context),
            SizedBox(height: 60,),
            _engineContentItem(),
            SizedBox(height: 70,),
          ],
        ),
      ),
    );
  }

  Widget _inputEngineerItem(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('정비자',
            style: AppTheme.titleSubhead4
                .copyWith(color: AppTheme.black)),
        SizedBox(height: 4,),
        InkWell(
          onTap: () {
             controller.showModalUserChoice(context: context);
          },
          child: Container(
            decoration: BoxDecoration(
                border: const Border(
                    bottom:
                    BorderSide(color: AppTheme.light_ui_08),
                   )),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(right: 12, top: 16, bottom: 16),
            child: Text(controller.selectedEnginner.value, style: AppTheme.bodyBody1.copyWith(
                color: controller.selectedEnginner.value == '정비자를 선택해주세요'
                    ?AppTheme.gray_gray_400 : AppTheme.black, fontSize: 17),)

          ),
        ),

      ],
    );
  }

  Widget _dropDownItem(BuildContext context, int flag) {
    return Expanded(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            border: const Border(
              bottom:
              BorderSide(color: AppTheme.light_ui_08),
            )),
        padding: const EdgeInsets.only(right: 12),
        child: DropdownButton<String>(
                  isExpanded: true,
                  underline: Container(
                    height: 1,
                    color: Colors.white,
                  ),
                  icon: SvgPicture.asset(
                    'assets/app/arrowBottom.svg',
                    color: AppTheme.light_ui_08,
                  ),
                  dropdownColor: AppTheme.light_ui_01,
                  value: flag == 1 ? controller.selectedIrFq.value :
                        flag == 2 ? controller.selectedResultFg.value : controller.selectedNoReason.value,
                      //  flag == 3 ? controller.selectedNoReason.value :
                  items: flag == 1 ? controller.irfgList.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(
                        value,
                        style: AppTheme.bodyBody1
                            .copyWith(color: value == '선택해주세요' ? AppTheme.gray_gray_400 : AppTheme.black, fontSize: 17),
                      ),
                    );
                  }).toList() : flag == 2 ?
                  controller.resultFgList.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(
                        value,
                        style: AppTheme.bodyBody1
                            .copyWith(color: value == '전체' ? AppTheme.gray_gray_400 : AppTheme.black, fontSize: 17),
                      ),
                    );
                  }).toList() : controller.noReasonList.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(
                        value,
                        style: AppTheme.bodyBody1
                            .copyWith(color: value == '선택해주세요' ? AppTheme.gray_gray_400 : AppTheme.black, fontSize: 17),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    flag == 1 ?
                    controller.selectedIrFq.value = value! :
                    flag == 2 ?
                    controller.selectedResultFg.value = value! :
                    controller.selectedNoReason.value = value!;


                    Get.log('$value 선택!!!!');
                   // Get.log('${HomeApi.to.BIZ_DATA('L_USER_001')}');
                  }),

      ),
    );
  }
  /// 정비날짜 정하기
  Widget _startEndCalendarItem(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('정비날짜',
            style: AppTheme.titleSubhead4
                .copyWith(color: AppTheme.black)),
        SizedBox(height: 12,),
        Row(
          children: [
            Expanded(
              child: Container(
                child: TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                  ),
                  onPressed: () async{
                    var datePicked = await DatePicker.showSimpleDatePicker(
                      titleText: '날짜 선택',
                      itemTextStyle: AppTheme.a16400,
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
                    decoration: BoxDecoration(
                        border: const Border(

                            bottom:
                            BorderSide(color: AppTheme.light_ui_08),
                           )),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('${controller.dayStartValue.value}', style: AppTheme.bodyBody1
                            .copyWith(color: AppTheme.black
                            , fontSize: 17),),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12,),
            Container(height: 50, child: Center(
              child: Text('~',style: AppTheme.bodyBody1
                .copyWith(color: AppTheme.black)),
            ),),
            SizedBox(width: 12,),
            Expanded(
              child: Container(
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
                      itemTextStyle: AppTheme.a16400,
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
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                            BorderSide(color: AppTheme.light_ui_08),
                           )),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only( right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('${controller.dayEndValue.value}', style: AppTheme.bodyBody1
                            .copyWith(color: AppTheme.black
                            , fontSize: 17),),
                      ],
                    ),

                  ),
                ),
              ),
            ),
          ],
        )



      ],
    );
  }


  Widget _engineContentItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('정비내용',
            style: AppTheme.titleSubhead4
                .copyWith(color: AppTheme.black)),
        SizedBox(height: 24,),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppTheme.black)
            ),
            // borderRadius: BorderRadius.circular(5)
          ),
          width: double.infinity,
          child: TextFormField(
              maxLength: 100,
              maxLines: 5,
              controller: controller.textContentController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintStyle: TextStyle(fontSize: 17, color: AppTheme.gray_gray_400),
                fillColor: Colors.white,
                filled: true,
                hintText: '내용을 입력해주세요',
                border: InputBorder.none,
                  contentPadding: EdgeInsets.all(0)
              ),
              
              showCursor: true,

              // onChanged: ((value) => controller.submitSearch(value)),
            ),
          ),
      ],
    );
  }

  Widget _partChoiceBody(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(left: 18, right: 18, top: 24),
      child: Column(
          children: [
            SizedBox(height: 24,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('사용부품 정보 등록',
                        style: AppTheme.titleHeadline
                            .copyWith(color: AppTheme.black)),
                TextButton(
                  style: ButtonStyle(
                    /*backgroundColor: MaterialStateProperty.all<Color>(
                        AppTheme.light_success
                    ),*/
                    padding: MaterialStateProperty.all(EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(

                            borderRadius: BorderRadius.circular(100)
                        )),
                  ),
                  onPressed: () async{
                    Get.log('추가');
                    controller.showModalPartChoice(context: context);
                  },
                  child: Container(
                        padding: EdgeInsets.only(top: 4, bottom: 4, left: 12, right: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.gray_gray_300)
                        ),
                        child: Center(
                          child: Text('추가/삭제', style: AppTheme.bodyBody1.copyWith(color: AppTheme.light_text_secondary),),
                        ),
                      ),
                ),
                  //  SizedBox(width: 4,),
                    /*Container(
                      padding: EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
                      color: AppTheme.light_cancel,
                      child: Center(
                        child: Text('삭제', style: AppTheme.bodyBody1.copyWith(color: AppTheme.white),),
                      ),
                    )*/

              ],
            ),
            controller.partSelectedList.length != 0 ? Container(
              height: 200,
              child: PrimaryScrollController(
                controller: myScrollWorks,
                child: CupertinoScrollbar(
                  thumbVisibility: true,
                  child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  controller.partSelectedList.length != 0 ?
                  _listArea() : SliverToBoxAdapter( child: Container(),)
                ],
              ),
            ),)) : Container(),
           //  SizedBox(height: 40,)
          ],
      ),
    );
  }

  Widget _otherPartInputBody(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(left: 18, right: 18, top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24,),
          Text('부품재고 외 추가 부품',
                  style: AppTheme.titleHeadline
                      .copyWith(color: AppTheme.black)),
          SizedBox(height: 12,),
          Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 12, right: 12),
                            decoration: BoxDecoration(
                                border: Border.all(color: AppTheme.ae2e2e2),
                            ),
                    width: double.infinity,
                            child: TextFormField(
                              style:  AppTheme.a15500.copyWith(color: AppTheme.a6c6c6c),
                              // maxLines: 5,
                              controller: controller.textItemNameController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: '품명 입력',
                                hintStyle: AppTheme.a15500.copyWith(color: AppTheme.aBCBCBC),
                                border: InputBorder.none,
                              ),
                              showCursor: true,

                              // onChanged: ((value) => controller.submitSearch(value)),
                            ),
                  ),
                  SizedBox(height: 12,),
                  Container(
                    padding: EdgeInsets.only(left: 12, right: 12),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.ae2e2e2),
                    ),
                    width: double.infinity,
                    child: TextFormField(
                      style:  AppTheme.a15500.copyWith(color: AppTheme.a6c6c6c),
                      // maxLines: 5,
                      controller: controller.textItemSpecController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'SPEC 입력',
                        hintStyle: AppTheme.a15500.copyWith(color: AppTheme.aBCBCBC),
                        border: InputBorder.none,
                      ),
                      showCursor: true,

                      // onChanged: ((value) => controller.submitSearch(value)),
                    ),
                  ),

                ],
              ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Row(
                      children: [
                        Text('수량', style: AppTheme.a14400.copyWith(color: AppTheme.black),),
                        InkWell(
                          onTap: () {
                            if(controller.otherPartQty.value > 1) {
                              controller.otherPartQty.value = controller.otherPartQty.value - 1;
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.only(bottom: 12, top: 12 , left: 10),
                            child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: AppTheme.red_red_200
                                ),
                                child: SvgPicture.asset('assets/app/minus.svg', width: 12, height: 12, color: AppTheme.red_red_900,)),
                          ),
                        ),
                        SizedBox(width: 12,),
                        //Text('사용 ', style: AppTheme.a14400.copyWith(color: AppTheme.black)),
                        Text('${controller.otherPartQty.value}', style: AppTheme.a14400.copyWith(color: AppTheme.black)),
                        SizedBox(width: 12,),
                        InkWell(
                          onTap: () {
                            controller.otherPartQty.value = controller.otherPartQty.value + 1;

                          },
                          child: Container(
                            padding: EdgeInsets.only(bottom: 12, top: 12 , right: 10),
                            child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: AppTheme.blue_blue_200
                                ),
                                child: SvgPicture.asset('assets/app/plus.svg', width: 12, height: 12, color: AppTheme.blue_blue_900,)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)
                          )),
                    ),
                    onPressed: () async{
                      Get.log('추가');
                      controller.otherPartList.add({'ITEM_SPEC': controller.textItemSpecController.text
                        , 'ITEM_NAME': controller.textItemNameController.text, 'QTY': controller.otherPartQty.value});
                      controller.textItemSpecController.clear();
                      controller.textItemNameController.clear();
                      controller.otherPartQty.value = 1;
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 4, bottom: 4, left: 12, right: 12),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.gray_gray_300)
                      ),
                      child: Center(
                        child: Text('추가', style: AppTheme.bodyBody1.copyWith(color: AppTheme.light_text_secondary),),
                      ),
                    ),
                  ),

            ],
          ),
          Container(
              height: 200,
              child: PrimaryScrollController(
                controller: myScrollWorks2,
                child: CupertinoScrollbar(
                  thumbVisibility: true,
                  child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      controller.otherPartList.length != 0 ?
                      _otherPartListArea() : SliverToBoxAdapter( child: Container(),)
                    ],
                  ),
                ),)),
          SizedBox(height: 40,)
        ],
      ),
    );
  }

  Widget _listArea() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _listItem(index: index, context: context);
        }, childCount: controller.partSelectedList.length));
  }
  Widget _listItem({required BuildContext context,required int index}) {

    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20, right: 24, left: 8),
      child: Container(
            padding: const EdgeInsets.only(bottom: 20),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: AppTheme.gray_gray_300)
                )
            ),
            child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${controller.partSelectedList[index]['ITEM_NAME']}',
                              style: AppTheme.a16400.copyWith(
                                color: AppTheme.a1f1f1f,
                              ),
                            ),
                            SizedBox(height: 6,),
                            Text(
                              '${controller.partSelectedList[index]['ITEM_SPEC']}',
                              style: AppTheme.a16400.copyWith(
                                color: AppTheme.a1f1f1f,
                              ),
                            ),

                      ],
                    ),
                    Text(
                      controller.partSelectedQtyList.isEmpty ? '1' :
                      '${controller.partSelectedQtyList[index]}',
                      style: AppTheme.a16400.copyWith(
                        color: AppTheme.a1f1f1f,
                      ),
                    )
                  ],
                ),

          ),
    );
  }

  Widget _otherPartListArea() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _otherPartListItem(index: index, context: context);
        }, childCount: controller.otherPartList.length));
  }
  Widget _otherPartListItem({required BuildContext context,required int index}) {

    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20, right: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(top: 4, bottom: 20, right: 8),
                child: InkWell(
                  onTap: () {
                    controller.otherPartList.remove(controller.otherPartList[index]);
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: 12, top: 12 , left: 10),
                    child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppTheme.red_red_200
                        ),
                        child: SvgPicture.asset('assets/app/minus.svg', width: 12, height: 12, color: AppTheme.red_red_900,)),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 12,),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(bottom: 20),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: AppTheme.gray_gray_300)
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${controller.otherPartList[index]['ITEM_NAME']}',
                        style: AppTheme.a16400.copyWith(
                          color: AppTheme.a1f1f1f,
                        ),
                      ),
                      SizedBox(height: 6,),
                      Text(
                        '${controller.otherPartList[index]['ITEM_SPEC']}',
                        style: AppTheme.a16400.copyWith(
                          color: AppTheme.a1f1f1f,
                        ),
                      ),

                    ],
                  ),
                  Text(
                    '${controller.otherPartList[index]['QTY']}',
                    style: AppTheme.a16400.copyWith(
                      color: AppTheme.a1f1f1f,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomButton(BuildContext context) {
    return Obx(() => BottomAppBar(
        color: AppTheme.white,
        surfaceTintColor: AppTheme.white,
      child: (() {
        if(controller.selectedResultFg.value != '전체'
            && controller.selectedNoReason.value != '전체'
        && controller.selectedEnginner.value != '정비자를 선택해주세요' &&  controller.dayStartValue.value != '선택해주세요' &&
            controller.dayEndValue.value != '선택해주세요' && controller.textContentController.text != '') {
          controller.isStep2RegistBtn.value = true;
        }else {
          controller.isStep2RegistBtn.value = false;
        }
        return TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                backgroundColor: controller.isStep2RegistBtn.value ?
                MaterialStateProperty.all<Color>(AppTheme.a1f1f1f) :
                MaterialStateProperty.all<Color>(AppTheme.light_cancel),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(0))),
            onPressed: controller.isStep2RegistBtn.value ? () async {
              controller.cdConvert();
              controller.saveButton();

              SchedulerBinding.instance!.addPostFrameCallback((_) {
                Get.dialog(
                    CommonDialogWidget(contentText: '저장되었습니다', flag: 2, pageFlag: 2,)
                );
              });
            } : null,
            child: Container(
              height: 56,
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: Text(
                    '저장',
                    style: AppTheme.bodyBody2.copyWith(
                      color: const Color(0xfffbfbfb),
                    ),
                  )),
            ));
      })()
    ));
  }
  String _test() {
    for(var i = 0; i < controller.machList.length; i++) {
      if(controller.machList[i]['MACH_CODE'].toString() ==controller.selectedContainer[0]['MACH_CODE'].toString()) {
        return controller.machList[i]['MACH_NAME'];
      }

    }
    return '';
  }
  String _dateDifference() {
    var start = controller.selectedContainer[0]['IR_DATE'].toString().indexOf('.');
    var end = controller.selectedContainer[0]['IR_DATE'].toString().length;
    var time = controller.selectedContainer[0]['IR_DATE'].toString().replaceRange(start, end, '');
    var realDate = DateTime.parse(time);
    var times = DateTime.now().difference(realDate);
    Get.log('realDate $realDate');
    Get.log('times ${times.inHours.toString()}');
    Get.log('now ${DateTime.now()}');
    return times.inHours.toString();
  }

  String _deptText() {
    switch(controller.selectedContainer[0]['INS_DEPT'].toString()) {
      case "1110":
        return '생산팀';
        break;
      case "1160":
        return '공무팀';
        break;
      case "1170":
        return '전기팀';
        break;
      case "9999":
        return '기타';
      default:
        return '';
    }
  }

}
