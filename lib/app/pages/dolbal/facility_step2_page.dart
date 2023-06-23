import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/common/common_confirm_widget.dart';
import 'package:egu_industry/app/common/dialog_widget.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:egu_industry/app/pages/blueTooth/blue_tooth_controller.dart';
import 'package:egu_industry/app/pages/dolbal/facility_controller.dart';
import 'package:egu_industry/app/pages/home/home_controller.dart';
import 'package:egu_industry/app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CommonAppbarWidget(title: '설비/안전 점검 - 정비내역 등록', isLogo: false, ),
          _bodyArea(context),
         //_streamBuilder()

        ],
      ),
      bottomNavigationBar: _bottomButton(context), // 점검의뢰 등록
    );
  }

  Widget _bodyArea(BuildContext context) {
    return SliverToBoxAdapter(
        child: Obx(() => Container(
          padding: EdgeInsets.only(left: 18, right: 18, top: 24),
          child: Column(
            children: [
              _topDataItem(),
              _inputArea(context),
              _partChoiceBody()
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
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 14, bottom: 14, right: 8, left: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppTheme.blue_blue_200,
                  ),
                  child: Center(
                    child: Text('${controller.selectedContainer[0]['IR_CODE']}', style: AppTheme.bodyBody1.copyWith(color: AppTheme.black),),
                  ),
                )
            ),
            SizedBox(width: 8,),
            Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 14, bottom: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppTheme.blue_blue_200,
                  ),
                  child: Center(
                    child: Text('${controller.selectedContainer[0]['INS_FG']}', style: AppTheme.bodyBody1.copyWith(color: AppTheme.black),),
                  ),
                )
            ),
            SizedBox(width: 8,),
            Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 14, bottom: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppTheme.blue_blue_200,
                  ),
                  child: Center(
                    child: Text('${controller.selectedContainer[0]['MACH_CODE']}', style: AppTheme.bodyBody1.copyWith(color: AppTheme.black),),
                  ),
                )
            ),

          ],
        ),
        SizedBox(height: 8,),
        Row(
          children: [
            Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 14, bottom: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppTheme.blue_blue_200,
                  ),
                  child: Center(
                      child:  Text(controller.selectedContainer[0]['RESULT_FG'] == 'N' ? '미조치' :
                      controller.selectedContainer[0]['RESULT_FG'] == 'Y' ? '조치완료' :
                      controller.selectedContainer[0]['RESULT_FG'] == 'I' ? '조치 진행중' : '',
                          style: AppTheme.bodyBody1
                              .copyWith(color: AppTheme.light_success))
                  ),
                )
            ),
            const SizedBox(width: 8,),
            Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 14, bottom: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppTheme.blue_blue_200,
                  ),
                  child: Center(
                      child:  Text('${controller.selectedContainer[0]['IR_DATE']}',
                          style: AppTheme.bodyBody1
                              .copyWith(color: AppTheme.light_success))
                  ),
                )
            ),
          ],
        ),
        const SizedBox(height: 8,),
        Row(
          children: [
            Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 14, bottom: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppTheme.blue_blue_200,
                  ),
                  child: Center(
                      child:  Text('${controller.selectedContainer[0]['IR_USER']}',
                          style: AppTheme.bodyBody1
                              .copyWith(color: AppTheme.light_success))
                  ),
                )
            ),
            SizedBox(width: 8,),
            Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 14, bottom: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppTheme.blue_blue_200,
                  ),
                  child: Center(
                      child:  Text('전기팀',
                          style: AppTheme.bodyBody1
                              .copyWith(color: AppTheme.light_success))
                  ),
                )
            ),
          ],
        )
      ],
    );
  }

  Widget _inputArea(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          SizedBox(height: 24,),
          Row(
            children: [
              Icon(Icons.circle, size: 8,),
              SizedBox(width: 8,),
              Text('정비내역 등록',
                  style: AppTheme.titleHeadline
                      .copyWith(color: AppTheme.black))
            ],
          ),

          SizedBox(height: 12,),
          _inputEngineerItem(context),
          SizedBox(height: 12,),
          _dropDownItem(context, '정비유형', 1),
          SizedBox(height: 12,),
          _dropDownItem(context, '정비상태', 2),
          SizedBox(height: 12,),
          _startEndCalendarItem(context),
          SizedBox(height: 12,),
          _dropDownItem(context, '미조치 사유', 3),
          SizedBox(height: 12,),
          _engineContentItem()
        ],
      ),
    );
  }

  Widget _inputEngineerItem(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('정비자 (검색으로 바꿔야할듯)',
            style: AppTheme.bodyBody1
                .copyWith(color: AppTheme.black)),
        SizedBox(height: 4,),
        Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: const Border(
                  top: BorderSide(color: AppTheme.light_ui_08),
                  bottom:
                  BorderSide(color: AppTheme.light_ui_08),
                  right:
                  BorderSide(color: AppTheme.light_ui_08),
                  left:
                  BorderSide(color: AppTheme.light_ui_08))),
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: DropdownButton<String>(
              borderRadius: BorderRadius.circular(3),
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
              value: controller.selectedEnginner.value,
              items: controller.engineerList.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(
                    value,
                    style: AppTheme.titleSubhead3
                        .copyWith(color: value == '정비자를 선택해주세요' ? AppTheme.light_ui_07 : AppTheme.black),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                controller.selectedEnginnerIndex.value = controller.engineerList.indexOf(value);
                controller.rpUser.value = controller.engineerIdList[controller.selectedEnginnerIndex.value];
                controller.selectedEnginner.value = value!;

                Get.log('$value 선택!!!!');
                // Get.log('${HomeApi.to.BIZ_DATA('L_USER_001')}');
              }),
        ),

      ],
    );
  }

  Widget _dropDownItem(BuildContext context, String title, int flag) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: AppTheme.bodyBody1
                .copyWith(color: AppTheme.black)),
        SizedBox(height: 4,),
        Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: const Border(
                  top: BorderSide(color: AppTheme.light_ui_08),
                  bottom:
                  BorderSide(color: AppTheme.light_ui_08),
                  right:
                  BorderSide(color: AppTheme.light_ui_08),
                  left:
                  BorderSide(color: AppTheme.light_ui_08))),
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: DropdownButton<String>(
              borderRadius: BorderRadius.circular(3),
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
                    style: AppTheme.titleSubhead3
                        .copyWith(color: value == '전체' ? AppTheme.light_ui_07 : AppTheme.black),
                  ),
                );
              }).toList() : flag == 2 ?
              controller.resultFgList.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(
                    value,
                    style: AppTheme.titleSubhead3
                        .copyWith(color: value == '전체' ? AppTheme.light_ui_07 : AppTheme.black),
                  ),
                );
              }).toList() : controller.noReasonList.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(
                    value,
                    style: AppTheme.titleSubhead3
                        .copyWith(color: value == '전체' ? AppTheme.light_ui_07 : AppTheme.black),
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
      ],
    );
  }
  /// 정비날짜 정하기
  Widget _startEndCalendarItem(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('정비날짜',
            style: AppTheme.bodyBody1
                .copyWith(color: AppTheme.black)),
        SizedBox(height: 4,),
        Row(
          children: [
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
                      context,
                      initialDate: DateTime(1994),
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2060),
                      dateFormat: "yyyy-MM-dd",
                      locale: DateTimePickerLocale.ko,
                      looping: true,
                    );
                    int startIndex = datePicked.toString().indexOf(' ');
                    int lastIndex = datePicked.toString().length;
                    controller.dayStartValue.value = datePicked.toString().replaceRange(startIndex, lastIndex, '');
                    Get.log('${controller.dayStartValue.value}');
                    final snackBar =
                    SnackBar(content: Text("Date Picked $datePicked"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: const Border(
                            top: BorderSide(color: AppTheme.light_ui_08),
                            bottom:
                            BorderSide(color: AppTheme.light_ui_08),
                            right:
                            BorderSide(color: AppTheme.light_ui_08),
                            left:
                            BorderSide(color: AppTheme.light_ui_08))),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Center(
                      child: Text('${controller.dayStartValue.value}', style: AppTheme.bodyBody1
                          .copyWith(color: AppTheme.black)),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 4,),
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
                      context,
                      initialDate: DateTime(1994),
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2060),
                      dateFormat: "yyyy-MM-dd",
                      locale: DateTimePickerLocale.ko,
                      looping: true,
                    );
                    int startIndex = datePicked.toString().indexOf(' ');
                    int lastIndex = datePicked.toString().length;
                    controller.dayEndValue.value = datePicked.toString().replaceRange(startIndex, lastIndex, '');
                    Get.log('${controller.dayEndValue.value}');
                    final snackBar =
                    SnackBar(content: Text("Date Picked $datePicked"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: const Border(
                            top: BorderSide(color: AppTheme.light_ui_08),
                            bottom:
                            BorderSide(color: AppTheme.light_ui_08),
                            right:
                            BorderSide(color: AppTheme.light_ui_08),
                            left:
                            BorderSide(color: AppTheme.light_ui_08))),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Center(
                      child: Text('${controller.dayEndValue.value}', style: AppTheme.bodyBody1
                          .copyWith(color: AppTheme.black)),
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
            style: AppTheme.bodyBody1
                .copyWith(color: AppTheme.black)),
        SizedBox(height: 4,),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.black),
            // borderRadius: BorderRadius.circular(5)
          ),
          width: double.infinity,
          child: TextFormField(
              maxLines: 5,
              controller: controller.textContentController,
              textInputAction: TextInputAction.search,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                // prefixIcon: const Icon(Icons.search),
                /*suffixIcon: controller.searchText.isEmpty
                    ? null
                    : IconButton(
                  icon: SvgPicture.asset('assets/app/clear.svg', width: 24, height: 24,),
                  onPressed: () {
                    Get.log('삭제 아이콘');
                    controller.clearSearch();
                  },
                ),*/
                hintText: '내용을 입력해주세요',
                border: InputBorder.none,
              ),
              showCursor: true,

              // onChanged: ((value) => controller.submitSearch(value)),
            ),
          ),
      ],
    );
  }

  Widget _partChoiceBody() {
    return Column(
        children: [
          SizedBox(height: 24,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.circle, size: 8,),
                  SizedBox(width: 8,),
                  Text('사용부품 정보 등록',
                      style: AppTheme.titleHeadline
                          .copyWith(color: AppTheme.black))
                ],
              ),
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
                onPressed: () {
                  Get.log('추가');
                },
                child: Container(
                      padding: EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
                      color: AppTheme.light_success,
                      child: Center(
                        child: Text('추가', style: AppTheme.bodyBody1.copyWith(color: AppTheme.white),),
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
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.remove_circle, size: 25, color: AppTheme.red_red_900,),
                    SizedBox(width: 4,),
                    Text(
                      '부품~~~~~~~~~~~~',
                      style: AppTheme.titleSubhead4.copyWith(
                        color: AppTheme.black,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 12,),
                Row(
                  children: [
                    Icon(Icons.remove_circle, size: 25, color: AppTheme.red_red_900,),
                    SizedBox(width: 4,),
                    Text(
                      '부품2~~~~~~~~~~~~',
                      style: AppTheme.titleSubhead4.copyWith(
                        color: AppTheme.black,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
    );
  }

  Widget _bottomButton(BuildContext context) {
    return Obx(() => BottomAppBar(
      child: (() {
        if(controller.selectedIrFq.value != '전체' && controller.selectedResultFg.value != '전체'
            && controller.selectedNoReason.value != '전체'
        && controller.selectedEnginner.value != '정비자를 선택해주세요') {
          controller.isStep2RegistBtn.value = true;
        }else {
          controller.isStep2RegistBtn.value = false;
        }
        return TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0))),
                backgroundColor: controller.isStep2RegistBtn.value ?
                MaterialStateProperty.all<Color>(AppTheme.light_primary) :
                MaterialStateProperty.all<Color>(AppTheme.light_cancel),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(0))),
            onPressed: controller.isStep2RegistBtn.value ? () async {
              controller.cdConvert();
              controller.saveButton();
             // Get.toNamed(Routes.FACILITY);
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




}
