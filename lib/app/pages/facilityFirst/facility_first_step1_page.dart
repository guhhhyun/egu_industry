import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:egu_industry/app/pages/facilityFirst/facility_first_controller.dart';
import 'package:egu_industry/app/pages/facilityFirst/facility_first_modify_page.dart';
import 'package:egu_industry/app/pages/facilityFirst/facility_first_step2_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


class FacilityFirstStep1Page extends StatelessWidget {
  FacilityFirstStep1Page({Key? key}) : super(key: key);

  FacilityFirstController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CommonAppbarWidget(title: '설비/안전 의뢰 조회', isLogo: false, isFirstPage: true ),
            _bodyArea(context),
            _listArea()
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
          padding: EdgeInsets.only(left: 18, right: 18, top: 4),
          child: Column(
            children: [
              _calendar2(context),
              SizedBox(height: 12,),
              _urgenTeamItem(),
              SizedBox(height: 12,),
              Row(
                children: [
                  _dropDownItem(),
                  SizedBox(width: 16,),
                  _irFqDropDownItem()
                ],
              ),
              SizedBox(height: 24,),
            //  controller.isShowCalendar.value == true ? _calendar() : Container(),
              SizedBox(height: 12,),
            ],
          ),
        ),)
    );
  }

  Widget _calendar2(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: InkWell(

              onTap: () async{
                var datePicked = await DatePicker.showSimpleDatePicker(
                  titleText: '날짜 선택',
                  itemTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
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
                  if(controller.choiceButtonVal.value != 0) {
                    controller.datasList.clear();
                    HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.dayStartValue.value}','@p_IR_DATE_TO':'${controller.dayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : '${controller.engineTeamReadCd.value}', '@p_RESULT_FG' : controller.pResultFg.value}).then((value) =>
                    {
                      Get.log('value[DATAS]: ${value['DATAS']}'),
                      if(value['DATAS'] != null) {
                        controller.datasLength.value = value['DATAS'].length,
                        for(var i = 0; i < controller.datasLength.value; i++){
                          controller.datasList.add(value['DATAS'][i]),
                        },
                      },
                      Get.log('datasList: ${controller.datasList}'),
                    });
                  }



                }else {
                  controller.dayStartValue.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
                }
                if(datePicked.toString() == '1994-01-01 00:00:00.000') {
                  controller.dayStartValue.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
                }
              },
              child: Container(
                height: 50,
                width: 150,
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
        ),
        const SizedBox(width: 12,),
        SizedBox(height: 50, width: 15, child: Center(
          child: Text('~',style: AppTheme.a14500
              .copyWith(color: AppTheme.black)),
        ),),
        const SizedBox(width: 12,),
        Expanded(
          child: Container(
            child: InkWell(
              onTap: () async{
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
                  if(controller.choiceButtonVal.value != 0) {
                    controller.datasList.clear();
                    HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.dayStartValue.value}','@p_IR_DATE_TO':'${controller.dayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : '${controller.engineTeamReadCd.value}', '@p_RESULT_FG' : controller.pResultFg.value}).then((value) =>
                    {
                      Get.log('value[DATAS]: ${value['DATAS']}'),
                      if(value['DATAS'] != null) {
                        controller.datasLength.value = value['DATAS'].length,
                        for(var i = 0; i < controller.datasLength.value; i++){
                          controller.datasList.add(value['DATAS'][i]),
                        },
                      },
                      Get.log('datasList: ${controller.datasList}'),
                    });
                  }


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
        ),
      ],
    );
  }

  Widget _calendarItem() {

    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            AppTheme.light_ui_background
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                side: BorderSide(color: AppTheme.ae2e2e2),
                borderRadius: BorderRadius.circular(10)
            )),
      ),
      onPressed: () {
        Get.log('날짜 클릭');
        controller.isShowCalendar.value = true;

      },
      child: Container(
        padding: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
        /*  decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppTheme.gray_c_gray_200)
        ),*/
        child: Row(
          children: [
            Icon(Icons.calendar_today_outlined, color: AppTheme.a959595, size: 20,),
            SizedBox(width: 8,),
            Text('${controller.dayValue.value}', style: AppTheme.a14500.copyWith(color: AppTheme.a6c6c6c),)
          ],
        ),
      ),
    );
  }

  Widget _urgenTeamItem() {
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
                value: controller.selectedReadUrgency.value,
                //  flag == 3 ? controller.selectedNoReason.value :
                items: controller.urgencyList.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: AppTheme.a14500
                          .copyWith(color: AppTheme.a6c6c6c),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedReadUrgency.value = value!;
                  if(controller.choiceButtonVal.value != 0) {
                    controller.readCdConvert();
                    controller.datasList.clear();
                    HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.dayStartValue.value}','@p_IR_DATE_TO':'${controller.dayEndValue.value}','@p_URGENCY_FG':controller.urgencyReadCd.value, '@p_INS_DEPT' : '${controller.engineTeamReadCd.value}', '@p_RESULT_FG' : controller.pResultFg.value}).then((value) =>
                    {
                      Get.log('value[DATAS]: ${value['DATAS']}'),
                      if(value['DATAS'] != null) {
                        controller.datasLength.value = value['DATAS'].length,
                        for(var i = 0; i < controller.datasLength.value; i++){
                          controller.datasList.add(value['DATAS'][i]),
                        },
                      },
                      Get.log('datasList: ${controller.datasList}'),
                    });
                  }
                  Get.log('$value 선택!!!!');
                  // Get.log('${HomeApi.to.BIZ_DATA('L_USER_001')}');
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
                value: controller.selectedReadEngineTeam.value,
                //  flag == 3 ? controller.selectedNoReason.value :
                items: controller.engineTeamList.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: AppTheme.a14500
                          .copyWith(color: AppTheme.a6c6c6c),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedReadEngineTeam.value = value!;
                  if(controller.choiceButtonVal.value != 0) {
                    controller.readCdConvert();
                    controller.datasList.clear();
                    HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.dayStartValue.value}','@p_IR_DATE_TO':'${controller.dayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : '${controller.engineTeamReadCd.value}', '@p_RESULT_FG' : controller.pResultFg.value}).then((value) =>
                    {
                      Get.log('value[DATAS]: ${value['DATAS']}'),
                      if(value['DATAS'] != null) {
                        controller.datasLength.value = value['DATAS'].length,
                        for(var i = 0; i < controller.datasLength.value; i++){
                          controller.datasList.add(value['DATAS'][i]),
                        },
                      },
                      Get.log('datasList: ${controller.datasList}'),
                    });
                  }

                  Get.log('$value 선택!!!!');
                  // Get.log('${HomeApi.to.BIZ_DATA('L_USER_001')}');
                }),
          ),
        ),
      ],
    );
  }

  Widget _dropDownItem() {
    return Expanded(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: AppTheme.ae2e2e2
            )),
        padding: const EdgeInsets.only(left: 16, right: 12),
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
            value: controller.selectedCheckResultFg.value,
            //  flag == 3 ? controller.selectedNoReason.value :
            items: controller.resultFgList.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(
                  value,
                  style: AppTheme.a14500
                      .copyWith(color:  AppTheme.a6c6c6c),
                ),
              );
            }).toList(),
            onChanged: (value) {
              controller.selectedCheckResultFg.value = value!;
              if(value == '전체') {
                controller.choiceButtonVal.value = 1;
                controller.pResultFg.value = 'A';
                for(var i = 0; i < controller.test.length; i++) {
                  controller.test[i] = false;
                }
                controller.registButton.value = false;
                controller.readCdConvert();
                controller.datasList.clear();
                HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.dayStartValue.value}','@p_IR_DATE_TO':'${controller.dayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : '${controller.engineTeamReadCd.value}', '@p_RESULT_FG' : controller.pResultFg.value}).then((value) =>
                {
                  Get.log('value[DATAS]: ${value['DATAS']}'),
                  controller.datasList.clear(),
                  if(value['DATAS'] != null) {
                    controller.datasLength.value = value['DATAS'].length,
                    for(var i = 0; i < controller.datasLength.value; i++){
                      controller.datasList.add(value['DATAS'][i]),
                    },
                  },
                  Get.log('datasList: ${controller.datasList}'),
                });
              }else if(value == '미조치') {
                Get.log('미조치 클릭');
                controller.choiceButtonVal.value = 2;
                controller.pResultFg.value = 'N';
                for(var i = 0; i < controller.test.length; i++) {
                  controller.test[i] = false;
                }
                controller.registButton.value = false;
                controller.readCdConvert();
                controller.datasList.clear();
                HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.dayStartValue.value}','@p_IR_DATE_TO':'${controller.dayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : '${controller.engineTeamReadCd.value}', '@p_RESULT_FG' : controller.pResultFg.value}).then((value) =>
                {
                  Get.log('value[DATAS]: ${value['DATAS']}'),
                  if(value['DATAS'] != null) {
                    controller.datasLength.value = value['DATAS'].length,
                    for(var i = 0; i < controller.datasLength.value; i++){
                      controller.datasList.add(value['DATAS'][i]),
                    },
                  },
                  Get.log('datasList: ${controller.datasList}'),
                });
              }else if(value == '조치완료') {
                Get.log('조치완료 클릭');
                controller.choiceButtonVal.value = 3;
                controller.pResultFg.value = 'Y';
                for(var i = 0; i < controller.test.length; i++) {
                  controller.test[i] = false;
                }
                controller.registButton.value = false;
                controller.readCdConvert();
                controller.datasList.clear();
                HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.dayStartValue.value}','@p_IR_DATE_TO':'${controller.dayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : '${controller.engineTeamReadCd.value}', '@p_RESULT_FG' : controller.pResultFg.value}).then((value) =>
                {
                  Get.log('value[DATAS]: ${value['DATAS']}'),
                  if(value['DATAS'] != null) {
                    controller.datasLength.value = value['DATAS'].length,
                    for(var i = 0; i < controller.datasLength.value; i++){
                      controller.datasList.add(value['DATAS'][i]),
                    },
                  },
                  Get.log('datasList: ${controller.datasList}'),
                });
              }else if(value == '진행중') {
                Get.log('조치 진행중 클릭');
                controller.choiceButtonVal.value = 4;
                controller.pResultFg.value = 'I';
                for(var i = 0; i < controller.test.length; i++) {
                  controller.test[i] = false;
                }
                controller.registButton.value = false;
                controller.readCdConvert();
                controller.datasList.clear();
                HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.dayStartValue.value}','@p_IR_DATE_TO':'${controller.dayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : '${controller.engineTeamReadCd.value}', '@p_RESULT_FG' : controller.pResultFg.value}).then((value) =>
                {
                  Get.log('value[DATAS]: ${value['DATAS']}'),
                  if(value['DATAS'] != null) {
                    controller.datasLength.value = value['DATAS'].length,
                    for(var i = 0; i < controller.datasLength.value; i++){
                      controller.datasList.add(value['DATAS'][i]),
                    },
                  },
                  Get.log('datasList: ${controller.datasList}'),
                });
              }
            }),

      ),
    );
  }

  Widget _irFqDropDownItem() {
    return Expanded(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: AppTheme.ae2e2e2
            )),
        padding: const EdgeInsets.only(left: 16, right: 12),
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
            value: controller.selectedCheckIrFg.value,
            //  flag == 3 ? controller.selectedNoReason.value :
            items: controller.resultIrFqList.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(
                  value,
                  style: AppTheme.a14500
                      .copyWith(color:  AppTheme.a6c6c6c),
                ),
              );
            }).toList(),
            onChanged: (value) {
              controller.selectedCheckIrFg.value = value!;
            }),

      ),
    );
  }

 /* Widget _choiceButtonItem() {
    return Row(
      children: [
        Expanded(child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  AppTheme.light_ui_background
              ),
              padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      side: controller.choiceButtonVal.value == 1 ? BorderSide(color: Colors.black): BorderSide(color: AppTheme.ae2e2e2),
                      borderRadius: BorderRadius.circular(10)
                  )),
            ),
            onPressed: () {
              Get.log('전체 클릭');
              controller.choiceButtonVal.value = 1;
              controller.pResultFg.value = 'A';
              for(var i = 0; i < controller.test.length; i++) {
                controller.test[i] = false;
              }
              controller.registButton.value = false;
              controller.readCdConvert();
              controller.datasList.clear();
              HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.dayStartValue.value}','@p_IR_DATE_TO':'${controller.dayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : '${controller.engineTeamReadCd.value}', '@p_RESULT_FG' : controller.pResultFg.value}).then((value) =>
              {
                controller.datasList.clear(),
                Get.log('value[DATAS]: ${value['DATAS']}'),
                if(value['DATAS'] != null) {
                  controller.datasLength.value = value['DATAS'].length,
                  for(var i = 0; i < controller.datasLength.value; i++){
                    controller.datasList.add(value['DATAS'][i]),
                  },
                },
                Get.log('datasList: ${controller.datasList}'),
              });
            //  Get.log('히히 ${controller.datasList[0]}');
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.only(top: 14, bottom: 14),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    controller.choiceButtonVal.value == 1 ?
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: AppTheme.black, size: 20,),
                        SizedBox(width: 2,)
                      ],
                    ) : Container(),
                    Text('전체', style: AppTheme.a14500.copyWith(color: AppTheme.a6c6c6c),),
                  ],
                ),
              ),
            )
        )),
        const SizedBox(width: 10,),
        Expanded(child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  AppTheme.light_ui_background
              ),
              padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      side: controller.choiceButtonVal.value == 2 ? BorderSide(color: Colors.black): BorderSide(color: AppTheme.ae2e2e2),
                      borderRadius: BorderRadius.circular(10)
                  )),
            ),
            onPressed: () {
              Get.log('미조치 클릭');
              controller.choiceButtonVal.value = 2;
              controller.pResultFg.value = 'N';
              for(var i = 0; i < controller.test.length; i++) {
                controller.test[i] = false;
              }
              controller.registButton.value = false;
              controller.readCdConvert();
              controller.datasList.clear();
              HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.dayStartValue.value}','@p_IR_DATE_TO':'${controller.dayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : '${controller.engineTeamReadCd.value}', '@p_RESULT_FG' : controller.pResultFg.value}).then((value) =>
              {
                controller.datasList.clear(),
                Get.log('value[DATAS]: ${value['DATAS']}'),
                if(value['DATAS'] != null) {
                  controller.datasLength.value = value['DATAS'].length,
                  for(var i = 0; i < controller.datasLength.value; i++){
                    controller.datasList.add(value['DATAS'][i]),
                  },
                },
                Get.log('datasList: ${controller.datasList}'),
              });
            },
            child: Container(
              padding: const EdgeInsets.only(top: 14, bottom: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    controller.choiceButtonVal.value == 2 ?
                    const Row(
                      children: [
                        Icon(Icons.check_circle, color: AppTheme.black, size: 20,),
                        SizedBox(width: 2,)
                      ],
                    )  : Container(),
                    Text('미조치', style: AppTheme.a14500.copyWith(color: AppTheme.a6c6c6c),),
                  ],
                ),
              ),
            )
        )),
        const SizedBox(width: 10,),
        Expanded(child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  AppTheme.light_ui_background
              ),
              padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      side: controller.choiceButtonVal.value == 3 ? const BorderSide(color: Colors.black): const BorderSide(color: AppTheme.ae2e2e2),
                      borderRadius: BorderRadius.circular(10)
                  )),
            ),
            onPressed: () {
              Get.log('조치완료 클릭');
              controller.choiceButtonVal.value = 3;
              controller.pResultFg.value = 'Y';
              for(var i = 0; i < controller.test.length; i++) {
                controller.test[i] = false;
              }
              controller.registButton.value = false;
              controller.readCdConvert();
              controller.datasList.clear();
              HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.dayStartValue.value}','@p_IR_DATE_TO':'${controller.dayEndValue.value}','@p_URGENCY_FG':controller.urgencyReadCd.value, '@p_INS_DEPT' : controller.engineTeamReadCd.value, '@p_RESULT_FG' : controller.pResultFg.value}).then((value) =>
              {
                controller.datasList.clear(),
                Get.log('value[DATAS]: ${value['DATAS']}'),
                if(value['DATAS'] != null) {
                  controller.datasLength.value = value['DATAS'].length,
                  for(var i = 0; i < controller.datasLength.value; i++){
                    controller.datasList.add(value['DATAS'][i]),
                  },
                },
                Get.log('datasList: ${controller.datasList}'),
              });
            },
            child: Container(
              padding: const EdgeInsets.only(top: 14, bottom: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    controller.choiceButtonVal.value == 3 ?
                    const Row(
                      children: [
                        Icon(Icons.check_circle, color: AppTheme.black, size: 20,),
                        SizedBox(width: 2,)
                      ],
                    )  : Container(),
                    Text('조치완료', style: AppTheme.a14500.copyWith(color: AppTheme.a6c6c6c),),
                  ],
                ),
              ),
            )
        )),
        const SizedBox(width: 10,),
        Expanded(child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  AppTheme.light_ui_background
              ),
              padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      side: controller.choiceButtonVal.value == 4 ? BorderSide(color: Colors.black): BorderSide(color: AppTheme.ae2e2e2),
                      borderRadius: BorderRadius.circular(10)
                  )),
            ),
            onPressed: () {
              Get.log('조치 진행중 클릭');
              controller.choiceButtonVal.value = 4;
              controller.pResultFg.value = 'I';
              for(var i = 0; i < controller.test.length; i++) {
                controller.test[i] = false;
              }
              controller.registButton.value = false;
              controller.readCdConvert();
              controller.datasList.clear();
              HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.dayStartValue.value}','@p_IR_DATE_TO':'${controller.dayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : '${controller.engineTeamReadCd.value}', '@p_RESULT_FG' : controller.pResultFg.value}).then((value) =>
              {
                controller.datasList.clear(),
                Get.log('value[DATAS]: ${value['DATAS']}'),
                if(value['DATAS'] != null) {
                  controller.datasLength.value = value['DATAS'].length,
                  for(var i = 0; i < controller.datasLength.value; i++){
                    controller.datasList.add(value['DATAS'][i]),
                  },
                },
                Get.log('datasList: ${controller.datasList}'),
              });
            },
            child: Container(
              padding: const EdgeInsets.only(top: 14, bottom: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    controller.choiceButtonVal.value == 4 ?
                    const Row(
                      children: [
                        Icon(Icons.check_circle, color: AppTheme.black, size: 20,),
                        SizedBox(width: 2,)
                      ],
                    ) : Container(),
                    Text('진행중', style: AppTheme.a14500.copyWith(color: AppTheme.a6c6c6c),),
                  ],
                ),
              ),
            )
        )),

      ],
    );
  }*/

  Widget _calendar() {
    var firstDay = DateTime.utc(2022, 1, 1);
    var lastDay = DateTime.utc(2070, 12, 31);
    return Obx(
          () => Container(

        padding: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
            color: AppTheme.light_ui_background,
            border: Border.all(color: AppTheme.light_ui_02),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  //  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 3)),
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  //  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(1, 0))
            ]),
        margin: const EdgeInsets.only(
            left: AppTheme.spacing_m_16, right: AppTheme.spacing_m_16, bottom: 50),
        child: Column(
          children: [
            TableCalendar(
        currentDay: DateTime.now(),
              calendarStyle:  CalendarStyle(
                  selectedDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  todayTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                  todayDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  defaultDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  weekendDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  outsideDaysVisible: false,
                  defaultTextStyle: const TextStyle(fontWeight: FontWeight.w600),
                  weekendTextStyle: const TextStyle(fontWeight: FontWeight.w600)),
              locale: 'ko-KR',
              headerStyle: HeaderStyle(
                  titleCentered: true,
                  titleTextStyle: AppTheme.titleSubhead3
                      .copyWith(color: AppTheme.light_text_primary),
                  leftChevronIcon: SvgPicture.asset(
                    'assets/app/arrow2Left.svg',
                    width: 24,
                  ),
                  leftChevronPadding: const EdgeInsets.only(left: 0),
                  formatButtonVisible: false,
                  rightChevronIcon: SvgPicture.asset(
                    'assets/app/arrow2Right.svg',
                    width: 24,
                  ) // formatButtonShowsNext: false
              ),
              firstDay: firstDay,
              lastDay: lastDay,
              /*enabledDayPredicate: (day) {
                  return controller.checkPossibleDate(day: day);
                },*/
              focusedDay: controller.selectedDay.value,
              selectedDayPredicate: (day) {
                return isSameDay(controller.selectedDay.value, day);
              },
              onDaySelected: (_selectedDay, _focusedDay) {
                Get.log('onDaySelected');
                Get.log('_selectedDay = ${_selectedDay.toString()}');
                Get.log('_focusedDay = ${_focusedDay.toString()}');
                // focusedDay = _focusedDay;


              //  controller.bSelectedDayFlag.value = true;
                //  controller.isShowCalendar.value = false;
                controller.selectedDay.value = _focusedDay;
                controller.dayValue.value = controller.dayValue.value = DateFormat('yyyy-MM-dd').format(controller.selectedDay.value);
                controller.bSelectedDayFlag.value = true;
                controller.isShowCalendar.value = false;
                if(controller.choiceButtonVal.value != 0) {
                  controller.datasList.clear();
                  HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE_FR':'${controller.dayStartValue.value}','@p_IR_DATE_TO':'${controller.dayEndValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : '${controller.engineTeamReadCd.value}', '@p_RESULT_FG' : controller.pResultFg.value}).then((value) =>
                  {
                    Get.log('value[DATAS]: ${value['DATAS']}'),
                    if(value['DATAS'] != null) {
                      controller.datasLength.value = value['DATAS'].length,
                      for(var i = 0; i < controller.datasLength.value; i++){
                        controller.datasList.add(value['DATAS'][i]),
                      },
                    },
                    Get.log('datasList: ${controller.datasList}'),
                  });
                }
              },
            ),
            const SizedBox(height: 12,),
            const SizedBox(height: 12,),

          ],
        ),
      ),
    );
  }



  Widget _listArea() {
    controller.test.clear();
    return Obx(() => SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          controller.test.add(false);
          return _listItem(index: index, context: context);
        }, childCount: controller.datasList.length)));
  }


  Widget _listItem({required BuildContext context, required int index}) {
    return  TextButton(
      style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(5)))),
          /*backgroundColor: MaterialStateProperty.all<Color>(
                AppTheme.light_primary,
              ),*/
          padding:
          MaterialStateProperty.all(const EdgeInsets.all(0))),
      onPressed: () {
        if(controller.test[index] == true) {
          controller.test[index] = false;
          controller.registButton.value = false;
          controller.selectedContainer.clear();
        }else {
          for(var i = 0; i < controller.test.length; i++) {
            controller.test[i] = false;
          }
          controller.selectedContainer.clear();
          controller.test[index] = true;
          if(controller.test[index] == true) {
            controller.registButton.value = true;
            controller.selectedContainer.add(controller.datasList[index]);
          }
          controller.modifyCheck();
         // controller.modifyIrfqCdCv();
          modifyEngineTeam();
          controller.modifyErrorTime.value = controller.selectedContainer[0]['IR_DATE'];
          var indexLast = controller.modifyErrorTime.value.lastIndexOf(':');
          controller.modifyErrorTime.value = controller.modifyErrorTime.value.replaceFirst('T', ' ').replaceRange(indexLast, controller.modifyErrorTime.value.length, '');
          controller.selectedContainer[0]['INS_FG'] == 'M' ? controller.modifySelectedIns.value = '설비점검' : controller.modifySelectedIns.value = '안전점검';
          controller.selectedContainer[0]['URGENCY_FG'] == 'N' ? controller.modifySelectedReadUrgency.value = '보통' : controller.modifySelectedReadUrgency.value = '긴급';
          controller.modifySelectedMachMap['MACH_CODE'] = controller.selectedContainer[0]['MACH_CODE'];
          controller.selectedContainer[0]['MACH_CODE'] == '' ? controller.modifySelectedMachMap['MACH_NAME'] = '전체' : controller.modifySelectedMachMap['MACH_NAME'] = modifyMach();
          controller.modifyTextTitleController.text = controller.selectedContainer[0]['IR_TITLE'];

          Get.to(const FacilityFirstModifyPage());
        }
      },
      child: Obx(() => Container(
        margin: const EdgeInsets.only(left: 18, right: 18, bottom: 18),
        padding: const EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: controller.test[index] ? Border.all(color: AppTheme.black, width: 3) : Border.all(color: AppTheme.ae2e2e2) ,
            color: AppTheme.white,
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                controller.datasList.isNotEmpty ?
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: controller.selectedReadUrgency.value == '긴급' ? AppTheme.afef1ef :
                          AppTheme.aecf9f2
                      ),
                      child: Text(controller.selectedReadUrgency.value, /// 긴급 or 보통 으로
                          style: AppTheme.a12500
                              .copyWith(color: controller.selectedReadUrgency.value == '긴급'
                              ? AppTheme.af34f39 : AppTheme.a18b858)),
                    ),
                    const SizedBox(width: 4,),
                    Container(
                      padding: const EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:  AppTheme.af4f4f4
                      ),

                      child: Text( controller.datasList[index]['INS_FG'].toString() == 'M' ? '설비점검' : '안전점검',
                          style: AppTheme.a12500
                              .copyWith(color: AppTheme.a969696)),
                    ),
                    const SizedBox(width: 4,),
                    controller.datasList[index]['RESULT_FG'].toString() == '' ? Container() :
                    Container(
                      padding: const EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:  AppTheme.af4f4f4
                      ),

                      child: Text( controller.datasList[index]['RESULT_FG'].toString() == 'Y' ? '정비완료'
                          : controller.datasList[index]['RESULT_FG'].toString() == 'I' ? '정비 진행중' :
                      controller.datasList[index]['RESULT_FG'].toString() == 'N' ? '미조치' : '',
                          style: AppTheme.a12500
                              .copyWith(color: AppTheme.a969696)),
                    )
                  ],
                )
                    : Container(),
                controller.datasList.isNotEmpty ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(controller.datasList[index]['INS_FG'].toString() == 'S' ? '' : controller.datasList[index]['MACH_CODE'].toString() == '' ? '설비 외' : _test(index),
                        style: AppTheme.a16700
                            .copyWith(color: AppTheme.black)),
                  ],
                )
                    : Container(),
              ],
            ),
            const SizedBox(height: 8,),

            /// 설비 | 설비이상 - 가동조치중 | 전기팀 대충 그런거
            controller.datasList.isNotEmpty ?
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Text(controller.datasList[index]['IR_TITLE'].toString(),
                    style: AppTheme.a16400
                        .copyWith(color: AppTheme.a6c6c6c)),
                const SizedBox(width: 4,),
                Text('|', style: AppTheme.a16400
                    .copyWith(color: AppTheme.a6c6c6c)),
                const SizedBox(width: 4,),
                Text(controller.selectedReadEngineTeam.value,
                    style: AppTheme.a16400
                        .copyWith(color: AppTheme.a6c6c6c)),
              ],
            ) : Container(),
            const SizedBox(height: 12,),
            controller.datasList.isNotEmpty ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(controller.datasList[index]['IR_USER'].toString(),
                        style: AppTheme.a14400
                            .copyWith(color: AppTheme.a959595)),
                    const SizedBox(width: 12,),
                    Container(
                        child: (() {
                          var firstIndex = controller.datasList[index]['IR_DATE']
                              .toString().lastIndexOf(':');
                          var lastIndex = controller.datasList[index]['IR_DATE']
                              .toString().length;
                          return Text(
                              controller.datasList[index]['IR_DATE']
                                  .toString().replaceAll('T', ' ').replaceRange(firstIndex, lastIndex, ''),
                              style: AppTheme.a14400
                                  .copyWith(color: AppTheme.a959595));
                        })()
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.watch_later_outlined, color: AppTheme.gray_c_gray_200, size: 20,),
                    const SizedBox(width: 4,),
                    Text(
                        '${_dateDifference(index)}h 경과',
                        style: AppTheme.a14700
                            .copyWith(color: AppTheme.a969696)),
                  ],
                )
              ],
            ) : Container(),
          ],
        ),
      ),)
     );
  }
  Widget _bottomButton(BuildContext context) {
    return BottomAppBar(
      color: AppTheme.white,
      surfaceTintColor: AppTheme.white,
      child: Container(
        child: TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                backgroundColor: MaterialStateProperty.all<Color>(AppTheme.a1f1f1f) ,
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(0))),
            onPressed: () {
              Get.log('신규 등록 클릭!!');
              Get.to(const FacilityFirstStep2Page());
            },
            child: SizedBox(
              height: 56,
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: Text(
                    '신규',
                    style: AppTheme.bodyBody2.copyWith(
                      color: const Color(0xfffbfbfb),
                    ),
                  )),
            )),
      ),
    );
  }

  Widget _modifyAlert() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      scrollable: true,
      content: Container(
        padding: EdgeInsets.only(top: 12, bottom: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '수정하시겠습니까?',
              style: AppTheme.bodyBody2,
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
            ),
          ],
        ),
      ),
      buttonPadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.all(0),
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.only(top: 16, bottom: 12),
      actions: [
        Row(
          children: [
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(5)))),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0))),
                // 성공
                onPressed: () {
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  color: AppTheme.light_cancel,
                  child: Center(
                      child: Text(
                          '취소',
                          style: AppTheme.titleSubhead2.copyWith(color: AppTheme.white)
                      )),
                ),
              ),
            ),
            const SizedBox(width: 12,),
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(5)))),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0))),
                // 성공
                onPressed: () {
                  modifyEngineTeam();
                  controller.modifyErrorTime.value = controller.selectedContainer[0]['IR_DATE'];
                  var index = controller.modifyErrorTime.value.lastIndexOf(':');
                  controller.modifyErrorTime.value = controller.modifyErrorTime.value.replaceFirst('T', ' ').replaceRange(index, controller.modifyErrorTime.value.length, '');
                  controller.selectedContainer[0]['INS_FG'] == 'M' ? controller.modifySelectedIns.value = '설비점검' : controller.modifySelectedIns.value = '안전점검';
                  controller.selectedContainer[0]['URGENCY_FG'] == 'N' ? controller.modifySelectedReadUrgency.value = '보통' : controller.modifySelectedReadUrgency.value = '긴급';
                  controller.modifySelectedMachMap['MACH_CODE'] = controller.selectedContainer[0]['MACH_CODE'];
                  controller.selectedContainer[0]['MACH_CODE'] == '' ? controller.modifySelectedMachMap['MACH_NAME'] = '전체' : controller.modifySelectedMachMap['MACH_NAME'] = modifyMach();
                  controller.modifyTextTitleController.text = controller.selectedContainer[0]['IR_TITLE'];

                  Get.to(const FacilityFirstModifyPage());
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  color: Colors.black,
                  child: Center(
                      child: Text(
                          '확인',
                          style: AppTheme.titleSubhead2.copyWith(color: AppTheme.white)
                      )),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _dateDifference(int index) {
    var start = controller.datasList[index]['IR_DATE'].toString().indexOf('.');
    var end = controller.datasList[index]['IR_DATE'].toString().length;
    var time = controller.datasList[index]['IR_DATE'].toString().replaceRange(start, end, '');
    var realDate = DateTime.parse(time);
    var times = DateTime.now().difference(realDate);
    Get.log('realDate $realDate');
    Get.log('times ${times.inHours.toString()}');
    Get.log('now ${DateTime.now()}');
    return times.inHours.toString();
  }

  String _test(int index) {
      for(var u = 0; u < controller.machList.length; u++) {
        if(controller.machList[u]['MACH_CODE'].toString() == controller.datasList[index]['MACH_CODE'].toString()) {
         return controller.machList[u]['MACH_NAME'];
        }
      }

    return '';
  }

  String modifyMach() {
    for(var u = 0; u < controller.modifyMachList.length; u++) {
      if(controller.modifyMachList[u]['MACH_CODE'].toString() == controller.selectedContainer[0]['MACH_CODE'].toString()) {
        return controller.modifyMachList[u]['MACH_NAME'];
      }
    }

    return '전체';
  }

  void modifyEngineTeam() {
    switch(controller.selectedContainer[0]['INS_DEPT']) {
      case "1110":
        controller.modifySelectedReadEngineTeam.value = '생산팀';
        break;
      case "1160":
        controller.modifySelectedReadEngineTeam.value = '공무팀';
        break;
      case "1170":
        controller.modifySelectedReadEngineTeam.value = '전기팀';
        break;
      case "9999":
        controller.modifySelectedReadEngineTeam.value = '기타';
      default:
        controller.modifySelectedReadEngineTeam.value = '';
    }
  }



}
