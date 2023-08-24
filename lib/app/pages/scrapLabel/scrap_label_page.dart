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
      bottomNavigationBar: _bottomButton(context), // 라벨 발행
    );
  }

  Widget _bodyArea(BuildContext context) {
    return SliverToBoxAdapter(
        child: /*Obx(() => */Container(
          color: AppTheme.white,
          child: Column(
            children: [
              _inputArea(context),
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

  /// 매입과 외주 차이 = 외주스크랩 유무
  /// 공정회수와 매입 차이 = 공정정보 대신 계량정보 빼기
  Widget _inputArea(BuildContext context) {
    return Obx(() => Container(
      padding: EdgeInsets.only(left: 18, right: 18),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(height: 40,),
            _dropDownItem(context, '구분', 1),
            const SizedBox(height: 45,),
            controller.selectedGubun.value == '지금류' ?
            Container() :
            Column(
              children: [
                _dropDownItem(context, '유형', 2),
                controller.selectedScrapType.value == '매입' ?
                    Container() :
                    Column(
                      children: [
                        SizedBox(height: 45,),
                        _industryItem('공정정보', 1), // 수량이랑 단위중량도 안보이게
                      ],
                    ),
                SizedBox(height: 45,),
                _dropDownItem(context, '도금', 3),
                SizedBox(height: 45,),
                _industryItem('스크랩품명', 2),
                SizedBox(height: 45,),
              ],
            ),
            controller.selectedGubun.value == '지금류' ? /// 이건 고정 바꿀 필요 없음
            Column(
              children: [
                _industryItem('지금류품명', 3),
                SizedBox(height: 45,),
              ],
            ) : Container(),
            _locationArea(),
            SizedBox(height: 45,),
            controller.selectedGubun.value == '지금류' ?
            Container() :
            Column(
              children: [
                _weighing(),
                SizedBox(height: 12,),
                _weighingTwo(),
              ],
            ),
            SizedBox(height: 100,),
            SizedBox(height: 45,),
          ],
        ),
      ),
    ));
  }


  Widget _dropDownItem(BuildContext context, String text, int flag) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,
            style: AppTheme.a15700
                .copyWith(color: AppTheme.black)),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    border: const Border(
                      bottom: BorderSide(color: AppTheme.gray_gray_200),
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
                      color: AppTheme.light_placeholder,
                    ),
                    dropdownColor: AppTheme.light_ui_01,
                    value: flag == 1 ? controller.selectedGubun.value :
                    flag == 2 ? controller.selectedScrapType.value :
                      flag == 3 ? controller.selectedGold.value : '',
                    items: flag == 1 ? controller.scrapGubunList.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: AppTheme.a16400
                              .copyWith(color: value == '선택해주세요' ? AppTheme.aBCBCBC : AppTheme.a6c6c6c),
                        ),
                      );
                    }).toList() : flag == 2 ?
                    controller.scrapTypeList.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: AppTheme.a16400
                              .copyWith(color: value == '선택해주세요' ? AppTheme.aBCBCBC : AppTheme.a6c6c6c),
                        ),
                      );
                    }).toList() : flag == 3 ?
                    controller.goldList.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: AppTheme.a16400
                              .copyWith(color: value == '선택해주세요' ? AppTheme.aBCBCBC : AppTheme.a6c6c6c),
                        ),
                      );
                    }).toList() : null,
                    onChanged: (value) async {
                      flag == 1 ?
                      controller.selectedGubun.value = value! :
                      flag == 2 ?
                      controller.selectedScrapType.value = value! :
                      flag == 3 ?
                      controller.selectedGold.value = value! : Get.log('$value 선택!!!!');

                      /// 스크랩 선택으로 인한 적재위치 리스트 변경
                     if(flag == 1 && controller.selectedGubun.value == '스크랩') {
                        await HomeApi.to.PROC('USP_SCS0300_R01', {'@p_WORK_TYPE':'Q_RACK', '@p_WHERE1':'W04'}).then((value) => // 적재위치(스크랩)
                        {
                          value['DATAS'].insert(0, {'RACK_BARCODE':'', 'NAME': '선택해주세요'}),
                          controller.scLocList.value = value['DATAS'],
                        });
                      }else if(flag == 1 && controller.selectedGubun.value == '지금류') {
                       await HomeApi.to.PROC('USP_SCS0300_R01', {'@p_WORK_TYPE':'Q_RACK', '@p_WHERE1':'W02'}).then((value) => // // 적재위치(지금류)
                       {
                         value['DATAS'].insert(0, {'RACK_BARCODE':'', 'NAME': '선택해주세요'}),
                         controller.scLocList.value = value['DATAS'],
                       });
                     }
                     /// //////////////////////////////////////////////////////////////
                      Get.log('$value 선택!!!!');
                      // Get.log('${HomeApi.to.BIZ_DATA('L_USER_001')}');
                    }),

              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _industryItem(String text, int flag) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,
            style: AppTheme.a15700
                .copyWith(color: AppTheme.black)),
        const SizedBox(height: 10,),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    border: const Border(
                      bottom: BorderSide(color: AppTheme.gray_gray_200),
                    )),
                padding: const EdgeInsets.only(right: 12),
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
                    value: flag == 1 ? controller.selectedIndustryMap['NAME']
                      : flag == 2 ? controller.selectedScrapNmMap['NAME'] :
                      controller.selectedRmNmMap['NAME'],
                    //  flag == 3 ? controller.selectedNoReason.value :
                    items: flag == 1 ? controller.industryList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value['NAME'].toString(),
                        child: Text(
                          value['NAME'].toString(),
                          style: AppTheme.a16400
                              .copyWith(color: value['NAME'].toString() == '선택해주세요' ? AppTheme.aBCBCBC : AppTheme.a6c6c6c),
                        ),
                      );
                    }).toList() : flag == 2 ? controller.scrapNmList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value['NAME'].toString(),
                        child: Text(
                          value['NAME'].toString(),
                          style: AppTheme.a16400
                              .copyWith(color: value['NAME'].toString() == '선택해주세요' ? AppTheme.aBCBCBC : AppTheme.a6c6c6c),
                        ),
                      );
                    }).toList() :
                    controller.rmNmList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value['NAME'].toString(),
                        child: Text(
                          value['NAME'].toString(),
                          style: AppTheme.a16400
                              .copyWith(color: value['NAME'].toString() == '선택해주세요' ? AppTheme.aBCBCBC : AppTheme.a6c6c6c),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      flag == 1 ?
                      controller.industryList.map((e) {
                        if(e['NAME'] == value) {
                          controller.selectedIndustryMap['CODE'] = e['CODE'];
                          controller.selectedIndustryMap['NAME'] = e['NAME'];
                        }
                      }).toList() : flag == 2 ?
                      controller.scrapNmList.map((e) {
                        if(e['NAME'] == value) {
                          controller.selectedScrapNmMap['CODE'] = e['CODE'];
                          controller.selectedScrapNmMap['NAME'] = e['NAME'];
                        }
                      }).toList() :
                      controller.rmNmList.map((e) {
                        if(e['NAME'] == value) {
                          controller.selectedRmNmMap['CODE'] = e['CODE'];
                          controller.selectedRmNmMap['NAME'] = e['NAME'];
                        }
                      }).toList();
                      Get.log('${ controller.selectedScrapNmMap} 선택!!!!');
                      Get.log('${ controller.selectedIndustryMap} 선택!!!!');
                    }),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _locationArea() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppTheme.gray_gray_200),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('적재창고',
                    style: AppTheme.a15700
                        .copyWith(color: AppTheme.black)),
                const SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.only(right: 12, top: 12, bottom: 12),
                  child: Text(controller.selectedGubun.value == '지금류' ? '원자재창고'
                      : controller.selectedGubun.value == '스크랩' ? '스크랩창고' : '', style: AppTheme.a16400
                      .copyWith(color: AppTheme.a6c6c6c),),
                )
              ],
            ),
          ),
        ),
        const SizedBox(width: 12,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('적재위치',
                  style: AppTheme.a15700
                      .copyWith(color: AppTheme.black)),
              const SizedBox(height: 10,),
              Container(
                height: 50,
                decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppTheme.gray_gray_200),
                    )),
                padding: const EdgeInsets.only(right: 12),
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
                    value: controller.selectedScLocMap['NAME'],
                    //  flag == 3 ? controller.selectedNoReason.value :
                    items: controller.scLocList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value['NAME'].toString(),
                        child: Text(
                          value['NAME'].toString(),
                          style: AppTheme.a16400
                              .copyWith(color: value['NAME'].toString() == '선택해주세요' ? AppTheme.aBCBCBC : AppTheme.a6c6c6c),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedGubun.value == '스크랩' ?
                      controller.scLocList.map((e) {
                        if(e['NAME'] == value) {
                          controller.selectedScLocMap['RACK_BARCODE'] = e['RACK_BARCODE'];
                          controller.selectedScLocMap['NAME'] = e['NAME'];
                        }
                      }).toList() :
                      controller.scLocList.map((e) {
                        if(e['NAME'] == value) {
                          controller.selectedScLocMap['RACK_BARCODE'] = e['RACK_BARCODE'];
                          controller.selectedScLocMap['NAME'] = e['NAME'];
                        }
                      }).toList();
                      Get.log('${ controller.selectedScLocMap} 선택!!!!');
                    }),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _weighing() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('계근중량 / 설통번호 / 설통중량',
            style: AppTheme.a15700
                .copyWith(color: AppTheme.black)),
      //  const SizedBox(height: 10,),
        Container(
          padding: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
              border: const Border(
                bottom: BorderSide(color: AppTheme.gray_gray_200),
              )),
          width: double.infinity,
          child: TextFormField(
            style:  AppTheme.a16400.copyWith(color: AppTheme.a6c6c6c),
            // maxLines: 5,
            controller: controller.weighingTextController,
            textAlignVertical: TextAlignVertical.center,
            textInputAction: TextInputAction.search,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(0),
              fillColor: Colors.white,
              filled: true,
              hintText: '계근중량을 입력해주세요',
              hintStyle: AppTheme.a16400.copyWith(color: AppTheme.aBCBCBC),
              border: InputBorder.none,
            ),
            showCursor: true,

            // onChanged: ((value) => controller.submitSearch(value)),
          ),
        ),
      ],
    );
  }

  Widget _weighingTwo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                    border: const Border(
                      bottom: BorderSide(color: AppTheme.gray_gray_200),
                    )),
                padding: const EdgeInsets.only(right: 12),
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
                    value: controller.selectedScLocMap['NAME'],
                    //  flag == 3 ? controller.selectedNoReason.value :
                    items: controller.scLocList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value['NAME'].toString(),
                        child: Text(
                          value['NAME'].toString(),
                          style: AppTheme.a16400
                              .copyWith(color: value['NAME'].toString() == '선택해주세요' ? AppTheme.aBCBCBC : AppTheme.a6c6c6c),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedGubun.value == '스크랩' ?
                      controller.scLocList.map((e) {
                        if(e['NAME'] == value) {
                          controller.selectedScLocMap['RACK_BARCODE'] = e['RACK_BARCODE'];
                          controller.selectedScLocMap['NAME'] = e['NAME'];
                        }
                      }).toList() :
                      controller.scLocList.map((e) {
                        if(e['NAME'] == value) {
                          controller.selectedScLocMap['RACK_BARCODE'] = e['RACK_BARCODE'];
                          controller.selectedScLocMap['NAME'] = e['NAME'];
                        }
                      }).toList();
                      Get.log('${ controller.selectedScLocMap} 선택!!!!');
                    }),
              ),
            ],
          ),
        ),
        SizedBox(width: 12,),
        Expanded(
          child: Container(
                decoration: BoxDecoration(
                    border: const Border(
                      bottom: BorderSide(color: AppTheme.gray_gray_200),
                    )),
                padding: const EdgeInsets.only(right: 12, top: 12, bottom: 12, left: 12),
                child: Text('자동입력될거임', style: AppTheme.a16400
                    .copyWith(color: AppTheme.a6c6c6c),),
              )
        ),
      ],
    );
  }


  Widget _bottomButton(BuildContext context) {
    return Obx(() => BottomAppBar(
        color: AppTheme.white,
        surfaceTintColor: AppTheme.white,
        child: (() {
          return TextButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  backgroundColor: controller.isLabelBtn.value ?
                  MaterialStateProperty.all<Color>(AppTheme.a1f1f1f) :
                  MaterialStateProperty.all<Color>(AppTheme.light_cancel),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(0))),
              onPressed: controller.isLabelBtn.value ? () async {


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
                      '라벨발행',
                      style: AppTheme.bodyBody2.copyWith(
                        color: const Color(0xfffbfbfb),
                      ),
                    )),
              ));
        })()
    ));
  }


}
