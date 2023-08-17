
import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';

import 'package:egu_industry/app/pages/processTransfer/process_transfer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';


class ProcessTransferPage extends StatelessWidget {
  ProcessTransferPage({Key? key}) : super(key: key);

  ProcessTransferController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CommonAppbarWidget(title: '공정이동', isLogo: false, isFirstPage: true,),
            _bodyArea(context),
            _listArea()
         //   _listArea()
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
          padding: const EdgeInsets.only(left: 18, right: 18, top: 24),
          child: Column(
            children: [
              _calendarItem(context),
              const SizedBox(height: 12,),
              _movAndFkFItem(),
              const SizedBox(height: 12,),
              _fromMachItem(),
              const SizedBox(height: 12,),
              _checkButton(),
             // _fromMachItem(),
              const SizedBox(height: 24,),
              const SizedBox(height: 12,),
            ],
          ),
        ),)
    );
  }

  Widget _calendarItem(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                      borderRadius: BorderRadius.circular(10),
                        border: Border.all( color: AppTheme.ae2e2e2)),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(controller.dayStartValue.value, style: AppTheme.a12500
                            .copyWith(color: controller.dayStartValue.value == '시작날짜' ? AppTheme.light_placeholder : AppTheme.a6c6c6c
                            , fontSize: 17),),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12,),
            SizedBox(height: 50, child: Center(
              child: Text('~',style: AppTheme.a14500
                  .copyWith(color: AppTheme.black)),
            ),),
            const SizedBox(width: 12,),
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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppTheme.ae2e2e2)),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only( right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(controller.dayEndValue.value, style: AppTheme.a14500
                            .copyWith(color: controller.dayEndValue.value == '마지막날짜' ? AppTheme.light_placeholder : AppTheme.a6c6c6c
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

  Widget _movAndFkFItem() {
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
                value: controller.selectedMovYn.value,
                //  flag == 3 ? controller.selectedNoReason.value :
                items: controller.movYnList.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: AppTheme.a16500
                          .copyWith(color: value == '선택해주세요' ? AppTheme.light_placeholder : AppTheme.a6c6c6c),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedMovYn.value = value!;
                  value == '처리' ? controller.selectedMovYnCd.value = 'Y' : controller.selectedMovYnCd.value = 'N';
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
                value: controller.selectedFkfNm['FKF_NM'],
                //  flag == 3 ? controller.selectedNoReason.value :
                items: controller.fkfList.map((value) {
                  return DropdownMenuItem<String>(
                    value: value['FKF_NM'],
                    child: Text(
                      value['FKF_NM'],
                      style: AppTheme.a16500
                          .copyWith(color: value['FKF_NM'] == '선택해주세요' ? AppTheme.light_placeholder : AppTheme.a6c6c6c),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.fkfList.map((e) {
                    if(e['FKF_NM'] == value) {
                       controller.selectedFkfNm['FKF_NO'] = e['FKF_NO'];
                       controller.selectedFkfNm['FKF_NM'] = e['FKF_NM'];
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

 /// 작업위치
  Widget _fromMachItem() {
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
                    value: controller.selectedMachMap['MACH_NAME'],
                    //  flag == 3 ? controller.selectedNoReason.value :
                    items: controller.machList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value['MACH_NAME'],
                        child: Text(
                          value['MACH_NAME'],
                          style: AppTheme.a16500
                              .copyWith(color: value['MACH_NAME'] == '선택해주세요' ? AppTheme.light_placeholder : AppTheme.a6c6c6c),
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
                    }),
              ),
            ),
      ],
    );
  }

  Widget _fkfSaveDrop() {
    return Expanded(
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
                value: controller.selectedSaveFkfNm['FKF_NM'],
                //  flag == 3 ? controller.selectedNoReason.value :
                items: controller.fkfList.map((value) {
                  return DropdownMenuItem<String>(
                    value: value['FKF_NM'],
                    child: Text(
                      value['FKF_NM'],
                      style: AppTheme.a16500
                          .copyWith(color: value['FKF_NM'] == '선택해주세요' ? AppTheme.light_placeholder : AppTheme.a6c6c6c),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.fkfList.map((e) {
                    if(e['FKF_NM'] == value) {
                      controller.selectedSaveFkfNm['FKF_NO'] = e['FKF_NO'];
                      controller.selectedSaveFkfNm['FKF_NM'] = e['FKF_NM'];
                    }
                    //  Get.log('${ controller.selectedLocationMap} 선택!!!!');
                  }).toList();

                  Get.log('$value 선택!!!!');
                  // Get.log('${HomeApi.to.BIZ_DATA('L_USER_001')}');
                }),
          ),
        );
  }


  Widget _listArea() {
    return Obx(() => SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _listItem(index: index, context: context);
        }, childCount: controller.processList.length)));
  }
  Widget _listItem({required BuildContext context,required int index}) {

    return Obx(() => TextButton(
      onPressed: () {
        controller.registButton.value = false;
        controller.isprocessSelectedList[index] == false ? controller.isprocessSelectedList[index] = true
            : controller.isprocessSelectedList[index] = false;
        controller.isprocessSelectedList[index] == true
            ? controller.processSelectedList.add(controller.processList[index])
            : controller.processSelectedList.remove(controller.processList[index]);
        controller.isprocessSelectedList[index] == true ?
        controller.movIds.add(controller.processList[index]['MOV_ID']) : controller.movIds.remove(controller.processList[index]['MOV_ID']);
        for(var i = 0; i < controller.isprocessSelectedList.length; i++) {
          if(controller.isprocessSelectedList[i].toString().contains('true')) {
            controller.registButton.value = true;
          }
        }
        Get.log('movId: ${controller.movIds}');

      },
      child: Container(
        margin: EdgeInsets.only(left: 18, right: 18, bottom: 18),
        padding: EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: controller.isprocessSelectedList.isEmpty ?  Border.all(color: AppTheme.ae2e2e2) : controller.isprocessSelectedList[index] ? Border.all(color: AppTheme.black, width: 3)
                : Border.all(color: AppTheme.ae2e2e2),

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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                controller.processList.isNotEmpty ?
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: controller.processList[index]['URGENCY_FG'] == 'U' ? AppTheme.afef1ef :
                          AppTheme.aecf9f2
                      ),
                      child: Text(controller.processList[index]['URGENCY_FG'] == 'U' ? '긴급' : '보통', /// 긴급 or 보통 으로
                          style: AppTheme.a12500
                              .copyWith(color: controller.processList[index]['URGENCY_FG'] == 'U' ? AppTheme.af34f39 : AppTheme.a18b858)),
                    ),
                    SizedBox(width: 4,),
                    Container(
                      padding: EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:  AppTheme.af4f4f4
                      ),

                      child: Text( controller.processList[index]['MOV_YN'].toString() == 'N' ? '미처리' : '처리완료',
                          style: AppTheme.a12500
                              .copyWith(color: AppTheme.a969696)),
                    ),

                  ],
                )
                    : Container(),
               /* /// 등록한 시간과 현재시간 비교
                Row(
                  children: [
                    Icon(Icons.watch_later_outlined, color: AppTheme.gray_c_gray_200, size: 20,),
                    SizedBox(width: 4,),
                    Text(
                        '${_dateDifference(index)}h 경과',
                        style: AppTheme.a14700
                            .copyWith(color: AppTheme.a969696)),
                  ],
                )*/
              ],
            ),
            SizedBox(height: 8,),
            /// 마노압연기 뭐시기뭐시기
            controller.processList.isNotEmpty ?
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(controller.processList[index]['CMP_NM'] == null ? '' : controller.processList[index]['CMP_NM'].toString(),
                    style: AppTheme.a16700
                        .copyWith(color: AppTheme.black)),
              ],
            )
                : Container(),

            /// 설비 | 설비이상 - 가동조치중 | 전기팀 대충 그런거
            controller.processList.isNotEmpty ?
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Text(controller.processList[index]['FROM_MACH_NM'].toString(), // 작업위치
                    style: AppTheme.a16400
                        .copyWith(color: AppTheme.a6c6c6c)),
                SizedBox(width: 4,),
                Text('|', style: AppTheme.a16400
                    .copyWith(color: AppTheme.a6c6c6c)),
                SizedBox(width: 4,),
                Text(controller.processList[index]['TO_MACH_NM'].toString(), // 이동위치
                    style: AppTheme.a16400
                        .copyWith(color: AppTheme.a6c6c6c)),
              ],
            ) : Container(),
            controller.processList.isNotEmpty ?
            controller.processList[index]['FKF_NM'] != null ?
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(controller.processList[index]['FKF_NM'] == null ? '' : controller.processList[index]['FKF_NM'].toString(), // 지게차호기
                        style: AppTheme.a16400
                            .copyWith(color: AppTheme.a6c6c6c)),
                  ],
                ),
                SizedBox(height: 12,),
              ],
            ) : Container() : Container(),

            controller.processList.isNotEmpty ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: (() {
                      var firstIndex = controller.processList[index]['FROM_DATE']
                          .toString().lastIndexOf(':');
                      var lastIndex = controller.processList[index]['FROM_DATE']
                          .toString().length;
                      return Text(
                          controller.processList[index]['FROM_DATE'].toString(),
                          style: AppTheme.a14400
                              .copyWith(color: AppTheme.a959595));
                    })()
                ),
                Text(controller.processList[index]['TO_DATE'] == null ? '' : '처리일시: ${ controller.processList[index]['TO_DATE'].toString()}',
                    style: AppTheme.a14400
                        .copyWith(color: AppTheme.a959595)),
              ],
            ) : Container(),
          ],
        ),
      ),
    ));
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
                  '조회',
                  style: AppTheme.bodyBody2.copyWith(
                    color: const Color(0xfffbfbfb),
                  ),
                )),
          )),
    );
  }


  Widget _bottomButton(BuildContext context) {
    return Obx(() => BottomAppBar(
      color: AppTheme.white,
      surfaceTintColor: AppTheme.white,
      child: Row(
        children: [
          _fkfSaveDrop(),
          SizedBox(width: 12,),
          Expanded(
            child: TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    backgroundColor: controller.registButton.value ? controller.selectedSaveFkfNm['FKF_NM'] != '선택해주세요' ?
                    MaterialStateProperty.all<Color>(AppTheme.a1f1f1f) :
                    MaterialStateProperty.all<Color>(AppTheme.light_cancel) : MaterialStateProperty.all<Color>(AppTheme.light_cancel),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(0))),
                onPressed: controller.registButton.value ?  controller.selectedSaveFkfNm['FKF_NM'] != '선택해주세요' ? () async{
                  Get.log('저장 클릭!!');
                  for(var i = 0; i < controller.processSelectedList.length; i++) {
                    controller.saveButton(i);
                  }
                } : null : null,
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
}