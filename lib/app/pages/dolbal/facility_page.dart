import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:egu_industry/app/pages/blueTooth/blue_tooth_controller.dart';
import 'package:egu_industry/app/pages/dolbal/facility_controller.dart';
import 'package:egu_industry/app/pages/dolbal/facility_step2_page.dart';
import 'package:egu_industry/app/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


class FacilityPage extends StatelessWidget {
  FacilityPage({Key? key}) : super(key: key);

  FacilityController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CommonAppbarWidget(title: '설비/안전 점검 조회', isLogo: false, ),
          _bodyArea(),
          _listArea()
        ],
      ),
      bottomNavigationBar: _bottomButton(context), // 점검의뢰 등록
    );
  }

  Widget _bodyArea() {
    return SliverToBoxAdapter(
      child: Obx(() => Container(
        padding: EdgeInsets.only(left: 18, right: 18, top: 24),
        child: Column(
          children: [
            _calendarItem(),
            SizedBox(height: 12,),
            _choiceButtonItem(),
            SizedBox(height: 24,),
            controller.isShowCalendar.value == true ? _calendar() : Container(),
            _button(),
            SizedBox(height: 12,),
          ],
        ),
      ),)
    );
  }

  Widget _calendarItem() {

    Get.log('${controller.dayValue}');
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            AppTheme.light_ui_background
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
             RoundedRectangleBorder(
              side: BorderSide(color: Color(0xffe6e9ef)),
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
            Icon(Icons.calendar_today_outlined, color: AppTheme.gray_c_gray_400,),
            SizedBox(width: 8,),
            Text('${controller.dayValue.value}', style: AppTheme.bodyBody1.copyWith(color: AppTheme.gray_c_gray_400),)
          ],
        ),
      ),
    );
  }

  Widget _choiceButtonItem() {
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
                    side: BorderSide(color: Color(0xffe6e9ef)),
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
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: controller.choiceButtonVal.value == 2
                  || controller.choiceButtonVal.value == 3
                  || controller.choiceButtonVal.value == 4 ? null
                  : AppTheme.blue_blue_200,
            ),
            padding: EdgeInsets.only(top: 14, bottom: 14),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  controller.choiceButtonVal.value == 1 ?
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: AppTheme.black, size: 10),
                      SizedBox(width: 4,)
                    ],
                  ) : Container(),
                  Text('전체', style: AppTheme.bodyBody1.copyWith(color: AppTheme.black),),
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
                      side: BorderSide(color: Color(0xffe6e9ef)),
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
            },
            child: Container(
              padding: EdgeInsets.only(top: 14, bottom: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: controller.choiceButtonVal.value == 1
                    || controller.choiceButtonVal.value == 3
                    || controller.choiceButtonVal.value == 4 ? null
                    : AppTheme.blue_blue_200,
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    controller.choiceButtonVal.value == 2 ?
                    Row(
                      children: [
                        Icon(Icons.check_circle_outline, color: AppTheme.black, size: 10,),
                        SizedBox(width: 4,)
                      ],
                    ) : Container(),
                    Text('미조치', style: AppTheme.bodyBody1.copyWith(color: AppTheme.black),),
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
                      side: BorderSide(color: Color(0xffe6e9ef)),
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
            },
            child: Container(
              padding: EdgeInsets.only(top: 14, bottom: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: controller.choiceButtonVal.value == 1
                    || controller.choiceButtonVal.value == 2
                    || controller.choiceButtonVal.value == 4 ? null
                    : AppTheme.blue_blue_200,
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    controller.choiceButtonVal.value == 3 ?
                    Row(
                      children: [
                        Icon(Icons.check_circle_outline, color: AppTheme.black, size: 10),
                        SizedBox(width: 4,)
                      ],
                    ) : Container(),
                    Text('조치완료', style: AppTheme.bodyBody1.copyWith(color: AppTheme.black),),
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
                      side: BorderSide(color: Color(0xffe6e9ef)),
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
            },
            child: Container(
              padding: EdgeInsets.only(top: 14, bottom: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: controller.choiceButtonVal.value == 1
                    || controller.choiceButtonVal.value == 2
                    || controller.choiceButtonVal.value == 3 ? null
                    : AppTheme.blue_blue_200,
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    controller.choiceButtonVal.value == 4 ?
                    Row(
                      children: [
                        Icon(Icons.check_circle_outline, color: AppTheme.black, size: 10),
                        SizedBox(width: 4,)
                      ],
                    ) : Container(),
                    Text('조치 진행중', style: AppTheme.bodyBody1.copyWith(color: AppTheme.black),),
                  ],
                ),
              ),
            )
        )),

      ],
    );
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
            left: AppTheme.spacing_m_16, right: AppTheme.spacing_m_16),
        child: Column(
          children: [
            TableCalendar(
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
                    'assets/app/arrow2Right.svg',
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


                controller.bSelectedDayFlag.value = true;
              //  controller.isShowCalendar.value = false;
                controller.selectedDay.value = _focusedDay;
                controller.dayValue.value = DateFormat('yyyy-MM-dd').format(controller.selectedDay.value);
              },
            ),
            SizedBox(height: 12,),
            TextButton(
              onPressed: () {
                Get.log('확인 클릭!!');
                controller.isShowCalendar.value = false;
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    )),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 12, right: 12),
                padding: EdgeInsets.only(top: 12, bottom: 12),
                decoration: BoxDecoration(
                  color: AppTheme.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text('확인', style: AppTheme.bodyBody2.copyWith(color: AppTheme.white),),
                ),
              ),
            ),
            SizedBox(height: 12,),

          ],
        ),
      ),
    );
  }

  Widget _button() {
    return TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            controller.bSelectedDayFlag.value == true ?
              AppTheme.blue_blue_500 : AppTheme.light_cancel
          ),
          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xffe6e9ef)),
                  borderRadius: BorderRadius.circular(10)
              )),
        ),
        onPressed: controller.bSelectedDayFlag.value == true ? () {
          Get.log('조회 클릭');
          controller.datasList.clear();
          HomeApi.to.PROC('USP_MBS0200_R01', {'p_WORK_TYPE':'q','@p_IR_DATE':'${controller.dayValue.value}','@p_URGENCY_FG':'N', '@p_INS_DEPT' : '1110', '@p_RESULT_FG' : controller.pResultFg.value}).then((value) =>
              {
                Get.log('aaaa ${value['DATAS']}'),
                controller.datasLength.value = value['DATAS'].length,
                for(var i = 0; i < controller.datasLength.value; i++){
                  controller.datasList.add(value['DATAS'][i]),
                  Get.log('vdfvfvfvv ${controller.datasList.length}')
                },
                Get.log('aaaa ${controller.datasList}'),
                Get.log('aaaa ${controller.datasLength.value}'),
              }

          );
        } : null,
        child: Container(
          padding: EdgeInsets.only(top: 14, bottom: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text('조회', style: AppTheme.bodyBody1.copyWith(color: AppTheme.black),),
          ),
        )
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


  //  var regDttmFirstIndex =
  //  controller.noticeList[index].regDttm.toString().lastIndexOf(' ');

    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)))),
            padding: MaterialStateProperty.all(const EdgeInsets.all(0),),
          ),
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
            }
          },

          child: Container(
              padding: EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
              decoration: BoxDecoration(
                color: controller.test[index] ? AppTheme.blue_blue_50 : null
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.datasList.isNotEmpty ? Column(
                        children: [
                          Text(controller.datasList[index]['IR_USER'].toString(),
                              style: AppTheme.titleSubhead3
                                  .copyWith(color: AppTheme.light_text_primary)),
                          const SizedBox(
                            height: AppTheme.spacing_xs_8,
                          )
                        ],
                      ) : Container(),
                      controller.datasList.isNotEmpty ? Text(
                          controller.datasList[index]['IR_TITLE']
                              .toString(),
                          style: AppTheme.bodyBody1
                              .copyWith(color: AppTheme.light_text_tertiary)) : Container(),
                    ],
                  ),
                  controller.datasList.isNotEmpty ? Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Container(
                              child: (() {
                                var firstIndex = controller.datasList[index]['IR_DATE']
                                    .toString().indexOf('T');
                                var lastIndex = controller.datasList[index]['IR_DATE']
                                    .toString().length;
                                return Text(
                                    controller.datasList[index]['IR_DATE']
                                        .toString().replaceRange(firstIndex, lastIndex, ''),
                                    style: AppTheme.bodyBody1
                                        .copyWith(color: AppTheme.light_text_tertiary));
                              })()
                          ),
                          const SizedBox(
                            height: AppTheme.spacing_xs_8,
                          ),
                          Text(controller.datasList[index]['RESULT_FG'] == 'N' ? '미조치' :
                          controller.datasList[index]['RESULT_FG'] == 'Y' ? '조치완료' :
                          controller.datasList[index]['RESULT_FG'] == 'I' ? '조치 진행중' : '',
                              style: AppTheme.bodyBody1
                                  .copyWith(color: AppTheme.light_success))
                        ],
                      ),
                    ],
                  ) : Container(),
                ],
              )

              /*ExpansionTile(
                onExpansionChanged: (value) {
                  if (value) {
                    if(controller.test[index] == true) {
                      controller.test[index] = false;
                    }else {
                      controller.test[index] = true;
                    }
                  }
                },
                title: controller.datasList.isNotEmpty ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.datasList[index]['IR_USER'].toString(),
                        style: AppTheme.titleSubhead3
                            .copyWith(color: AppTheme.light_text_primary)),
                    const SizedBox(
                      height: AppTheme.spacing_xs_8,
                    )
                  ],
                ) : Container(),
                subtitle: controller.datasList.isNotEmpty ? Text(
                    controller.datasList[index]['IR_TITLE']
                        .toString(),
                    style: AppTheme.bodyBody1
                        .copyWith(color: AppTheme.light_text_tertiary)) : Container(),
                trailing: controller.datasList.isNotEmpty ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: (() {
                            var firstIndex = controller.datasList[index]['IR_DATE']
                                .toString().indexOf('T');
                            var lastIndex = controller.datasList[index]['IR_DATE']
                                .toString().length;
                            return Text(
                                controller.datasList[index]['IR_DATE']
                                    .toString().replaceRange(firstIndex, lastIndex, ''),
                                style: AppTheme.bodyBody1
                                    .copyWith(color: AppTheme.light_text_tertiary));
                          })()
                        ),
                        Text(controller.datasList[index]['RESULT_FG'] == 'N' ? '미조치' :
                        controller.datasList[index]['RESULT_FG'] == 'Y' ? '조치완료' :
                        controller.datasList[index]['RESULT_FG'] == 'I' ? '조치 진행중' : '',
                            style: AppTheme.bodyBody1
                                .copyWith(color: AppTheme.light_success))
                      ],
                    ),
                  ],
                ) : Container(),
                //   initiallyExpanded: true,
                backgroundColor: Colors.white,
                children: <Widget>[
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                    ],

                  ),
                ],
              ),*/
            ),
          ),
        SizedBox(height: 8,),
        Container(height: 1, color: AppTheme.gray_gray_200,),
        SizedBox(height: 8,),
      ],
    ));
  }
  Widget _bottomButton(BuildContext context) {
    return Obx(() => BottomAppBar(
      child: TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0))),
              backgroundColor: controller.registButton.value ?
              MaterialStateProperty.all<Color>(AppTheme.light_primary) :
              MaterialStateProperty.all<Color>(AppTheme.light_cancel),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(0))),
          onPressed: controller.registButton.value ? () {
            Get.log('점검의뢰 등록 클릭!!');
            Get.log('${controller.selectedContainer[0]}');
            Get.to(FacilityStep2Page());
          } : null,
          child: Container(
            height: 56,
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: Text(
                  '점검의뢰 등록',
                  style: AppTheme.bodyBody2.copyWith(
                    color: const Color(0xfffbfbfb),
                  ),
                )),
          )),
    ));
  }
}
