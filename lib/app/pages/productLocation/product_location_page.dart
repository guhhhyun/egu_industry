import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/common/dialog_widget.dart';
import 'package:egu_industry/app/pages/productLocation/product_location_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class ProductLocationPage extends StatelessWidget {
  ProductLocationPage({super.key});

  ProductLocationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: CustomScrollView(
        slivers: [
          CommonAppbarWidget(title: '제품 위치이동', isLogo: false, isFirstPage: true ),
          _topArea(),
          _bodyArea(),
          _locationItem()

        ],
      ),
      bottomNavigationBar: _bottomButton(context), //  등록
    );
  }

  Widget _topArea() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
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
                    onTap: () {
                      Get.log('조회 돋보기 클릭!');
                      controller.checkButton();
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
      ),
    );
  }

  Widget _bodyArea() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
            border: Border.all(color: AppTheme.ae2e2e2),
            borderRadius: BorderRadius.circular(10),
            color: AppTheme.white
        ),
        child: Column(
          children: [
            _bodyItem('BC No.', controller.textController.text),
            const SizedBox(height: 20,),
            _bodyItem('거래처', 'aaaaaaaa'),
            const SizedBox(height: 20,),
            _bodyItem('품종', 'aaaaaaaaaa'),
            const SizedBox(height: 20,),
            _bodyItem('R/P', 'ccccccccc'),
            const SizedBox(height: 20,),
            _bodyItem('질별', 'dddddddddddd'),
            const SizedBox(height: 20,),
            _bodyItem('두께', 'eeeeeeeeee'),
            const SizedBox(height: 20,),
            _bodyItem('폭', 'ff'),
            const SizedBox(height: 20,),
            _bodyItem('합불', 'gggggggg'),
            const SizedBox(height: 20,),
            _bodyItem('위치', 'awewewe'),
            const SizedBox(height: 20,),
            _bodyItem('무게', 'qrqrqrq'),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

  Widget _bodyItem(String title, String content) {
    return Row(
      children: [
        Container(
          width: 103,
          padding: const EdgeInsets.only(top: 12, bottom: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppTheme.af7f7f7
          ),
          child: Center(child: Text(title, style: AppTheme.a16600.copyWith(color: AppTheme.black),)),
        ),
        const SizedBox(width: 22,),
        Text(content, style: AppTheme.a16400.copyWith(color: AppTheme.black),)
      ],
    );
  }

  Widget _locationItem() {
    return SliverToBoxAdapter(
      child: Obx(() => Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 50),
          // padding: EdgeInsets.only(left: 28, top: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('이동위치',
                  style: AppTheme.a15700
                      .copyWith(color: AppTheme.black)),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
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
                          value: controller.selectedLocationMap['FKF_NM'],
                          //  flag == 3 ? controller.selectedNoReason.value :
                          items: controller.locationList.map((value) {
                            return DropdownMenuItem<String>(
                              value: value['FKF_NM'],
                              child: Text(
                                value['FKF_NM'],
                                style: AppTheme.a16400
                                    .copyWith(color: value['FKF_NM'] == '선택해주세요' ? AppTheme.aBCBCBC : AppTheme.a6c6c6c),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            controller.locationList.map((e) {
                              if(e['FKF_NM'] == value) {
                                controller.selectedLocationMap['FKF_NO'] = e['FKF_NO'];
                                controller.selectedLocationMap['FKF_NM'] = e['FKF_NM'];
                              }

                              //  Get.log('${ controller.selectedLocationMap} 선택!!!!');
                            }).toList();
                            Get.log('${ controller.selectedLocationMap} 선택!!!!');
                          }),
                    ),
                  ),
                ],
              ),
            ],
          )
      )),
    );
  }
  Widget _bottomButton(BuildContext context) {
    return Obx(() => BottomAppBar(
        color: AppTheme.white,
        surfaceTintColor: AppTheme.white,
        child: (() {
          if(controller.selectedLocationMap['FKF_NM'] != '선택해주세요') {
            controller.isButton.value = true;
          }else {
            controller.isButton.value = false;
          }
          return TextButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  backgroundColor: controller.isButton.value ?
                  MaterialStateProperty.all<Color>(AppTheme.a1f1f1f) :
                  MaterialStateProperty.all<Color>(AppTheme.light_cancel),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(0))),
              onPressed: controller.isButton.value ? () {
                controller.saveButton();
                SchedulerBinding.instance!.addPostFrameCallback((_) {
                  Get.dialog(
                      CommonDialogWidget(contentText: '저장되었습니다', flag: 2,)
                  );
                });
              } : null,
              child: SizedBox(
                height: 56,
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: Text(
                      '이동 저장',
                      style: AppTheme.bodyBody2.copyWith(
                        color: const Color(0xfffbfbfb),
                      ),
                    )),
              ));
        })()
    ));
  }
}
