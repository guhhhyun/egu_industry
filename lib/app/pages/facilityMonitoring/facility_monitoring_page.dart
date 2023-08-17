
import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/pages/facilityMonitoring/facility_monitoring_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class FacilityMonitoringPage extends StatelessWidget {
  FacilityMonitoringPage({Key? key}) : super(key: key);

  FacilityMonitoringController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CommonAppbarWidget(title: '설비가동 모니터링', isLogo: false, isFirstPage: true,),
            _bodyArea(context),
            _listArea()
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
            _listItem(context: context, index: 1),
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
        SizedBox(height: 8,),
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
                  '검색',
                  style: AppTheme.bodyBody2.copyWith(
                    color: const Color(0xfffbfbfb),
                  ),
                )),
          )),
    );
  }



  Widget _listArea() {

    return Obx(() => SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _listItem(index: index, context: context);
        }, childCount: controller.monitoringList.length)));
  }


  /// obx 추가
  Widget _listItem({required BuildContext context, required int index}) {
    return Container(
      margin: EdgeInsets.only(left: 18, right: 18, bottom: 18),
      padding: EdgeInsets.only(top: 24, bottom: 18, left: 18, right: 18),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppTheme.aE2E2E2),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.03, 0],
            colors: [AppTheme.red_red_800, AppTheme.white], // List of colors
          ),
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
          /*Container(
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
          ),*/
         /* controller.monitoringList.isNotEmpty ?
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(controller.monitoringList[index]['CMH_NM'],
                  style: AppTheme.a16700
                      .copyWith(color: AppTheme.black)),
            ],
          )
              : Container(),
          SizedBox(height: 4,),
          controller.monitoringList.isNotEmpty ?
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(controller.monitoringList[index]['ALARM_CODE'],
                  style: AppTheme.a15700
                      .copyWith(color: AppTheme.black)),
            ],
          )
              : Container(),
          SizedBox(height: 4,),
          controller.monitoringList.isNotEmpty ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('${controller.monitoringList[index]['LEAD_TIME'].toString()}',
                      style: AppTheme.a14400
                          .copyWith(color: AppTheme.a959595)),
                ],
              ),
              Container(
                  child: (() {
                    return Text(
                        controller.monitoringList[index]['IST_DT']
                            .toString(),
                        style: AppTheme.a14400
                            .copyWith(color: AppTheme.a959595));
                  })()
              ),
            ],
          ) : Container(),*/
          Row(
            children: [
              Text('data')
            ],
          ),
          Row(
            children: [
              Text('data')
            ],
          ),
          Row(
            children: [
              Text('data')
            ],
          )
        ],
      ),


    ); // 290 6
  }



/*Widget _bottomButton(BuildContext context) {
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
  }*/
}