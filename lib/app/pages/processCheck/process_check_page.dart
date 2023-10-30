
import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/common/common_loading.dart';
import 'package:egu_industry/app/pages/processCheck/process_check_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';


class ProcessCheckPage extends StatelessWidget {
  ProcessCheckPage({Key? key}) : super(key: key);

  ProcessCheckController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
                slivers: [
                  CommonAppbarWidget(title: '작업조회', isLogo: false, isFirstPage: true,),
                  _bodyArea(context),
                  Obx(() => _list(context),),
                  //_topTitle(context),
                  //_listArea2(),
                  SliverToBoxAdapter(child: SizedBox(height: 100,))
                  //   _listArea()
                ],
            ),
            Obx(() => CommonLoading(bLoading: controller.isLoading.value)),
          ],
        ),
      ),
      //    bottomNavigationBar: _bottomButton(context), // 점검의뢰 등록
    );
  }
 /* Widget _list(BuildContext context) {
    return  SliverToBoxAdapter(
      child: Column(
                    children: [
                      _topTitle(context),
                      _listArea3(context),
                    ],
                  ),
    );
  }*/

  Widget _list(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(children: [
        Container(
          width: MediaQuery.of(context).size.width-32,
          height: 49*(double.parse((controller.processList.length).toString())),
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
      title: '구분',
      field: 'CMH_NM',
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
      title: '전일',
      field: 'P_TIME',
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
      title: '금일',
      field: 'SHP_ID',
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
      title: '거래처',
      field: 'CST_NM',
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
      title: '슬라브',
      field: 'SLB_NO',
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
      title: '제품명',
      field: 'CMP_NM',
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
      title: '판롤',
      field: 'SHP_NM',
      type: PlutoColumnType.text(),
      width: 80,
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
      title: '강도',
      field: 'STT_NM',
      type: PlutoColumnType.text(),
      width: 60,
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
      title: '(완)두께',
      field: 'DUKE',
      type: PlutoColumnType.text(),
      width: 80,
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
      title: '공정명',
      field: 'CPR_NM',
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
      title: '(자)두께',
      field: 'THIC',
      type: PlutoColumnType.text(),
      width: 80,
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
      width: 80,
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
      title: '길이',
      field: 'LENGTH',
      type: PlutoColumnType.text(),
      width: 80,
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
      field: 'WHT',
      type: PlutoColumnType.text(),
      width: 80,
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
      title: '작업자',
      field: 'USR',
      type: PlutoColumnType.text(),
      width: 80,
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
      title: '등록시간',
      field: 'DT',
      type: PlutoColumnType.text(),
      width: 110,
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
        child: Container(
          color: AppTheme.white,
          padding: const EdgeInsets.only(left: 18, right: 18, top: 4),
          child: Column(
            children: [
              Row(
                children: [
                  Obx(() => _choiceGb(context)),
                  const SizedBox(width: 12,),
                ],
              ),
              const SizedBox(height: 24,),
            ],
          ),
        ),
    );
  }

  Widget _choiceGb(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                controller.selectedGubunCd.value = '400';
                controller.check400Button();
              },
              child: Container(
                width: 120,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color:  controller.selectedGubunCd.value == '400' ? AppTheme.black : AppTheme.ae2e2e2,
                        width: controller.selectedGubunCd.value == '400' ? 2 : 1
                    )),
                child: Center(
                  child: Text('작업조회(400)', style: AppTheme.a14500.copyWith(color: AppTheme.a6c6c6c)),
                ),
              ),
            ),
            const SizedBox(width: 12,),
            InkWell(
              onTap: () {
                controller.selectedGubunCd.value = '600';
                controller.check600Button();
              },
              child: Container(
                width: 120,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color:  controller.selectedGubunCd.value == '600' ? AppTheme.black : AppTheme.ae2e2e2,
                        width: controller.selectedGubunCd.value == '600' ? 2 : 1
                    )),
                child: Center(
                  child: Text('작업조회(600)', style: AppTheme.a14500.copyWith(color: AppTheme.a6c6c6c)),
                ),
              ),
            ),
            /*const SizedBox(width: 12,),
            InkWell(
              onTap: () {
                controller.selectedGubunCd.value = 'N';
                controller.checkButton();
              },
              child: Container(
                width: 120,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color:  controller.selectedGubunCd.value == 'N' ? AppTheme.black : AppTheme.ae2e2e2,
                        width: controller.selectedGubunCd.value == 'N' ? 2 : 1
                    )),
                child: Center(
                  child: Text('비가동내역', style: AppTheme.a14500.copyWith(color: AppTheme.a6c6c6c)),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }

 /* Widget _cmpAndSttItem() {
    return Row(
      children: [
        Container(
          width: 200,
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
                value: controller.selectedGubun.value,
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
                  controller.selectedGubun.value = value!;
                  Get.log('$value 선택!!!!');
                  controller.convert();
                }),
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
            width: 50,
            height: 50,
            child: Center(
                child: Text(
                  '검색',
                  style: AppTheme.bodyBody2.copyWith(
                    color: const Color(0xfffbfbfb),
                  ),
                )),
          )),
    );
  }*/



  /*Widget _listArea() {

    return Obx(() => SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _listItem(index: index, context: context);
        }, childCount: controller.processList.length)));
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
          controller.processList.isNotEmpty ?
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(controller.processList[index]['CST_NM'],
                  style: AppTheme.a16700
                      .copyWith(color: AppTheme.black)),
            ],
          )
              : Container(),
          SizedBox(height: 4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(controller.processList[index]['CRP_NAME'].toString(),
                  style: AppTheme.a14500
                      .copyWith(color: AppTheme.a6c6c6c)),
            ],
          ),
          SizedBox(height: 12,),

          controller.processList.isNotEmpty ?
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              Text(controller.processList[index]['CMH_NM'].toString(),
                  style: AppTheme.a14400
                      .copyWith(color: AppTheme.a6c6c6c)),
              const SizedBox(width: 4,),
              Text('|', style: AppTheme.a16400
                  .copyWith(color: AppTheme.light_ui_05)),
              const SizedBox(width: 4,),
              Text('${controller.processList[index]['SLB_NO'].toString()}',
                  style: AppTheme.a14400
                      .copyWith(color: AppTheme.a6c6c6c)),
              const SizedBox(width: 4,),
              Text('|', style: AppTheme.a14400
                  .copyWith(color: AppTheme.light_ui_05)),
              const SizedBox(width: 4,),
              Text('${controller.processList[index]['PRE_DT'].toString()}',
                  style: AppTheme.a14400
                      .copyWith(color: AppTheme.a6c6c6c)),
              const SizedBox(width: 4,),
              Text('|', style: AppTheme.a14400
                  .copyWith(color: AppTheme.light_ui_05)),
              const SizedBox(width: 4,),
              Text('${controller.processList[index]['CUR_DT'].toString()}',
                  style: AppTheme.a14400
                      .copyWith(color: AppTheme.a6c6c6c)),
            ],
          ) : Container(),
          SizedBox(height: 12,),
          controller.processList.isNotEmpty ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('${controller.processList[index]['WRK_NM1'].toString()}',
                      style: AppTheme.a14400
                          .copyWith(color: AppTheme.a959595)),
                ],
              ),
              Container(
                  child: (() {
                    return Text(
                        controller.processList[index]['IST_DT']
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

    ); // 290 6
  }*/

  Widget _topTitle(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 4, right: 4),
            padding: EdgeInsets.only(left: 18, right: 18),
            child: Row(
                children: [
                  Expanded(
                    child: Container(
                       width: 60,
                        decoration: const BoxDecoration(
                            color: AppTheme.blue_blue_300,
                            border: Border(
                                left:
                                BorderSide(color: AppTheme.ae2e2e2),
                                top: BorderSide(color: AppTheme.ae2e2e2),
                                right: BorderSide(
                                    color: AppTheme.ae2e2e2))),
                        height: 35,
                        child: Center(
                          child: Text('구분',
                              style: AppTheme.a16700
                                  .copyWith(color: AppTheme.light_text_primary),
                              textAlign: TextAlign.left),
                        )
                    ),
                  ),
                  MediaQuery.of(context).size.width <= 450 ? Container() :
                  Expanded(
                    child: Container(
                      width: 60,
                        decoration: const BoxDecoration(
                            color: AppTheme.blue_blue_300,
                            border: Border(
                                top: BorderSide(color: AppTheme.ae2e2e2),
                                right: BorderSide(
                                    color: AppTheme.ae2e2e2))),
                        height: 35,
                        child: Center(
                          child: Text(
                            '전일',
                            style: AppTheme.a16700
                                .copyWith(color: AppTheme.light_text_primary),
                          ),
                        ),
                    ),
                  ),
                  MediaQuery.of(context).size.width <= 450 ? Container() :
                  Expanded(
                    child: Container(
                      width: 60,
                        decoration: const BoxDecoration(
                            color: AppTheme.blue_blue_300,
                            border: Border(

                                top: BorderSide(color: AppTheme.ae2e2e2),
                                right: BorderSide(
                                    color: AppTheme.ae2e2e2))),
                        height: 35,
                        child: Center(
                          child: Text('금일',
                              style: AppTheme.a16700
                                  .copyWith(color: AppTheme.light_text_primary),
                              textAlign: TextAlign.left),
                        ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      width: 60,
                        decoration: const BoxDecoration(
                            color: AppTheme.blue_blue_300,
                            border: Border(

                                top: BorderSide(color: AppTheme.ae2e2e2),
                                right: BorderSide(
                                    color: AppTheme.ae2e2e2))),
                        height: 35,
                        child: Center(
                          child: Text('거래처',
                              style: AppTheme.a16700
                                  .copyWith(color: AppTheme.light_text_primary),
                              textAlign: TextAlign.left),
                        ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      width: 60,
                      decoration: const BoxDecoration(
                          color: AppTheme.blue_blue_300,
                          border: Border(

                              top: BorderSide(color: AppTheme.ae2e2e2),
                              right: BorderSide(
                                  color: AppTheme.ae2e2e2))),
                      height: 35,
                      child: Center(
                        child: Text('슬라브',
                            style: AppTheme.a16700
                                .copyWith(color: AppTheme.light_text_primary),
                            textAlign: TextAlign.left),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 60,
                      decoration: const BoxDecoration(
                          color: AppTheme.blue_blue_300,
                          border: Border(

                              top: BorderSide(color: AppTheme.ae2e2e2),
                              right: BorderSide(
                                  color: AppTheme.ae2e2e2))),
                      height: 35,
                      child: Center(
                        child: Text('제품명',
                            style: AppTheme.a16700
                                .copyWith(color: AppTheme.light_text_primary),
                            textAlign: TextAlign.left),
                      ),
                    ),
                  ),
                  MediaQuery.of(context).size.width <= 450 ? Container() :
                  Expanded(
                    child: Container(
                      width: 60,
                      decoration: const BoxDecoration(
                          color: AppTheme.blue_blue_300,
                          border: Border(

                              top: BorderSide(color: AppTheme.ae2e2e2),
                              right: BorderSide(
                                  color: AppTheme.ae2e2e2))),
                      height: 35,
                      child: Center(
                        child: Text('판롤',
                            style: AppTheme.a16700
                                .copyWith(color: AppTheme.light_text_primary),
                            textAlign: TextAlign.left),
                      ),
                    ),
                  ),
                  MediaQuery.of(context).size.width <= 450 ? Container() :
                  Expanded(
                    child: Container(
                      width: 60,
                      decoration: const BoxDecoration(
                          color: AppTheme.blue_blue_300,
                          border: Border(

                              top: BorderSide(color: AppTheme.ae2e2e2),
                              right: BorderSide(
                                  color: AppTheme.ae2e2e2))),
                      height: 35,
                      child: Center(
                        child: Text('강도',
                            style: AppTheme.a16700
                                .copyWith(color: AppTheme.light_text_primary),
                            textAlign: TextAlign.left),
                      ),
                    ),
                  ),
                  MediaQuery.of(context).size.width <= 450 ? Container() :
                  Expanded(
                    child: Container(
                      width: 60,
                      decoration: const BoxDecoration(
                          color: AppTheme.blue_blue_300,
                          border: Border(

                              top: BorderSide(color: AppTheme.ae2e2e2),
                              right: BorderSide(
                                  color: AppTheme.ae2e2e2))),
                      height: 35,
                      child: Center(
                        child: Text('(완)두께',
                            style: AppTheme.a16700
                                .copyWith(color: AppTheme.light_text_primary),
                            textAlign: TextAlign.left),
                      ),
                    ),
                  ),
                  MediaQuery.of(context).size.width <= 450 ? Container() :
                  Expanded(
                    child: Container(
                      width: 60,
                      decoration: const BoxDecoration(
                          color: AppTheme.blue_blue_300,
                          border: Border(

                              top: BorderSide(color: AppTheme.ae2e2e2),
                              right: BorderSide(
                                  color: AppTheme.ae2e2e2))),
                      height: 35,
                      child: Center(
                        child: Text('공정명',
                            style: AppTheme.a16700
                                .copyWith(color: AppTheme.light_text_primary),
                            textAlign: TextAlign.left),
                      ),
                    ),
                  ),
                  MediaQuery.of(context).size.width <= 450 ? Container() :
                  Expanded(
                    child: Container(
                      width: 60,
                      decoration: const BoxDecoration(
                          color: AppTheme.blue_blue_300,
                          border: Border(

                              top: BorderSide(color: AppTheme.ae2e2e2),
                              right: BorderSide(
                                  color: AppTheme.ae2e2e2))),
                      height: 35,
                      child: Center(
                        child: Text('(자)두께',
                            style: AppTheme.a16700
                                .copyWith(color: AppTheme.light_text_primary),
                            textAlign: TextAlign.left),
                      ),
                    ),
                  ),
                  MediaQuery.of(context).size.width <= 450 ? Container() :
                  Expanded(
                    child: Container(
                      width: 60,
                      decoration: const BoxDecoration(
                          color: AppTheme.blue_blue_300,
                          border: Border(

                              top: BorderSide(color: AppTheme.ae2e2e2),
                              right: BorderSide(
                                  color: AppTheme.ae2e2e2))),
                      height: 35,
                      child: Center(
                        child: Text('폭',
                            style: AppTheme.a16700
                                .copyWith(color: AppTheme.light_text_primary),
                            textAlign: TextAlign.left),
                      ),
                    ),
                  ),
                  MediaQuery.of(context).size.width <= 450 ? Container() :
                  Expanded(
                    child: Container(
                      width: 60,
                      decoration: const BoxDecoration(
                          color: AppTheme.blue_blue_300,
                          border: Border(

                              top: BorderSide(color: AppTheme.ae2e2e2),
                              right: BorderSide(
                                  color: AppTheme.ae2e2e2))),
                      height: 35,
                      child: Center(
                        child: Text('길이',
                            style: AppTheme.a16700
                                .copyWith(color: AppTheme.light_text_primary),
                            textAlign: TextAlign.left),
                      ),
                    ),
                  ),
                  MediaQuery.of(context).size.width <= 450 ? Container() :
                  Expanded(
                    child: Container(
                      width: 60,
                      decoration: const BoxDecoration(
                          color: AppTheme.blue_blue_300,
                          border: Border(

                              top: BorderSide(color: AppTheme.ae2e2e2),
                              right: BorderSide(
                                  color: AppTheme.ae2e2e2))),
                      height: 35,
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
                      width: 60,
                      decoration: const BoxDecoration(
                          color: AppTheme.blue_blue_300,
                          border: Border(

                              top: BorderSide(color: AppTheme.ae2e2e2),
                              right: BorderSide(
                                  color: AppTheme.ae2e2e2))),
                      height: 35,
                      child: Center(
                        child: Text('작업자',
                            style: AppTheme.a16700
                                .copyWith(color: AppTheme.light_text_primary),
                            textAlign: TextAlign.left),
                      ),
                    ),
                  ),
                  MediaQuery.of(context).size.width <= 450 ? Container() :
                  Expanded(
                    child: Container(
                      width: 60,
                        decoration: const BoxDecoration(
                            color: AppTheme.blue_blue_300,
                            border: Border(

                                top: BorderSide(color: AppTheme.ae2e2e2),
                                right: BorderSide(
                                    color: AppTheme.ae2e2e2))),
                        height: 35,
                        child: Center(
                          child: Text('등록시간',
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

 /* Widget _topTitle(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 4, right: 4),
      padding: EdgeInsets.only(left: 18, right: 18),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Expanded(
              child: Container(

                decoration: const BoxDecoration(
                    color: AppTheme.blue_blue_300,
                    border: Border(
                        left:
                        BorderSide(color: AppTheme.ae2e2e2),
                        top: BorderSide(color: AppTheme.ae2e2e2),
                        right: BorderSide(
                            color: AppTheme.ae2e2e2))),
                height: 35,
                child: Center(
                  child: Text('구분',
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
                height: 35,
                child: Center(
                  child: Text(
                    '전일',
                    style: AppTheme.a16700
                        .copyWith(color: AppTheme.light_text_primary),
                  ),
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
                height: 35,
                child: Center(
                  child: Text('금일',
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
                height: 35,
                child: Center(
                  child: Text('등록시간',
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
                height: 35,
                child: Center(
                  child: Text('거래처',
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
                height: 35,
                child: Center(
                  child: Text('슬라브',
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
                height: 35,
                child: Center(
                  child: Text('제품명',
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
                height: 35,
                child: Center(
                  child: Text('작업자',
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
  }*/


  Widget _listArea2() {
    return Obx(() => SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _listItem2(index: index, context: context);
        }, childCount: controller.processList.length)));
  }


  Widget _listItem2({required BuildContext context,required int index}) {

    return Obx(() => Container(
      margin: EdgeInsets.only(left: 4, right: 4),
      padding: EdgeInsets.only(left: 18, right: 18),
      width: MediaQuery.of(context).size.width,
      child: Container(
          decoration: BoxDecoration(
              color: AppTheme.white,
            ),
          child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: 60,
                      decoration: const BoxDecoration(
                          color: AppTheme.white,
                          border: Border(
                              left:
                              BorderSide(color: AppTheme.ae2e2e2),
                              top: BorderSide(color: AppTheme.ae2e2e2),
                              right: BorderSide(
                                  color: AppTheme.ae2e2e2))),
                      height: 50,
                      child: Center(
                        child: Text(controller.processList[index]['CMH_NM'].toString(),
                          style: AppTheme.a12500
                              .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                      ),

                  ),
                ),
                MediaQuery.of(context).size.width <= 450 ? Container() :
                Expanded(
                  child: Container(
                    width: 60,
                      decoration: const BoxDecoration(
                          color: AppTheme.white,
                          border: Border(
                              top: BorderSide(color: AppTheme.ae2e2e2),
                              right: BorderSide(
                                  color: AppTheme.ae2e2e2))),
                      height: 50,
                      child: Center(
                          child: Text(
                            controller.lastList[index]['BE_CNT'].toString(),
                            style: AppTheme.a12500
                                .copyWith(color: AppTheme.black), textAlign: TextAlign.center,)
                      ),

                  ),
                ),
                MediaQuery.of(context).size.width <= 450 ? Container() :
                Expanded(
                  child: Container(
                    width: 60,
                      decoration: const BoxDecoration(
                          color: AppTheme.white,
                          border: Border(

                              top: BorderSide(color: AppTheme.ae2e2e2),
                              right: BorderSide(
                                  color: AppTheme.ae2e2e2))),
                      height: 50,
                      child: Center(
                        child: Text(controller.currentList[index]['BE_CNT'].toString(),
                          style: AppTheme.a12500
                              .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                      ),

                  ),
                ),
                Expanded(
                  child: Container(
                    width: 60,
                      decoration: const BoxDecoration(
                          color: AppTheme.white,
                          border: Border(

                              top: BorderSide(color: AppTheme.ae2e2e2),
                              right: BorderSide(
                                  color: AppTheme.ae2e2e2))),
                      height: 50,
                      child: Center(
                        child: Text(controller.processList[index]['CST_NM'].toString(),
                          style: AppTheme.a12500
                              .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                      ),

                  ),
                ),
                Expanded(
                  child: Container(
                    width: 60,
                      decoration: const BoxDecoration(
                          color: AppTheme.white,
                          border: Border(

                              top: BorderSide(color: AppTheme.ae2e2e2),
                              right: BorderSide(
                                  color: AppTheme.ae2e2e2))),
                      height: 50,
                      child: Center(
                        child: Text(controller.processList[index]['SLB_NO'].toString(),
                          style: AppTheme.a12500
                              .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                      ),

                  ),
                ),
                Expanded(
                  child: Container(
                    width: 60,
                      decoration: const BoxDecoration(
                          color: AppTheme.white,
                          border: Border(
                              top: BorderSide(color: AppTheme.ae2e2e2),
                              right: BorderSide(
                                  color: AppTheme.ae2e2e2))),
                      height: 50,
                      child: Center(
                        child: Text(controller.processList[index]['CMP_NM'].toString(),
                          style: AppTheme.a12500
                              .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                      ),

                  ),
                ),
                MediaQuery.of(context).size.width <= 450 ? Container() :
                Expanded(
                  child: Container(
                    width: 60,
                    decoration: const BoxDecoration(
                        color: AppTheme.white,
                        border: Border(
                            top: BorderSide(color: AppTheme.ae2e2e2),
                            right: BorderSide(
                                color: AppTheme.ae2e2e2))),
                    height: 50,
                    child: Center(
                      child: Text(controller.processList[index]['SHP_NM'].toString(),
                        style: AppTheme.a12500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                    ),

                  ),
                ),
                MediaQuery.of(context).size.width <= 450 ? Container() :
                Expanded(
                  child: Container(
                    width: 60,
                    decoration: const BoxDecoration(
                        color: AppTheme.white,
                        border: Border(
                            top: BorderSide(color: AppTheme.ae2e2e2),
                            right: BorderSide(
                                color: AppTheme.ae2e2e2))),
                    height: 50,
                    child: Center(
                      child: Text(controller.processList[index]['STT_NM'].toString(),
                        style: AppTheme.a12500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                    ),

                  ),
                ),
                MediaQuery.of(context).size.width <= 450 ? Container() :
                Expanded(
                  child: Container(
                    width: 60,
                    decoration: const BoxDecoration(
                        color: AppTheme.white,
                        border: Border(
                            top: BorderSide(color: AppTheme.ae2e2e2),
                            right: BorderSide(
                                color: AppTheme.ae2e2e2))),
                    height: 50,
                    child: Center(
                      child: Text(controller.processList[index]['duke'].toString(),
                        style: AppTheme.a12500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                    ),

                  ),
                ),
                MediaQuery.of(context).size.width <= 450 ? Container() :
                Expanded(
                  child: Container(
                    width: 60,
                    decoration: const BoxDecoration(
                        color: AppTheme.white,
                        border: Border(
                            top: BorderSide(color: AppTheme.ae2e2e2),
                            right: BorderSide(
                                color: AppTheme.ae2e2e2))),
                    height: 50,
                    child: Center(
                      child: Text(controller.processList[index]['CPR_NM'].toString(),
                        style: AppTheme.a12500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                    ),

                  ),
                ),
                MediaQuery.of(context).size.width <= 450 ? Container() :
                Expanded(
                  child: Container(
                    width: 60,
                    decoration: const BoxDecoration(
                        color: AppTheme.white,
                        border: Border(
                            top: BorderSide(color: AppTheme.ae2e2e2),
                            right: BorderSide(
                                color: AppTheme.ae2e2e2))),
                    height: 50,
                    child: Center(
                      child: Text(controller.processList[index]['THIC'].toString(),
                        style: AppTheme.a12500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                    ),

                  ),
                ),
                MediaQuery.of(context).size.width <= 450 ? Container() :
                Expanded(
                  child: Container(
                    width: 60,
                    decoration: const BoxDecoration(
                        color: AppTheme.white,
                        border: Border(
                            top: BorderSide(color: AppTheme.ae2e2e2),
                            right: BorderSide(
                                color: AppTheme.ae2e2e2))),
                    height: 50,
                    child: Center(
                      child: Text(controller.processList[index]['WIDTH'].toString(),
                        style: AppTheme.a12500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                    ),

                  ),
                ),
                MediaQuery.of(context).size.width <= 450 ? Container() :
                Expanded(
                  child: Container(
                    width: 60,
                    decoration: const BoxDecoration(
                        color: AppTheme.white,
                        border: Border(
                            top: BorderSide(color: AppTheme.ae2e2e2),
                            right: BorderSide(
                                color: AppTheme.ae2e2e2))),
                    height: 50,
                    child: Center(
                      child: Text(controller.processList[index]['LENGTH'].toString(),
                        style: AppTheme.a12500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                    ),

                  ),
                ),
                MediaQuery.of(context).size.width <= 450 ? Container() :
                Expanded(
                  child: Container(
                    width: 60,
                    decoration: const BoxDecoration(
                        color: AppTheme.white,
                        border: Border(
                            top: BorderSide(color: AppTheme.ae2e2e2),
                            right: BorderSide(
                                color: AppTheme.ae2e2e2))),
                    height: 50,
                    child: Center( //NumberFormat('###,###,###,###').format(controller.processList[index]['WHT']).toString()
                      child: Text(NumberFormat.simpleCurrency(decimalDigits: 1).format(controller.processList[index]['WHT']).toString().replaceRange(0, 1, ''),
                        style: AppTheme.a12500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                    ),

                  ),
                ),
                MediaQuery.of(context).size.width <= 450 ? Container() :
                Expanded(
                  child: Container(
                    width: 60,
                    decoration: const BoxDecoration(
                        color: AppTheme.white,
                        border: Border(
                            top: BorderSide(color: AppTheme.ae2e2e2),
                            right: BorderSide(
                                color: AppTheme.ae2e2e2))),
                    height: 50,
                    child: Center(
                      child: Text(controller.processList[index]['USR'].toString(),
                        style: AppTheme.a12500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                    ),

                  ),
                ),
                MediaQuery.of(context).size.width <= 450 ? Container() :
                Expanded(
                  child: Container(
                    width: 60,
                    decoration: const BoxDecoration(
                        color: AppTheme.white,
                        border: Border(
                            top: BorderSide(color: AppTheme.ae2e2e2),
                            right: BorderSide(
                                color: AppTheme.ae2e2e2))),
                    height: 50,
                    child: Center( // controller.processList[index]['DT'].substring(0, 8)
                      child: Text('${controller.processList[index]['DT'].substring(8, 10)}일 ${controller.processList[index]['DT'].substring(11, 16)}',
                        style: AppTheme.a12500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                    ),

                  ),
                ),
              ],
            ),

      ),
    ));
  }

/*  Widget _listItem2({required BuildContext context,required int index}) {

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
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppTheme.white,
                      border: Border(
                          left:
                          BorderSide(color: AppTheme.ae2e2e2),
                          top: BorderSide(color: AppTheme.ae2e2e2),
                          right: BorderSide(
                              color: AppTheme.ae2e2e2))),
                  height: 50,
                  child: Center(
                    child: Text(controller.processList[index]['CRP_NAME'].toString(),
                      style: AppTheme.a12500
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
                  height: 50,
                  child: Center(
                      child: Text(
                        controller.processList[index]['PRE_DT'].toString(),
                        style: AppTheme.a12500
                            .copyWith(color: AppTheme.black), textAlign: TextAlign.center,)
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
                  height: 50,
                  child: Center(
                    child: Text(controller.processList[index]['CUR_DT'].toString(),
                      style: AppTheme.a12500
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
                  height: 50,
                  child: Center(
                    child: Text(controller.processList[index]['IST_DT'].toString(),
                      style: AppTheme.a12500
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
                  height: 50,
                  child: Center(
                    child: Text(controller.processList[index]['CST_NM'].toString(),
                      style: AppTheme.a12500
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
                  height: 50,
                  child: Center(
                    child: Text(controller.processList[index]['SLB_NO'].toString(),
                      style: AppTheme.a12500
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
                  height: 50,
                  child: Center(
                    child: Text(controller.processList[index]['CMH_NM'].toString(),
                      style: AppTheme.a12500
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
                  height: 50,
                  child: Center(
                    child: Text(controller.processList[index]['WRK_NM1'].toString(),
                      style: AppTheme.a12500
                          .copyWith(color: AppTheme.black), textAlign: TextAlign.center,),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }*/
}