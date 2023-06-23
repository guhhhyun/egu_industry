import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/pages/blueTooth/blue_tooth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  Calendar({Key? key}) : super(key: key);

  BlueToothController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return _calendarArea();
  }

  Widget _calendarArea() {
    var firstDay = DateTime.utc(2022, 1, 1);
    var lastDay = DateTime.utc(2070, 12, 31);

    // DateTime focusedDay = DateTime.now();

    return Obx(
            () => Container(
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
          child: TableCalendar(
            calendarStyle: const CalendarStyle(
                outsideDaysVisible: false,
                defaultTextStyle: TextStyle(fontWeight: FontWeight.w600),
                weekendTextStyle: TextStyle(fontWeight: FontWeight.w600)),
            locale: 'ko-KR',
            headerStyle: HeaderStyle(
                titleCentered: true,
                titleTextStyle: AppTheme.titleSubhead3
                    .copyWith(color: AppTheme.light_text_primary),
                leftChevronIcon: SvgPicture.asset(
                  'assets/app/arrowLeft.svg',
                  width: 24,
                ),
                leftChevronPadding: const EdgeInsets.only(left: 0),
                formatButtonVisible: false,
                rightChevronIcon: SvgPicture.asset(
                  'assets/app/arrowRight.svg',
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
              controller.selectedDay.value = _focusedDay;
            },
          ),
        ),
    );
  }

  void _showDialog(BuildContext context, String title) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: AppTheme.light_ui_02,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              title: Column(
                children: [
                  const SizedBox(
                    height: AppTheme.spacing_l_20,
                  ),
                  Text(
                    title,
                    style: AppTheme.titleHeadline
                        .copyWith(color: AppTheme.black, fontSize: 17),
                  ),
                  const SizedBox(
                    height: AppTheme.spacing_xxxs_2,
                  ),
                ],
              ),
              content: _calendarArea(),
              buttonPadding: const EdgeInsets.all(0),
              // insetPadding 이게 전체크기 조정
              insetPadding: const EdgeInsets.only(left: 45, right: 45),
              contentPadding: const EdgeInsets.all(0),
              actionsPadding: const EdgeInsets.all(0),
              titlePadding: const EdgeInsets.all(0),
              //
              actions: [
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: const Color(0x5c3c3c43),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15)))),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(0))),
                            onPressed: () {
                              Get.log('확인 클릭!');
                              Get.back();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.only(
                                top: AppTheme.spacing_s_12,
                                bottom: AppTheme.spacing_s_12,
                              ),
                              child: Center(
                                child: Text('확인',
                                    style: AppTheme.titleHeadline.copyWith(
                                        color: const Color(0xff007aff),
                                        fontSize: 17)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ]);
        });
  }

}
