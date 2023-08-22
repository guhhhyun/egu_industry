import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/common/common_confirm_widget.dart';
import 'package:egu_industry/app/common/dialog_widget.dart';
import 'package:egu_industry/app/net/home_api.dart';
import 'package:egu_industry/app/pages/blueTooth/blue_tooth_controller.dart';
import 'package:egu_industry/app/pages/facilitySecond/facility_controller.dart';
import 'package:egu_industry/app/pages/home/home_controller.dart';
import 'package:egu_industry/app/pages/scrapLabel/scrap_label_controller.dart';
import 'package:egu_industry/app/routes/app_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


class ScrapLabelPage extends StatelessWidget {
  ScrapLabelPage({Key? key}) : super(key: key);

  ScrapLabelController controller = Get.find();
  final formKey = GlobalKey<FormState>();
  final ScrollController myScrollWorks = ScrollController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CommonAppbarWidget(title: '스크랩 라벨발행', isLogo: false, isFirstPage: true ),
            _bodyArea(context),
            //_streamBuilder()

          ],
        ),
      ),
     // bottomNavigationBar: _bottomButton(context), // 점검의뢰 등록
    );
  }

  Widget _bodyArea(BuildContext context) {
    return SliverToBoxAdapter(
        child: /*Obx(() => */Container(
          color: AppTheme.white,
          child: Column(
            children: [
              _inputArea(context),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 12,
                color: AppTheme.gray_gray_100,
              ),
            ],
          ),
        ),/*)*/
    );
  }


  Widget _inputTitle(String title) {
    return Expanded(
        child: Container(
          padding: EdgeInsets.only(top: 16),
          child: Text(title, style: AppTheme.titleSubhead4.copyWith(color: AppTheme.black),),
        )
    );
  }

  Widget _inputArea(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 18, right: 18),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(height: 40,),
            Row(
              children: [
                _inputTitle('구분'),
              ],
            ),
            const SizedBox(height: 12,),

            Column(
              children: [
                SizedBox(height: 15,),
                Row(
                  children: [
                    _inputTitle('미조치 사유'),
                  ],
                ),
                const SizedBox(height: 12,),
              ],
            ),
            SizedBox(height: 40,),
            SizedBox(height: 70,),
          ],
        ),
      ),
    );
  }


  Widget _codeInputItem() {
    return Column(
      children: [
        Center(
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
                    onTap: () {
                      Get.log('조회 돋보기 클릭!');
                      controller.checkButton();
                      controller.isCheck.value = true;
                    },
                    child: Image.asset('assets/app/search.png', color: AppTheme.a6c6c6c, width: 32, height: 32,)
                ),

                contentPadding: const EdgeInsets.all(0),
                fillColor: Colors.white,
                filled: true,
                hintText: '계량번호를 입력해주세요',
                hintStyle: AppTheme.a16400.copyWith(color: AppTheme.aBCBCBC),
                border: InputBorder.none,
              ),
              showCursor: true,

              // onChanged: ((value) => controller.submitSearch(value)),
            ),
          ),
        ),
        SizedBox(height: 4,),
        controller.isCheck.value == true ?
        Container(
          margin: const EdgeInsets.only(left: 4, right: 4, bottom: 18),
          padding: const EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.ae2e2e2),
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
                  controller.insNumList.isNotEmpty ?
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppTheme.aecf9f2
                        ),
                        child: Text(controller.insNumList[0]['CAR_NO'],
                            style: AppTheme.a12500
                                .copyWith(color: AppTheme.a18b858)),
                      ),
                    ],
                  )
                      : Container(),
                ],
              ),
              SizedBox(height: 8,),
              controller.insNumList.isNotEmpty ?
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(controller.insNumList[0]['CUST_NM'],
                      style: AppTheme.a16700
                          .copyWith(color: AppTheme.black)),
                ],
              )
                  : Container(),
              controller.insNumList.isNotEmpty ?
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(controller.insNumList[0]['CST_ID'],
                      style: AppTheme.a15700
                          .copyWith(color: AppTheme.black)),
                ],
              )
                  : Container(),
            ],
          ),
        ) : Container()
      ],
    );
  }

 /* Widget _dropDownItem(BuildContext context, int flag) {
    return Expanded(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            border: const Border(
              bottom:
              BorderSide(color: AppTheme.light_ui_08),
            )),
        padding: const EdgeInsets.only(right: 12),
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
            value: flag == 1 ? controller.selectedIrFq.value :
            flag == 2 ? controller.selectedResultFg.value : controller.selectedNoReason.value,
            //  flag == 3 ? controller.selectedNoReason.value :
            items: flag == 1 ? controller.irfgList.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(
                  value,
                  style: AppTheme.bodyBody1
                      .copyWith(color: value == '선택해주세요' ? AppTheme.gray_gray_400 : AppTheme.black, fontSize: 17),
                ),
              );
            }).toList() : flag == 2 ?
            controller.resultFgList.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(
                  value,
                  style: AppTheme.bodyBody1
                      .copyWith(color: value == '전체' ? AppTheme.gray_gray_400 : AppTheme.black, fontSize: 17),
                ),
              );
            }).toList() : controller.noReasonList.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(
                  value,
                  style: AppTheme.bodyBody1
                      .copyWith(color: value == '선택해주세요' ? AppTheme.gray_gray_400 : AppTheme.black, fontSize: 17),
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
    );
  }*/




  /*Widget _bottomButton(BuildContext context) {
    return Obx(() => BottomAppBar(
        color: AppTheme.white,
        surfaceTintColor: AppTheme.white,
        child: (() {
          if(controller.selectedResultFg.value != '전체'
              && controller.selectedNoReason.value != '전체'
              && controller.selectedEnginner.value != '정비자를 선택해주세요' &&  controller.dayStartValue.value != '선택해주세요' &&
              controller.dayEndValue.value != '선택해주세요' && controller.textContentController.text != '') {
            controller.isStep2RegistBtn.value = true;
          }else {
            controller.isStep2RegistBtn.value = false;
          }
          return TextButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  backgroundColor: controller.isStep2RegistBtn.value ?
                  MaterialStateProperty.all<Color>(AppTheme.a1f1f1f) :
                  MaterialStateProperty.all<Color>(AppTheme.light_cancel),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(0))),
              onPressed: controller.isStep2RegistBtn.value ? () async {
                controller.cdConvert();
                controller.saveButton();

                SchedulerBinding.instance!.addPostFrameCallback((_) {
                  Get.dialog(
                      CommonDialogWidget(contentText: '저장되었습니다', flag: 2, pageFlag: 2,)
                  );
                });
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
  }*/


}
