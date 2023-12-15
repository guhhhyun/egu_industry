import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/common/dialog_widget.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:egu_industry/app/pages/inventoryCounting/inventory_counting_controller.dart';
import 'package:egu_industry/app/pages/productLocation/product_location_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


class InventoryCountingPage extends StatelessWidget {
  InventoryCountingPage({super.key});

  InventoryCountingController controller = Get.find();
  final focusNode2 = FocusNode();
  final focusNode = FocusNode(onKey: (node, event) {
    if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
      return KeyEventResult.handled; // prevent passing the event into the TextField
    }
    return KeyEventResult.ignored; // pass the event to the TextField
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CommonAppbarWidget(title: '재고실사', isLogo: false, isFirstPage: true ),
            _topArea(context),
            _listArea()

          ],
        ),
      ),
     // bottomNavigationBar: _bottomButton(context), //  등록
    );
  }

  Widget _topArea(BuildContext context) {
    return SliverToBoxAdapter(
      child: Obx(() => Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 4),
          child: Column(
            children: [
            //  _scrapDropdown(),
              Column(
                children: [
                  const SizedBox(height: 20,),
                  _calendarItem(),
                  controller.isShowCalendar.value == true ? _calendar() : Container(),
                  const SizedBox(height: 20,),
                  _checkButton(),
                  const SizedBox(height: 20,),
                  _barcodeField(context)
                ],
              ),

              SizedBox(height: 20,),


            ],
          )
      ), )
    );
  }

  Widget _calendarItem() {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _scrapDropdown(true),
            SizedBox(width: 16,),
            _mach()
          ],
        ),
        SizedBox(height: 10,),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                AppTheme.light_ui_background
            ),
            padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    side: const BorderSide(color: AppTheme.ae2e2e2),
                    borderRadius: BorderRadius.circular(10)
                )),
          ),
          onPressed: () {
            Get.log('날짜 클릭');
            controller.isShowCalendar.value = true;

          },
          child: Container(
            height: 50,
            padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined, color: AppTheme.a959595, size: 20,),
                SizedBox(width: 8,),
                Text(controller.dayValue.value, style: AppTheme.a14500.copyWith(color: AppTheme.a6c6c6c),)
              ],
            ),
          ),
        ),
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
                controller.selectedDay.value = _focusedDay;
                controller.dayValue.value = controller.dayValue.value = DateFormat('yyyy-MM-dd').format(controller.selectedDay.value);
                controller.bSelectedDayFlag.value = true;
                controller.isShowCalendar.value = false;
              },
            ),
            SizedBox(height: 12,),
            SizedBox(height: 12,),

          ],
        ),
      ),
    );
  }

  Widget _mach() {
    return Expanded(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: AppTheme.ae2e2e2
            )),
        padding: const EdgeInsets.only(left: 12, right: 12),
        child:  controller.selectedCheckLocationMap['DETAIL_NM'] == '재공' ? DropdownButton(
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
            value: controller.selectedMachMap['MACH_NAME'],
            //  flag == 3 ? controller.selectedNoReason.value :
            items: controller.machList.map((value) {
              return DropdownMenuItem<String>(
                value: value['MACH_NAME'],
                child: Text(
                  value['MACH_NAME'],
                  style: AppTheme.a16500
                      .copyWith(color: value['MACH_NAME'] == '설비 선택' ? AppTheme.light_placeholder : AppTheme.a6c6c6c),
                ),
              );
            }).toList(),
            onChanged: (value) {
              controller.machList.map((e) {
                if(e['MACH_NAME'] == value) {
                  controller.selectedMachMap['MACH_CODE'] = e['MACH_CODE'].toString();
                  controller.selectedMachMap['MACH_NAME'] = e['MACH_NAME'];
                }
                //  Get.log('${ controller.selectedLocationMap} 선택!!!!');
              }).toList();

              Get.log('$value 선택!!!!');
              // Get.log('${HomeApi.to.BIZ_DATA('L_USER_001')}');
            }) : Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
          ),
        )
      ),
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
            var a = await HomeApi.to.PROC('USP_MBS0500_R01', {'@p_WORK_TYPE':'Q', '@p_DATE': controller.dayValue.value
              ,'@p_GUBUN':'${controller.selectedCheckLocationMap['DETAIL_CD']}' }).then((value) =>
            {
              if(value['DATAS'] != null) {
                controller.productList.value = value['DATAS'],
                for(var i = 0; i < controller.productList.length; i++) {
                  if(controller.productList[i]['CST_NM'] == null) {
                    controller.productList.remove(controller.productList[i])
                  }
                },
                controller.productList.value = controller.productList.reversed.toList()
              }
            }); /// 구분도 여쭤봐야함
            Get.log('조회 결과~~~~~ $a');
          },
          child: SizedBox(
            height: 56,
            child: Center(
                child: Text(
                  '조회',
                  style: AppTheme.bodyBody2.copyWith(
                    color: const Color(0xfffbfbfb),
                  ),
                )),
          )),
    );
  }

  Widget _topAreaTest(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only( right: 8),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.ae2e2e2),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: /*RawKeyboardListener(
                    focusNode: focusNode,
                    onKey: (event) async{
                      FocusScope.of(context).autofocus(focusNode);
                     *//* var an = event.data.toString();
                      String eventText2 = an;
                      String eventText = event.character ?? '';*//*
                     *//* if (eventText2.isNotEmpty  || eventText2 == '-') {
                        controller.textController.text += eventText2.trim();
                        *//*if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                          controller.saveButton();
                          controller.textController.text = '';
                          FocusScope.of(context).autofocus(focusNode);
                        }
                     // }
                      var a = await HomeApi.to.PROC('USP_MBS0500_R01', {'@p_WORK_TYPE':'Q'
                        , '@p_DATE': controller.dayValue.value != '날짜를 선택해주세요' ? controller.dayValue.value
                            : DateFormat('yyyy-MM-dd').format(DateTime.now())
                        , '@p_GUBUN': '${controller.selectedCheckLocationMap['DETAIL_CD']}'}).then((value) =>
                      {
                        if(value['DATAS'] != null) {
                          controller.productList.value = value['DATAS'],
                          for(var i = 0; i < controller.productList.length; i++) {
                            if(controller.productList[i]['CST_NM'].toString() == null) {
                              controller.productList.remove(controller.productList[i])
                            }
                          },
                          controller.productList.value = controller.productList.reversed.toList()
                        }
                      });
                    },
                    child: */TextFormField(
                      focusNode: focusNode2,
                    style:  AppTheme.a16400.copyWith(color: AppTheme.a6c6c6c),
                    controller: controller.textController,
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.go,
                    onTap: () {
                      if(controller.focusCnt.value++ > 1) controller.focusCnt.value = 0;
                      else Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
                    },
                    onTapOutside:(event) => { controller.focusCnt.value = 0 },
                    onFieldSubmitted: (value) async{
                      controller.saveButton();
                      controller.textController.text = '';
                      var a = await HomeApi.to.PROC('USP_MBS0500_R01', {'@p_WORK_TYPE':'Q'
                        , '@p_DATE': DateFormat('yyyy-MM-dd').format(DateTime.now())
                        , '@p_GUBUN': '${controller.selectedCheckLocationMap['DETAIL_CD']}'}).then((value) =>
                      {
                        if(value['DATAS'] != null) {
                          controller.productList.value = value['DATAS'],
                          for(var i = 0; i < controller.productList.length; i++) {
                            if(controller.productList[i]['CST_NM'].toString() == null) {
                              controller.productList.remove(controller.productList[i])
                            }
                          },
                          controller.productList.value = controller.productList.reversed.toList()
                        }
                      });
                      Future.delayed(const Duration(), (){
                        focusNode2.requestFocus();
                        //  FocusScope.of(context).requestFocus(focusNode);
                        Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
                      });
                    /*  SchedulerBinding.instance!.addPostFrameCallback((_) {
                        Get.dialog(CommonDialogWidget(contentText: '저장되었습니다', flag: 1, pageFlag: 4,));
                      });*/
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: () async {
                            controller.saveButton();
                            controller.textController.text = '';
                            FocusScope.of(context).autofocus(focusNode);
                            var a = await HomeApi.to.PROC('USP_MBS0500_R01', {'@p_WORK_TYPE':'Q'
                              , '@p_DATE': DateFormat('yyyy-MM-dd').format(DateTime.now())
                              , '@p_GUBUN': '${controller.selectedCheckLocationMap['DETAIL_CD']}'}).then((value) =>
                            {
                              if(value['DATAS'] != null) {
                                controller.productList.value = value['DATAS'],
                                for(var i = 0; i < controller.productList.length; i++) {
                                  if(controller.productList[i]['CST_NM'].toString() == null) {
                                    controller.productList.remove(controller.productList[i])
                                  }
                                },
                                controller.productList.value = controller.productList.reversed.toList()
                              }
                            });
                            Future.delayed(const Duration(), (){
                              focusNode2.requestFocus();
                              //  FocusScope.of(context).requestFocus(focusNode);
                              Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
                            });
                           /* SchedulerBinding.instance!.addPostFrameCallback((_) {
                              Get.dialog(CommonDialogWidget(contentText: '저장되었습니다', flag: 1, pageFlag: 4,));
                            });*/
                          },
                          child: Image.asset('assets/app/search.png', color: AppTheme.a6c6c6c, width: 32, height: 32,)
                      ),

                      contentPadding: const EdgeInsets.all(0),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'BC 번호를 입력해주세요',
                      hintStyle: AppTheme.a16400.copyWith(color: AppTheme.aBCBCBC),
                      border: InputBorder.none,
                    ),
                    showCursor: true,


                  ),
                ),
              ),
            ),
          ),
         /* InkWell(
              onTap: () async {
                String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                    '#ff6666', '취소', false, ScanMode.BARCODE);
                controller.textController.text = barcodeScanRes;
                if(controller.textController.text != '') {
                  if(controller.textController.text != '-1') {
                    controller.textController.text = barcodeScanRes;
                    controller.saveButton();
                    var a = await HomeApi.to.PROC('USP_MBS0500_R01', {'@p_WORK_TYPE':'Q'
                      , '@p_DATE': controller.dayValue.value != '날짜를 선택해주세요' ? controller.dayValue.value
                          : DateFormat('yyyy-MM-dd').format(DateTime.now())
                      , '@p_GUBUN': '${controller.selectedCheckLocationMap['DETAIL_CD']}'}).then((value) =>
                    {
                      if(value['DATAS'] != null) {
                        controller.productList.value = value['DATAS'],
                        for(var i = 0; i < controller.productList.length; i++) {
                          if(controller.productList[i]['CST_NM'].toString() == null) {
                            controller.productList.remove(controller.productList[i])
                          }
                        },
                        controller.productList.value = controller.productList.reversed.toList()
                      }
                    });
                  }
                  Future.delayed(const Duration(), (){
                    focusNode2.requestFocus();
                    //  FocusScope.of(context).requestFocus(focusNode);
                    Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
                  });

                }else {
                 controller.textController.text = '바코드를 재스캔해주세요';
                }
              },
              child: Icon(Icons.camera_alt_outlined, size: 30, color: AppTheme.black)
          )*/
        ],
      ),
    );
  }


  Widget _barcodeField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Center(
            child: _topAreaTest(context)
          ),
        ),
        SizedBox(height: 10,),
      ],
    );
  }

  /*Widget _barcodeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('재고실사 등록',
            style: AppTheme.a15700
                .copyWith(color: AppTheme.black)),
        const SizedBox(height: 10,),
        _scrapDropdown(false),
        const SizedBox(height: 10,),
        controller.selectedSaveLocationMap['DETAIL_NM'] != '선택해주세요' ?
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
                textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.search,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                      onTap:  () async {
                        Get.log('조회 돋보기 클릭!');
                        if(controller.textController.text != '') {
                          controller.saveButton();
                          var a = await HomeApi.to.PROC('USP_MBS0500_R01', {'@p_WORK_TYPE':'Q'
                            , '@p_DATE': controller.dayValue.value != '날짜를 선택해주세요' ? controller.dayValue.value
                                : DateFormat('yyyy-MM-dd').format(DateTime.now())
                            , '@p_GUBUN': '${controller.selectedSaveLocationMap['DETAIL_CD']}'}).then((value) =>
                          {
                            if(value['DATAS'] != null) {
                              controller.productList.value = value['DATAS'],
                              for(var i = 0; i < controller.productList.length; i++) {
                                if(controller.productList[i]['CST_NM'].toString() == null) {
                                  controller.productList.remove(controller.productList[i])
                                }
                              }
                            }
                          });
                          SchedulerBinding.instance!.addPostFrameCallback((_) {
                            Get.dialog(CommonDialogWidget(contentText: '저장되었습니다', flag: 1, pageFlag: 4,));
                          });
                        }
                      },
                      child: Image.asset('assets/app/search.png', color: AppTheme.a6c6c6c, width: 32, height: 32,)
                  ),

                  contentPadding: const EdgeInsets.all(0),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'BC 번호를 입력해주세요',
                  hintStyle: AppTheme.a16400.copyWith(color: AppTheme.aBCBCBC),
                  border: InputBorder.none,
                ),
                showCursor: true,

                // onChanged: ((value) => controller.submitSearch(value)),
              ),
            ),
          ),
        ) : Container(),
        SizedBox(height: 10,),
      ],
    );
  }*/


  Widget _scrapDropdown(bool isCheck) {
    return Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.ae2e2e2),
                    borderRadius: BorderRadius.circular(10),
                    color: AppTheme.white
                ),
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: DropdownButton(
                    borderRadius: BorderRadius.circular(3),
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
                    value: isCheck ? controller.selectedCheckLocationMap['DETAIL_NM'] : controller.selectedSaveLocationMap['DETAIL_NM'],
                    //  flag == 3 ? controller.selectedNoReason.value :
                    items: controller.locationList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value['DETAIL_NM'],
                        child: Text(
                          value['DETAIL_NM'],
                          style: AppTheme.a16400
                              .copyWith(color: AppTheme.a6c6c6c),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.locationList.map((e) {
                        if(e['DETAIL_NM'] == value) {
                          if(isCheck) {
                            controller.selectedCheckLocationMap['DETAIL_CD'] = e['DETAIL_CD'];
                            controller.selectedCheckLocationMap['DETAIL_NM'] = e['DETAIL_NM'];
                          }else {
                            controller.selectedSaveLocationMap['DETAIL_CD'] = e['DETAIL_CD'];
                            controller.selectedSaveLocationMap['DETAIL_NM'] = e['DETAIL_NM'];
                          }
                        }

                        //  Get.log('${ controller.selectedLocationMap} 선택!!!!');
                      }).toList();
                      isCheck ? Get.log('${ controller.selectedCheckLocationMap} 선택!!!!') : Get.log('${ controller.selectedSaveLocationMap} 선택!!!!');
                    }),
              ),
            );
  }

  Widget _listArea() {
    return Obx(() => SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _listItem(index: index, context: context);
        }, childCount: controller.productList.length)));
  }


  Widget _listItem({required BuildContext context, required int index}) {

    return Obx(() => Container(
      margin: const EdgeInsets.only(left: 18, right: 18, bottom: 18),
      padding: const EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppTheme.aE2E2E2),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              controller.productList.isNotEmpty ?
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppTheme.ae2e2e2
                    ),
                    child: Text(controller.productList[index]['BARCODE_NO'].toString(),
                        style: AppTheme.a12500
                            .copyWith(color: AppTheme.a969696)),
                  ),
                ],
              )
                  : Container(),
            ],
          ),
          SizedBox(height: 8,),
          /// 마노압연기 뭐시기뭐시기
          controller.productList.isNotEmpty ?
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(controller.productList[index]['CST_NM'] == null ? '' : controller.productList[index]['CST_NM'],
                  style: AppTheme.a16700
                      .copyWith(color: AppTheme.black)),
              SizedBox(width: 4,),
              Text('|', style: AppTheme.a16400
                  .copyWith(color: AppTheme.a6c6c6c)),
              SizedBox(width: 4,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(controller.productList[index]['CMP_NM'] == null ? '' : controller.productList[index]['CMP_NM'].toString(),
                      style: AppTheme.a16400
                          .copyWith(color: AppTheme.black)),
                ],
              ),
            ],
          )
              : Container(),
          /// 설비 | 설비이상 - 가동조치중 | 전기팀 대충 그런거
          controller.productList.isNotEmpty ?
          Wrap(
            children: [

              Text(controller.productList[index]['RP'].toString(),
                  style: AppTheme.a14400
                      .copyWith(color: AppTheme.a6c6c6c)),
              const SizedBox(width: 4,),
              Text('|', style: AppTheme.a14400
                  .copyWith(color: AppTheme.a6c6c6c)),
              const SizedBox(width: 4,),
              Text(controller.productList[index]['STT_NM'].toString(),
                  style: AppTheme.a14400
                      .copyWith(color: AppTheme.a6c6c6c)),
              const SizedBox(width: 4,),
              Text('|', style: AppTheme.a16400
                  .copyWith(color: AppTheme.a6c6c6c)),
              const SizedBox(width: 4,),
              Text('${controller.productList[index]['THIC'].toString()} (THIC)',
                  style: AppTheme.a14400
                      .copyWith(color: AppTheme.a6c6c6c)),
              const SizedBox(width: 4,),
              Text('|', style: AppTheme.a14400
                  .copyWith(color: AppTheme.a6c6c6c)),
              const SizedBox(width: 4,),
              Text('${controller.productList[index]['WIDTH'].toString()} (WIDTH)',
                  style: AppTheme.a14400
                      .copyWith(color: AppTheme.a6c6c6c)),
              const SizedBox(width: 4,),
              Text('|', style: AppTheme.a14400
                  .copyWith(color: AppTheme.a6c6c6c)),
              const SizedBox(width: 4,),
              Text('${controller.productList[index]['WEIGHT'].toString()} (WEIGHT)',
                  style: AppTheme.a14400
                      .copyWith(color: AppTheme.a6c6c6c)),
            ],
          ) : Container(),
          const SizedBox(height: 12,),
          controller.productList.isNotEmpty ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(controller.productList[index]['PASS'] == true ? '합격': '불합',
                  style: AppTheme.a14400
                      .copyWith(color: AppTheme.a959595)),
            ],
          ) : Container(),
        ],
      ),
    ),

    );
  }
}
