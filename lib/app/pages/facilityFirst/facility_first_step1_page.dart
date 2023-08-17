import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:egu_industry/app/pages/facilityFirst/facility_first_controller.dart';
import 'package:egu_industry/app/pages/facilityFirst/facility_first_step2_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
            _bodyArea(),
            _listArea()
          ],
        ),
      ),
      bottomNavigationBar: _bottomButton(context), // 점검의뢰 등록
    );
  }

  Widget _bodyArea() {
    return SliverToBoxAdapter(
        child: Obx(() => Container(
          color: AppTheme.white,
          padding: EdgeInsets.only(left: 18, right: 18, top: 24),
          child: Column(
            children: [
              _calendarItem(),
              SizedBox(height: 12,),
              _urgenTeamItem(),
              SizedBox(height: 12,),
              _choiceButtonItem(),
              SizedBox(height: 24,),
              controller.isShowCalendar.value == true ? _calendar() : Container(),
              SizedBox(height: 12,),
            ],
          ),
        ),)
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
                          .copyWith(color: value == '선택해주세요' ? AppTheme.light_placeholder : AppTheme.a6c6c6c),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedReadUrgency.value = value!;
                  if(controller.choiceButtonVal.value != 0) {
                    controller.readCdConvert();
                    controller.datasList.clear();
                    HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE':'${controller.dayValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : '${controller.engineTeamReadCd.value}', '@p_RESULT_FG' : controller.pResultFg.value}).then((value) =>
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
                          .copyWith(color: value == '선택해주세요' ? AppTheme.light_placeholder : AppTheme.a6c6c6c),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedReadEngineTeam.value = value!;
                  if(controller.choiceButtonVal.value != 0) {
                    controller.readCdConvert();
                    controller.datasList.clear();
                    HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE':'${controller.dayValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : '${controller.engineTeamReadCd.value}', '@p_RESULT_FG' : controller.pResultFg.value}).then((value) =>
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

  Widget _choiceButtonItem() {
    return controller.bSelectedDayFlag.value == true && controller.selectedReadUrgency.value != '선택해주세요'
        && controller.selectedReadEngineTeam.value != '선택해주세요' ? Row(
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
              HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE':'${controller.dayValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : '${controller.engineTeamReadCd.value}', '@p_RESULT_FG' : controller.pResultFg.value}).then((value) =>
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
              HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE':'${controller.dayValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : '${controller.engineTeamReadCd.value}', '@p_RESULT_FG' : controller.pResultFg.value}).then((value) =>
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
              padding: EdgeInsets.only(top: 14, bottom: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    controller.choiceButtonVal.value == 2 ?
                    Row(
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
        SizedBox(width: 10,),
        Expanded(child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  AppTheme.light_ui_background
              ),
              padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      side: controller.choiceButtonVal.value == 3 ? BorderSide(color: Colors.black): BorderSide(color: AppTheme.ae2e2e2),
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
              HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE':'${controller.dayValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : '${controller.engineTeamReadCd.value}', '@p_RESULT_FG' : controller.pResultFg.value}).then((value) =>
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
              padding: EdgeInsets.only(top: 14, bottom: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    controller.choiceButtonVal.value == 3 ?
                    Row(
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
        SizedBox(width: 10,),
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
              HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE':'${controller.dayValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : '${controller.engineTeamReadCd.value}', '@p_RESULT_FG' : controller.pResultFg.value}).then((value) =>
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
              padding: EdgeInsets.only(top: 14, bottom: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    controller.choiceButtonVal.value == 4 ?
                    Row(
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
    ) : Container();
  }

  Widget _calendar() {
    var firstDay = DateTime.utc(2022, 1, 1);
    var lastDay = DateTime.utc(2070, 12, 31);
    return Obx(
          () => Container(

        padding: EdgeInsets.only(bottom: 24),
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
                  defaultTextStyle: TextStyle(fontWeight: FontWeight.w600),
                  weekendTextStyle: TextStyle(fontWeight: FontWeight.w600)),
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
                  HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE':'${controller.dayValue.value}','@p_URGENCY_FG':'${controller.urgencyReadCd.value}', '@p_INS_DEPT' : '${controller.engineTeamReadCd.value}', '@p_RESULT_FG' : controller.pResultFg.value}).then((value) =>
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
            SizedBox(height: 12,),
            SizedBox(height: 12,),

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
    return Obx(() => Container(
              margin: EdgeInsets.only(left: 18, right: 18, bottom: 18),
              padding: EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppTheme.aE2E2E2),
                  color: controller.test[index] ? AppTheme.blue_blue_50 : AppTheme.white,
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      controller.datasList.isNotEmpty ?
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
                                  style: AppTheme.a12500
                                      .copyWith(color: controller.selectedReadUrgency.value == '긴급'
                                      ? AppTheme.af34f39 : AppTheme.a18b858)),
                            ),
                            SizedBox(width: 4,),
                            Container(
                              padding: EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color:  AppTheme.af4f4f4
                              ),

                              child: Text( controller.datasList[index]['INS_FG'].toString() == 'M' ? '설비점검' : '안전점검',
                                  style: AppTheme.a12500
                                      .copyWith(color: AppTheme.a969696)),
                            ),
                            SizedBox(width: 4,),
                            controller.datasList[index]['RESULT_FG'].toString() == '' ? Container() :
                            Container(
                              padding: EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
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
                      /// 등록한 시간과 현재시간 비교
                      Row(
                        children: [
                          Icon(Icons.watch_later_outlined, color: AppTheme.gray_c_gray_200, size: 20,),
                          SizedBox(width: 4,),
                          Text(
                              '${_dateDifference(index)}h 경과',
                              style: AppTheme.a14700
                                  .copyWith(color: AppTheme.a969696)),
                        ],
                      )
                        ],
                      ),
                  SizedBox(height: 8,),
                  /// 마노압연기 뭐시기뭐시기
                  controller.datasList.isNotEmpty ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(controller.datasList[index]['INS_FG'] == 'S' ? '' : controller.datasList[index]['MACH_CODE'].toString() == '' ? '설비 외' : _test(index),
                              style: AppTheme.a16700
                                  .copyWith(color: AppTheme.black)),
                    ],
                  )
                           : Container(),

                  /// 설비 | 설비이상 - 가동조치중 | 전기팀 대충 그런거
                  controller.datasList.isNotEmpty ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Text(controller.datasList[index]['IR_TITLE'].toString(),
                          style: AppTheme.a16400
                              .copyWith(color: AppTheme.a6c6c6c)),
                      SizedBox(width: 4,),
                      Text('|', style: AppTheme.a16400
                          .copyWith(color: AppTheme.a6c6c6c)),
                      SizedBox(width: 4,),
                      Text(controller.selectedReadEngineTeam.value,
                          style: AppTheme.a16400
                              .copyWith(color: AppTheme.a6c6c6c)),
                    ],
                  ) : Container(),
                  SizedBox(height: 12,),
                  controller.datasList.isNotEmpty ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(controller.datasList[index]['IR_USER'].toString(),
                          style: AppTheme.a14400
                              .copyWith(color: AppTheme.a959595)),
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
                  ) : Container(),
                ],
              ),
        ),

     ); // 290 6
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

              Get.to(FacilityFirstStep2Page());
            },
            child: Container(
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
    for(var i = 0; i < controller.machCdList.length; i++) {
      if(controller.machCdList[i] == '${controller.datasList[index]['MACH_CODE']}') {
        return controller.machList[i];
      }
    }
    return '';
  }
}
