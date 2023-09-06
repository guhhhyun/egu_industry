import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/common/dialog_widget.dart';
import 'package:egu_industry/app/pages/packagingInspec/packaging_inspec_controller.dart';
import 'package:egu_industry/app/pages/productLocation/product_location_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class PackagingInspecPage extends StatelessWidget {
  PackagingInspecPage({super.key});

  PackagingInspecController controller = Get.find();
  final ScrollController myScrollWorks = ScrollController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CommonAppbarWidget(title: '\제품포장 검수', isLogo: false, isFirstPage: true ),
            _topAreaTest(),
            // _topArea(),
            _bodyArea(),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 16,),
                  Container(
                    height: 8,
                    color: AppTheme.af3f3f3,
                  ),
                ],
              ),
            ),
            _weightData(),
            _boundary(),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 16,),
                  Container(
                    height: 8,
                    color: AppTheme.af3f3f3,
                  ),
                  const SizedBox(height: 16,),
                ],
              ),
            ),
            Obx(() => controller.inspecDetailList.isNotEmpty ?
            _packagingSpec() : SliverToBoxAdapter(child: Container()))

          //  _locationItem()
          ],
        ),
      ),
      bottomNavigationBar: _bottomButton(context), //  등록
    );
  }

  Widget _topAreaTest() {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 12, top: 24),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.ae2e2e2),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextFormField(
                    style:  AppTheme.a16400.copyWith(color: AppTheme.a6c6c6c),
                    // maxLines: 5,
                    controller: controller.textController,
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.search,
                    onFieldSubmitted: (value) {
                      controller.checkButton();
                      controller.checkButton2();
                      controller.checkButton3();
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: () {
                            Get.log('조회 돋보기 클릭!');
                            controller.checkButton();
                            controller.checkButton2();
                            controller.checkButton3();
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
          Container(
            padding: const EdgeInsets.only( right: 20, top: 24),
            child: InkWell(
                onTap: () async {
                  String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                      '#ff6666', '취소', false, ScanMode.BARCODE);
                  controller.textController.text = barcodeScanRes;
                  if(controller.textController.text != '-1') {
                    controller.checkButton();
                    controller.checkButton2();
                    controller.checkButton3();
                  }else {
                    controller.textController.text = '바코드를 재스캔해주세요';
                  }
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                    child: const Icon(Icons.camera_alt_outlined, size: 30,))
            ),
          )
        ],
      ),
    );
  }

  Widget _weightData() {
    return Obx(() => SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(left: 24, right: 35, top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text('실중량: ', style: AppTheme.a16400.copyWith(color: AppTheme.black),),
                Text('${controller.realWeight.value.toStringAsFixed(2)}', style: AppTheme.a16600.copyWith(color: AppTheme.black))
              ],
            ),
            Row(
              children: [
                Text('총중량: ', style: AppTheme.a16400.copyWith(color: AppTheme.black),),
                Text('${controller.totalWeight.value.toStringAsFixed(2)}', style: AppTheme.a16600.copyWith(color: AppTheme.black))
              ],
            )
          ],
        ),
      ),
    ));
  }

  Widget _boundary() {
    return Obx(() => SliverToBoxAdapter(
        child: controller.productDetailList.isNotEmpty ? Container(
            height: 300,
            child: PrimaryScrollController(
              controller: myScrollWorks,
              child: CupertinoScrollbar(
                thumbVisibility: true,
                scrollbarOrientation: ScrollbarOrientation.right,
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    controller.productDetailList.isNotEmpty ?
                    _listArea() : SliverToBoxAdapter( child: Container(),)
                  ],
                ),
              ),)) : Container()
    ));
  }


  Widget _listArea() {
    return Obx(() => SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _listItem(index: index, context: context);
        }, childCount: controller.productDetailRealList.length)));
  }


  Widget _listItem({required BuildContext context, required int index}) {

    return Obx(() => Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 24, bottom: 4, top: 12),
              child: Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                       // border: Border.all(color: AppTheme.black),
                        color: AppTheme.black
                      ),
                      width: 25,
                      height: 25,
                      child: Center(
                      child: Text('${index + 1}', style: AppTheme.a15800.copyWith(color: AppTheme.white),)))
                ],
              ),
            ),
            Expanded(
                child: InkWell(
                  onTap: () {
                    Get.log('index: $index');
                    controller.isProductSelectedList[index] == false ? controller.isProductSelectedList[index] = true
                        : controller.isProductSelectedList[index] = false;
                    controller.isProductSelectedList[index] == true
                        ? controller.productSelectedList.add(controller.productDetailRealList[index])
                        : controller.productSelectedList.remove(controller.productDetailRealList[index]);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 12, right: 35, bottom: 4, top: 12),
                    padding: EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: controller.isProductSelectedList[index] == false ? Border.all(color: AppTheme.aE2E2E2) :  Border.all(color: AppTheme.black, width: 2),
                        color: AppTheme.white,

                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('제품번호',
                                style: AppTheme.a14400
                                    .copyWith(color: AppTheme.a959595)),
                            Text(controller.productDetailRealList.isNotEmpty ? '${controller.productDetailRealList[index]['BARCODE']}' : '',
                                style: AppTheme.a14400
                                    .copyWith(color: AppTheme.black)),
                          ],
                        ),
                        SizedBox(height: 4,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('LOT NO',
                                style: AppTheme.a14400
                                    .copyWith(color: AppTheme.a959595)),
                            Text(controller.productDetailRealList.isNotEmpty ? '${controller.productDetailRealList[index]['LOT_NO']}' : '',
                                style: AppTheme.a14400
                                    .copyWith(color: AppTheme.black)),
                          ],
                        ),
                        SizedBox(height: 4,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('규격: ',
                                style: AppTheme.a12700
                                    .copyWith(color: AppTheme.a959595)),
                            SizedBox(width: 4,),
                            Text(controller.productDetailRealList.isNotEmpty ? controller.productDetailRealList[index]['SPEC'] != null ? '${controller.productDetailRealList[index]['SPEC']}' : '' : '',
                                style: AppTheme.a12700
                                    .copyWith(color: AppTheme.black)),
                            SizedBox(width: 8,),
                            Text('실중량: ',
                                style: AppTheme.a12700
                                    .copyWith(color: AppTheme.a959595)),
                            SizedBox(width: 4,),
                            Text(controller.productDetailRealList.isNotEmpty ? controller.productDetailRealList[index]['REAL_WEIGHT'] != null ? '${controller.productDetailRealList[index]['REAL_WEIGHT']}' : '' : '',
                                style: AppTheme.a12700
                                    .copyWith(color: AppTheme.black)),
                            const SizedBox(width: 8,),
                            Text('지관: ',
                                style: AppTheme.a12700
                                    .copyWith(color: AppTheme.a959595)),
                            const SizedBox(width: 4,),
                            Text(controller.productDetailRealList.isNotEmpty ? controller.productDetailRealList[index]['JIGWAN'] != null ? '${controller.productDetailRealList[index]['JIGWAN']}' : '' : '',
                                style: AppTheme.a12700
                                    .copyWith(color: AppTheme.black)),
                            const SizedBox(width: 8,),
                            Text('총중량: ',
                                style: AppTheme.a12700
                                    .copyWith(color: AppTheme.a959595)),
                            const SizedBox(width: 4,),
                            Text(controller.productDetailRealList.isNotEmpty ? controller.productDetailRealList[index]['ALL_WEIGHT'] != null ? '${controller.productDetailRealList[index]['ALL_WEIGHT']}' : '' : '',
                                style: AppTheme.a12700
                                    .copyWith(color: AppTheme.black)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ),
          ],
        ),
    );
  }


  Widget _bodyArea() {
    return SliverToBoxAdapter(
      child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              border: Border.all(color: AppTheme.black),
              borderRadius: BorderRadius.circular(10),
              color: AppTheme.white
          ),
          child: Obx(() =>Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('PNO:  ',
                          style: AppTheme.a16400
                              .copyWith(color: AppTheme.a959595)),
                      Text(controller.productList.isNotEmpty ? '${controller.productList[0]['PACK_NO']}' : '',
                          style: AppTheme.a16400
                              .copyWith(color: AppTheme.black)),
                    ],
                  ),
                  Row(
                    children: [
                      Text('SPEC:  ',
                          style: AppTheme.a16400
                              .copyWith(color: AppTheme.a959595)),
                      Text(controller.productList.isNotEmpty ?  controller.productList[0]['SPEC'] != '' ? '${controller.productList[0]['SPEC']}' : '데이터x' : '',
                          style: AppTheme.a16400
                              .copyWith(color: AppTheme.black)),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('품명:  ',
                          style: AppTheme.a16400
                              .copyWith(color: AppTheme.a959595)),
                      Text(controller.productList.isNotEmpty ?  '${controller.productList[0]['CMP_NM']}' : '',
                          style: AppTheme.a16400
                              .copyWith(color: AppTheme.black)),
                    ],
                  ),
                  Row(
                    children: [
                      Text('회사명:  ',
                          style: AppTheme.a16400
                              .copyWith(color: AppTheme.a959595)),
                      Text(controller.productList.isNotEmpty ?  '${controller.productList[0]['CST_NM']}' : '', // CST_NM 인데 ''로 되어있음
                          style: AppTheme.a16400
                              .copyWith(color: AppTheme.black)),
                    ],
                  ),
                ],
              ),
            ],
          ),)
      ),
    );
  }

  Widget _packagingSpec() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 12, bottom: 80),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('포장검수', style: AppTheme.a18700.copyWith(color: AppTheme.black),)
              ],
            ),
            const SizedBox(height: 24,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('기계포장: ',
                        style: AppTheme.a16400
                            .copyWith(color: AppTheme.a959595)),
                    Text(controller.inspecDetailList[0]['MACH'] == 'Y' ? 'O' : 'X',
                        style: AppTheme.a16400
                            .copyWith(color: AppTheme.black)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('띠밴딩: ',
                        style: AppTheme.a16400
                            .copyWith(color: AppTheme.a959595)),
                    Text(controller.inspecDetailList[0]['BAND'] == 'Y' ? 'O' : 'X',
                        style: AppTheme.a16400
                            .copyWith(color: AppTheme.black)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('고임목: ',
                        style: AppTheme.a16400
                            .copyWith(color: AppTheme.a959595)),
                    Text(controller.inspecDetailList[0]['CHOCK'] == 'Y' ? 'O' : 'X',
                        style: AppTheme.a16400
                            .copyWith(color: AppTheme.black)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('간지: ',
                        style: AppTheme.a16400
                            .copyWith(color: AppTheme.a959595)),
                    Text(controller.inspecDetailList[0]['GANZ'] == 'Y' ? 'O' : 'X',
                        style: AppTheme.a16400
                            .copyWith(color: AppTheme.black)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('감김방향: ',
                        style: AppTheme.a16400
                            .copyWith(color: AppTheme.a959595)),
                    Text(controller.inspecDetailList[0]['DIRECTION'] == 'Y' ? 'O' : 'X',
                        style: AppTheme.a16400
                            .copyWith(color: AppTheme.black)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('비고사항: ',
                    style: AppTheme.a16400
                        .copyWith(color: AppTheme.a959595)),
                Text('${controller.inspecDetailList[0]['REMARK']}',
                    style: AppTheme.a16400
                        .copyWith(color: AppTheme.black)),
              ],
            ),
          ],
        ),
      ),
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
                  backgroundColor: controller.productSelectedList.isNotEmpty ?
                  MaterialStateProperty.all<Color>(AppTheme.a1f1f1f) :
                  MaterialStateProperty.all<Color>(AppTheme.light_cancel),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(0))),
              onPressed: controller.productSelectedList.isNotEmpty ? () {
                controller.saveButton();
                Get.log('검수완료 클릭');
                SchedulerBinding.instance!.addPostFrameCallback((_) {
                  Get.dialog(
                      CommonDialogWidget(contentText: '저장되었습니다', flag: 2, pageFlag: 6,)
                  );
                  controller.checkButton();
                  controller.checkButton2();
                  controller.checkButton3();
                });
              } : null,
              child: SizedBox(
                height: 56,
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: Text(
                      '검수완료',
                      style: AppTheme.bodyBody2.copyWith(
                        color: const Color(0xfffbfbfb),
                      ),
                    )),
              ));
        })()
    ));
  }
}
