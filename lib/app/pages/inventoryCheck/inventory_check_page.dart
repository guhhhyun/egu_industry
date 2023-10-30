
import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/common/common_loading.dart';
import 'package:egu_industry/app/pages/inventoryCheck/inventory_check_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';


class InventoryCheckPage extends StatelessWidget {
  InventoryCheckPage({Key? key}) : super(key: key);

  InventoryCheckController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                CommonAppbarWidget(title: '제품재고 조회', isLogo: false, isFirstPage: true,),
                _bodyArea(context),
                Obx(() => _list(context)),
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

  Widget _list(BuildContext context) {
    final double height = 49*(double.parse((controller.productSearchList.length + 1).toString()));
    return SliverToBoxAdapter(
      child: Column(children: [
        Container(
          width: MediaQuery.of(context).size.width-32,
          height: height,
          child: PlutoGrid(
            columns: gridCols,
            rows: controller.rowDatas,
            onLoaded: (PlutoGridOnLoadedEvent event) {
              controller.gridStateMgr = event.stateManager;
              controller.gridStateMgr.setSelectingMode(PlutoGridSelectingMode.cell);
              //gridStateMgr.setShowColumnFilter(true);
            },
            onChanged: (PlutoGridOnChangedEvent event) {
              print(event);
            },
            configuration: PlutoGridConfiguration(
              style: PlutoGridStyleConfig(
                //gridBorderColor: Colors.transparent,
                  activatedColor: Colors.transparent,
                  cellColorInReadOnlyState: Colors.white,
                  columnTextStyle: AppTheme.a14500.copyWith(color: AppTheme.black)
              ),
            ),
          ),
        ),
      ],),
    );
  }

  final List<PlutoColumn> gridCols = <PlutoColumn>[
    PlutoColumn(
      title: 'NO',
      field: 'ROW_NO',
      type: PlutoColumnType.text(),
      width: 50,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '중량',
      field: 'STOCK_QTY',
      type: PlutoColumnType.text(),
      width: 90,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '품명',
      field: 'CMP_NM',
      type: PlutoColumnType.text(),
      width: 100,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '강종',
      field: 'STT_NM',
      type: PlutoColumnType.text(),
      width: 90,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '두께',
      field: 'THIC',
      type: PlutoColumnType.text(),
      width: 90,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '실두께',
      field: 'THICK_ACT',
      type: PlutoColumnType.text(),
      width: 90,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '폭',
      field: 'WIDTH',
      type: PlutoColumnType.text(),
      width: 90,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '거래처명',
      field: 'CST_NM',
      type: PlutoColumnType.text(),
      width: 120,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '경도',
      field: 'HARDNESS_ACT',
      type: PlutoColumnType.text(),
      width: 90,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: 'QC메모',
      field: 'PP_REMARK',
      type: PlutoColumnType.text(),
      width: 150,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
    PlutoColumn(
      title: '입고일',
      field: 'IN_DATE',
      type: PlutoColumnType.text(),
      width: 120,
      enableSorting: false,
      enableEditingMode: false,
      enableContextMenu: false,
      enableRowDrag: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      backgroundColor: AppTheme.blue_blue_300,
    ),
  ];

  Widget _bodyArea(BuildContext context) {
    return SliverToBoxAdapter(
        child: Obx(() => Container(
          color: AppTheme.white,
          padding: const EdgeInsets.only(left: 18, right: 18, top: 4),
          child: Column(
            children: [
              _cstField(),
              _cmpAndSttItem(),
              const SizedBox(height: 12,),
              Row(
                children: [
                  _thicField(),
                  SizedBox(width: 16,),
                  _checkButton()
                ],
              ),
              // _fromMachItem(),

              const SizedBox(height: 24,),
            ],
          ),
        ),)
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
        }, childCount: controller.productSearchList.length)));
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
          controller.productSearchList.isNotEmpty ?
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(controller.productSearchList[index]['CST_NM'],
                  style: AppTheme.a16700
                      .copyWith(color: AppTheme.black)),
            ],
          )
              : Container(),
          SizedBox(height: 4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(controller.productSearchList[index]['CMP_NM'].toString(),
                  style: AppTheme.a14500
                      .copyWith(color: AppTheme.a6c6c6c)),
            ],
          ),
          SizedBox(height: 12,),

          controller.productSearchList.isNotEmpty ?
           Wrap(
                alignment: WrapAlignment.start,
                children: [
                  Text(controller.productSearchList[index]['STT_NM'].toString(),
                      style: AppTheme.a14400
                          .copyWith(color: AppTheme.a6c6c6c)),
                  const SizedBox(width: 4,),
                  Text('|', style: AppTheme.a16400
                      .copyWith(color: AppTheme.light_ui_05)),
                  const SizedBox(width: 4,),
                  Text('${controller.productSearchList[index]['THIC'].toString()} (두께)',
                      style: AppTheme.a14400
                          .copyWith(color: AppTheme.a6c6c6c)),
                  const SizedBox(width: 4,),
                  Text('|', style: AppTheme.a14400
                      .copyWith(color: AppTheme.light_ui_05)),
                  const SizedBox(width: 4,),
                  Text('${controller.productSearchList[index]['THIC_ACT'].toString()} (실두께)',
                      style: AppTheme.a14400
                          .copyWith(color: AppTheme.a6c6c6c)),
                  const SizedBox(width: 4,),
                  Text('|', style: AppTheme.a14400
                      .copyWith(color: AppTheme.light_ui_05)),
                  const SizedBox(width: 4,),
                  Text('${controller.productSearchList[index]['WIDTH'].toString()} (폭)',
                      style: AppTheme.a14400
                          .copyWith(color: AppTheme.a6c6c6c)),
                  const SizedBox(width: 4,),
                  Text('|', style: AppTheme.a14400
                      .copyWith(color: AppTheme.light_ui_05)),
                  const SizedBox(width: 4,),
                  Text('${controller.productSearchList[index]['HARDNESS_ACT'].toString()} (경도)',
                      style: AppTheme.a14400
                          .copyWith(color: AppTheme.a6c6c6c)),
                  const SizedBox(width: 4,),
                  Text('|', style: AppTheme.a14400
                      .copyWith(color: AppTheme.light_ui_05)),
                  const SizedBox(width: 4,),
                  Text('${controller.productSearchList[index]['STOCK_QTY'].toString()} (중량)',
                      style: AppTheme.a14400
                          .copyWith(color: AppTheme.a6c6c6c)),

            ],
          ) : Container(),
          SizedBox(height: 12,),
          controller.productSearchList.isNotEmpty ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('QC메모: ${controller.productSearchList[index]['PP_REMARK'].toString()}',
                      style: AppTheme.a14400
                          .copyWith(color: AppTheme.a959595)),
                ],
              ),
              Container(
                  child: (() {
                    return Text(
                        controller.productSearchList[index]['IN_DATE']
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

  Widget _topTitle(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(left: 4, right: 4),
        padding: EdgeInsets.only(left: 18, right: 18),
        child: Row(
          children: [
            MediaQuery.of(context).size.width <= 450 ? Container() :
          Container(
                decoration: const BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(
                        left:
                        BorderSide(color: AppTheme.ae2e2e2),
                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 40,
                width: 60,
                child: Center(
                  child: Text('번호',
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.light_text_primary),
                      textAlign: TextAlign.left),
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
                height: 40,
                child: Center(
                  child: Text(
                    '중량',
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
                        left: MediaQuery.of(context).size.width <= 450 ? BorderSide(color: AppTheme.ae2e2e2) : BorderSide(color: Colors.transparent),
                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 40,
                child: Center(
                  child: Text('품명',
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
                height: 40,
                child: Center(
                  child: Text('강종',
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
                height: 40,
                child: Center(
                  child: Text('두께',
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

                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 40,
                child: Center(
                  child: Text('실두께',
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
                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 40,
                child: Center(
                  child: Text('폭',
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
                height: 40,
                child: Center(
                  child: Text('거래처명',
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

                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 40,
                child: Center(
                  child: Text('경도',
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

                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 40,
                child: Center(
                  child: Text('QC메모',
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
                height: 40,
                child: Center(
                  child: Text('입고일',
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

  Widget _listArea2() {
    return Obx(() => SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _listItem2(index: index, context: context);
        }, childCount: controller.productSearchList.length)));
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
              MediaQuery.of(context).size.width <= 450 ? Container() :
              Container(
                  decoration: const BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          left:
                          BorderSide(color: AppTheme.ae2e2e2),
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2))),
                  height: 60,
                  width: 60,
                  child: Center(
                    child: Text('${index + 1}',
                      style: AppTheme.a14500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
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
                              color: AppTheme.ae2e2e2))),
                  height: 60,
                  child: Center(
                      child: Text(
                        controller.productSearchList[index]['STOCK_QTY'].toString(),
                        style: AppTheme.a14500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,)
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          left: MediaQuery.of(context).size.width <= 450 ? BorderSide(color: AppTheme.ae2e2e2) : BorderSide(color: Colors.transparent),
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2))),
                  height: 60,
                  child: Center(
                    child: Text(controller.productSearchList[index]['CMP_NM'].toString(),
                      style: AppTheme.a14500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2))),
                  height: 60,
                  child: Center(
                    child: Text(controller.productSearchList[index]['STT_NM'].toString(),
                      style: AppTheme.a14500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppTheme.white,
                      border: Border(

                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2))),
                  height: 60,
                  child: Center(
                    child: Text(controller.productSearchList[index]['THIC'].toString(),
                      style: AppTheme.a14500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),
              MediaQuery.of(context).size.width <= 450 ? Container() :
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppTheme.white,
                      border: Border(

                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2))),
                  height: 60,
                  child: Center(
                    child: Text(controller.productSearchList[index]['THICK_ACT'].toString(),
                      style: AppTheme.a14500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),
              MediaQuery.of(context).size.width <= 450 ? Container() :
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2))),
                  height: 60,
                  child: Center(
                    child: Text(controller.productSearchList[index]['WIDTH'].toString(),
                      style: AppTheme.a14500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2))),
                  height: 60,
                  child: Center(
                    child: Text(controller.productSearchList[index]['CST_NM'].toString(),
                      style: AppTheme.a14500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),
              MediaQuery.of(context).size.width <= 450 ? Container() :
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2))),
                  height: 60,
                  child: Center(
                    child: Text(controller.productSearchList[index]['HANDNESS_ACT'].toString(),
                      style: AppTheme.a14500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),
              MediaQuery.of(context).size.width <= 450 ? Container() :
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2))),
                  height: 60,
                  child: Center(
                    child: Text(controller.productSearchList[index]['PP_REMARK'].toString(),
                      style: AppTheme.a14500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2))),
                  height: 60,
                  child: Center(
                    child: Text(controller.productSearchList[index]['IN_DATE'].toString(),
                      style: AppTheme.a14500
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