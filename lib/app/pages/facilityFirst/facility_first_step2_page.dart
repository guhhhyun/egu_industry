import 'package:dio/dio.dart';
import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';
import 'package:egu_industry/app/common/dialog_widget.dart';
import 'package:egu_industry/app/common/utils.dart';
import 'package:egu_industry/app/net/home_api.dart';

import 'package:egu_industry/app/pages/facilityFirst/facility_first_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
as picker;

class FacilityFirstStep2Page extends StatefulWidget {
  const FacilityFirstStep2Page({Key? key}) : super(key: key);

  @override
  State<FacilityFirstStep2Page> createState() => _FacilityFirstStep2PageState();
}

class _FacilityFirstStep2PageState extends State<FacilityFirstStep2Page> {
  FacilityFirstController controller = Get.find();
  final formKey = GlobalKey<FormState>();
  FilePickerResult? resultFile1 = null;
  FilePickerResult? resultFile2 = null;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CommonAppbarWidget(title: '설비/안전 점검 - 의뢰내역 등록', isLogo: false, isFirstPage: false ),
            _bodyArea(context),
            //_streamBuilder()

          ],
        ),
      ),
      bottomNavigationBar: _bottomButton(context), // 점검의뢰 등록
    );
  }

  Widget _bodyArea(BuildContext context) {
    controller.errorTime.value = DateFormat('yyyy.MM.dd HH:mm').format(DateTime.now());
    controller.errorTime2.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return SliverToBoxAdapter(
        child: Obx(() => Container(
          color: AppTheme.white,
          padding: EdgeInsets.only(left: 18, right: 18, top: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _basicContainerItem(context, '의뢰번호', '자동생성', 1),
              SizedBox(height: 45,),
              _basicContainerItem(context, '장애일시', '${controller.errorTime.value}', 2),
              controller.isErrorDateChoice.value == true ?
              Column(
                children: [
                  SizedBox(height: 16,),
                  _errorDateSelect(),
                ],
              ) : Container(),
              SizedBox(height: 45,),
              _inspectionGubunItem(context),
              controller.selectedIns.value == '안전점검' ? Container() :
              Column(
                children: [
                  SizedBox(height: 45,),
                  _facilityChoiceItem(context),
                ],
              ),
              SizedBox(height: 45,),
              controller.selectedMach.value == '선택해주세요' ? _anotherFacilityItem() : Container(),
              SizedBox(height: 45,),
              _engineTeamItem(context),
              SizedBox(height: 45,),
              _titleTextFieldItem(),
              SizedBox(height: 45,),
              _contentTextFieldItem(),
              SizedBox(height: 45,),
              _fileArea()
              // _topDataItem(),
              //_inputArea(context),
              // _partChoiceBody()
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

  /// 의뢰번호, 장애일시
  Widget _basicContainerItem(BuildContext context, String title, String content, int flag) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: AppTheme.a15700
                .copyWith(color: AppTheme.black)),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: flag == 1 ? 14 : 0, bottom: flag == 1 ? 14 : 0),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppTheme.gray_gray_200))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(content
                , style: AppTheme.a16400.copyWith(color: flag == 1 ? AppTheme.aBCBCBC : AppTheme.a6c6c6c),),
              flag == 2 ?
              TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                ),
                onPressed: () {
                  controller.isErrorDateChoice.value = true;
                },
                child: Container(
                  padding: EdgeInsets.only(left: 6, right: 6, top: 4, bottom: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.red_red_100,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text('수정', style: AppTheme.bodyBody1.copyWith(color: AppTheme.black)),
                ),
              ) : Container()
            ],
          ),
        )
      ],
    );
  }

  /// 점검/의뢰 구분
  Widget _inspectionGubunItem(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('점검/의뢰 구분',
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
                    value: controller.selectedIns.value,
                    //  flag == 3 ? controller.selectedNoReason.value :
                    items: controller.insList.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: AppTheme.a16400
                              .copyWith(color: value == '선택해주세요' ? AppTheme.aBCBCBC : AppTheme.a6c6c6c),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedIns.value = value!;

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
                    border: const Border(
                      bottom: BorderSide(color: AppTheme.gray_gray_200),
                    )),
                padding: const EdgeInsets.only(right: 12),
                child: DropdownButton<String>(
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
                    value: controller.selectedUrgency.value,
                    //  flag == 3 ? controller.selectedNoReason.value :
                    items: controller.urgencyList.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: AppTheme.a16400
                              .copyWith(color: value == '선택해주세요' ? AppTheme.aBCBCBC : AppTheme.a6c6c6c),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedUrgency.value = value!;

                      Get.log('$value 선택!!!!');
                      // Get.log('${HomeApi.to.BIZ_DATA('L_USER_001')}');
                    }),
              ),
            ),
          ],
        )
      ],
    );
  }

  /// 설비
  Widget _facilityChoiceItem(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('설비',
            style: AppTheme.a15700
                .copyWith(color: AppTheme.black)),
        Container(
                height: 50,
                decoration: BoxDecoration(
                    border: const Border(
                      bottom: BorderSide(color: AppTheme.gray_gray_200),
                    )),
                padding: const EdgeInsets.only( right: 12),
                child: DropdownButton<String>(
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
                    value: controller.selectedMach.value,
                    //  flag == 3 ? controller.selectedNoReason.value :
                    items: controller.machList.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: AppTheme.a16400
                              .copyWith(color: value == '선택해주세요' ? AppTheme.aBCBCBC : AppTheme.a6c6c6c),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedMachIndex.value = controller.machList.indexOf(value);
                      controller.selectedMachCd.value = controller.machCdList[controller.selectedMachIndex.value];
                      controller.selectedMach.value = value!;

                      Get.log('$value 선택!!!!');
                       Get.log(controller.selectedMachCd.value);
                    }),
              ),

      ],
    );
  }

  /// 설비 외
  Widget _anotherFacilityItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('설비 외',
            style: AppTheme.a15700
                .copyWith(color: AppTheme.black)),
        SizedBox(height: 4,),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppTheme.gray_gray_200),
            )
            // borderRadius: BorderRadius.circular(5)
          ),
          width: double.infinity,
          child: TextFormField(
            style:  AppTheme.a16400.copyWith(color: AppTheme.a6c6c6c),
           // maxLines: 5,
            controller: controller.textFacilityController,
            textInputAction: TextInputAction.search,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              fillColor: Colors.white,
              filled: true,
              hintText: '설비가 없는경우 직접 입력해주세요',
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

  /// 정비 유형 정비부서
  Widget _engineTeamItem(BuildContext context) {
    return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('정비유형',
                      style: AppTheme.a15700
                          .copyWith(color: AppTheme.black)),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        border: const Border(
                          bottom: BorderSide(color: AppTheme.gray_gray_200),
                        )),
                    padding: const EdgeInsets.only(right: 12),
                    child: DropdownButton<String>(
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
                        value: controller.selectedIrFq.value,
                        //  flag == 3 ? controller.selectedNoReason.value :
                        items: controller.irfgList.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(
                              value,
                              style: AppTheme.a16400
                                  .copyWith(color: value == '선택해주세요' ? AppTheme.aBCBCBC : AppTheme.a6c6c6c),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          controller.selectedIrFq.value = value!;

                          Get.log('$value 선택!!!!');
                          // Get.log('${HomeApi.to.BIZ_DATA('L_USER_001')}');
                        }),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('점검부서',
                      style: AppTheme.a15700
                          .copyWith(color: AppTheme.black)),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        border: const Border(
                          bottom: BorderSide(color: AppTheme.gray_gray_200),
                        )),
                    padding: const EdgeInsets.only(right: 12),
                    child: DropdownButton<String>(
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
                        value: controller.selectedEngineTeam.value,
                        //  flag == 3 ? controller.selectedNoReason.value :
                        items: controller.engineTeamList.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(
                              value,
                              style: AppTheme.a16400
                                  .copyWith(color: value == '선택해주세요' ? AppTheme.aBCBCBC : AppTheme.a6c6c6c),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          controller.selectedEngineTeam.value = value!;

                          Get.log('$value 선택!!!!');
                          // Get.log('${HomeApi.to.BIZ_DATA('L_USER_001')}');
                        }),
                  ),
                ],
              ),
            ),
          ],
        );
  }


  /// 의뢰제목
  Widget _titleTextFieldItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('의뢰제목',
            style: AppTheme.a15700
                .copyWith(color: AppTheme.black)),
        SizedBox(height: 4,),
        Container(
          decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppTheme.gray_gray_200),
              )
            // borderRadius: BorderRadius.circular(5)
          ),
          width: double.infinity,
          child: TextFormField(
            style:  AppTheme.a16400.copyWith(color: AppTheme.a6c6c6c),
            // maxLines: 5,
            maxLength: 30,
            controller: controller.textTitleController,
            textInputAction: TextInputAction.search,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              fillColor: Colors.white,
              filled: true,
              counterText:'',
              hintText: '제목을 입력해주세요',
              hintStyle: AppTheme.a16400.copyWith(color: AppTheme.aBCBCBC),
              border: InputBorder.none,
            ),
            showCursor: true,

            // onChanged: ((value) => controller.submitSearch(value)),
          ),
        ),
        SizedBox(height: 16,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('최대 30글자', style: AppTheme.bodyCaption.copyWith(color: AppTheme.light_text_secondary),
              textAlign: TextAlign.end,),
          ],
        )
      ],
    );
  }

  /// 상세내용
  Widget _contentTextFieldItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('상세내용',
            style: AppTheme.a15700
                .copyWith(color: AppTheme.black)),
        SizedBox(height: 16,),
        Container(
          decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppTheme.gray_gray_200),
              )
            // borderRadius: BorderRadius.circular(5)
          ),
          width: double.infinity,
          child: TextFormField(
            style:  AppTheme.a16400.copyWith(color: AppTheme.a6c6c6c),
            maxLength: 60,
            maxLines: 5,
            controller: controller.textContentController,
            textInputAction: TextInputAction.search,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              counterText:'',
              contentPadding: EdgeInsets.all(0),
              fillColor: Colors.white,
              filled: true,
              hintText: '내용을 입력해주세요',
              hintStyle: AppTheme.a16400.copyWith(color: AppTheme.light_placeholder),
              border: InputBorder.none,
            ),
            showCursor: true,

            // onChanged: ((value) => controller.submitSearch(value)),
          ),
        ),
        SizedBox(height: 16,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('최대 60글자', style: AppTheme.bodyCaption.copyWith(color: AppTheme.light_text_secondary),
              textAlign: TextAlign.end,),
          ],
        )
      ],
    );
  }


  Widget _fileAddBtn() {
    return resultFile1 != null && resultFile2 != null
        ? const SizedBox()
        : TextButton(
      style: ButtonStyle(
        backgroundColor:
        MaterialStateProperty.all<Color>(AppTheme.gray_gray_100),
        padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.all(0)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100))),
      ),
      onPressed: () async {
        Get.log('첨부파일 추가');
        if (resultFile1 == null) {
          resultFile1 = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['jpg', 'pdf', 'png'],
          );
          controller.filePath.value = resultFile1!.files.first.path!;
        } else if (resultFile2 == null) {
          resultFile2 = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['jpg', 'pdf', 'png'],
          );
          controller.filePath2.value = resultFile1!.files.first.path!;
        }

        setState(() {});
      },
      child: SizedBox(
        height: 99,
        width: 99,
        child: Center(
          child: Icon(Icons.picture_in_picture_outlined)/*Image.asset(
            'assets/app/icon_plus_24_2_px.png',
            width: 24,
            height: 24,
          ),*/
        ),
      ),
    );
  }

  Widget _fileLlistArea() {
    return Row(
      children: [
        resultFile1 == null
            ? const SizedBox()
            : _fileContainer(
          title: resultFile1!.files.first.name,
          firstSecondFlag: 1,
          fileExtension: resultFile1!.files.first.extension!,
        ),
        const SizedBox(
          width: AppTheme.spacing_m_16,
        ),
        resultFile2 == null
            ? const SizedBox()
            : _fileContainer(
          title: resultFile2!.files.first.name,
          firstSecondFlag: 2,
          fileExtension: resultFile2!.files.first.extension!,
        ),
      ],
    );
  }

  Widget _fileArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '사진(최대 4장)',
          style: AppTheme.a15700
              .copyWith(color: AppTheme.light_text_primary),
        ),
        const SizedBox(
          height: AppTheme.spacing_xxs_4,
        ),
        Text(
          '의뢰내용과 관련된 사진을 올려주세요',
          style: AppTheme.a16400
              .copyWith(color: AppTheme.a969696),
        ),
        const SizedBox(
          height: AppTheme.spacing_m_16,
        ),
        Row(
          children: [
            _fileAddBtn(),
            const SizedBox(
              width: AppTheme.spacing_m_16,
            ),
            _fileLlistArea(),
          ],
        ),
        const SizedBox(
          height: 100,
        ),

      ],
    );
  }

  Widget _noFileContainer() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing_s_12),
      decoration:
      BoxDecoration(border: Border.all(color: AppTheme.light_ui_03)),
      height: 99,
      width: 99,
    );
  }

  Widget _fileContainer({
    required String title,
    required int firstSecondFlag,
    required String fileExtension,
  }) {
    var imageUrl = 'assets/app/pdfImage.png';

    if (fileExtension == 'pdf') {
      imageUrl = 'assets/app/pdfImage.png';
    } else {
      imageUrl = 'assets/app/pngImage.png';
    }

    return Stack(
      children: [
        Container(
            padding: const EdgeInsets.all(AppTheme.spacing_s_12),
            decoration:
            BoxDecoration(
                border: Border.all(color: AppTheme.light_ui_03),
              borderRadius: BorderRadius.circular(100)
            ),
            height: 99,
            width: 99,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  imageUrl,
                  width: 36,
                  height: 36,
                ),
                const SizedBox(
                  height: AppTheme.spacing_xxs_4,
                ),
                Text(
                  title,
                  style: AppTheme.bodyCaption
                      .copyWith(color: AppTheme.light_text_primary),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              ],
            )),
        Positioned(
            right: -7,
            top: -5,
            child: IconButton(
              onPressed: () {
                setState(() {
                  if (firstSecondFlag == 1) {
                    resultFile1 = null;
                  } else {
                    resultFile2 = null;
                  }
                });
              },
              icon: Container(
                padding: const EdgeInsets.all(AppTheme.spacing_xxs_4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppTheme.light_danger,
                ),
                child: SvgPicture.asset(
                  'assets/app/minus.svg',
                  width: 12,
                  height: 12,
                  color: AppTheme.light_ui_background,
                ),
              ),
            )),
      ],
    );
  }

  Widget _bottomButton(BuildContext context) {
    return Obx(() => BottomAppBar(
        color: AppTheme.white,
        surfaceTintColor: AppTheme.white,
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: TextButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        backgroundColor:

                        MaterialStateProperty.all<Color>(AppTheme.aE2E2E2),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(0))),
                    onPressed: () async {
                      Get.back();
                     //  Get.toNamed(Routes.FACILITY);
                    },
                    child: Container(
                      height: 56,
                      // width: MediaQuery.of(context).size.width,
                      child: Center(
                          child: Text(
                            '목록',
                            style: AppTheme.bodyBody2.copyWith(
                              color: AppTheme.a6c6c6c,
                            ),
                          )),
                    )),
              )
            ),
            SizedBox(width: 12,),
            Expanded(
              child: Container(
                child: (() {
                  if(controller.errorTime.value != '' && controller.selectedIns.value != '선택해주세요'
                      && controller.selectedUrgency.value != '선택해주세요'
                      && (controller.selectedMach.value != '선택해주세요' || controller.textFacilityController.text != '')
                      && controller.selectedIrFq.value != '선택해주세요' && controller.selectedEngineTeam.value != '선택해주세요'
                      && controller.textTitleController.text != '' && controller.textContentController.text != '') {
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
                        controller.filePathList.clear();
                        controller.cdConvert();
                        controller.saveButton();
                        _submmit(); /// 삭제 할 수 있음 ----!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                        SchedulerBinding.instance!.addPostFrameCallback((_) {
                           Get.dialog(CommonDialogWidget(contentText: '저장되었습니다', flag: 1, pageFlag: 1,));
                        });
                      } : null,
                      child: Container(
                        height: 56,
                       // width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: Text(
                              '저장',
                              style: AppTheme.bodyBody2.copyWith(
                                color: AppTheme.white,
                              ),
                            )),
                      ));
                })(),
              ),
            ),
          ],
        )
    ));
  }

/// 파일 저장쿼리 넘기기
  void _submmit() async {
    try {
      if (formKey.currentState?.validate() == true) {
        formKey.currentState?.save();


        const maxFileSize = 1024 * 1024 * 10;

        if (resultFile1 != null) {
          var path = resultFile1!.files.first.path ?? '';

          if (maxFileSize < resultFile1!.files.first.size) {
          //  Utils.showToast(msg: '10M 이하의 파일만 업로드 가능합니다.');
            return;
          }
          if (path != '') {
            controller.filePathList.add(path);
        //  queryParameters['ex_file1'] = await MultipartFile.fromFile(path);
          }
        }
        if (resultFile2 != null) {
          var path = resultFile2!.files.first.path ?? '';

          if (maxFileSize < resultFile2!.files.first.size) {
           // Utils.showToast(msg: '10M 이하의 파일만 업로드 가능합니다.');
            return;
          }

          if (path != '') {
            controller.filePathList.add(path);
           // queryParameters['ex_file1'] = await MultipartFile.fromFile(path);
          }
        }

        Map<String, dynamic> path = {
          'PATH': controller.filePathList
        };

        var retVal = await HomeApi.to.PROC('USP_MBS0200_S01', {'p_WORK_TYPE':'FILE_N', '@p_IR_CODE':controller.irFileCode.value,
          '@p_FILE_NAME':resultFile2!.files.first.name, '@p_SVR_FILE_PATH': path, '@p_SEQ':'0'});

       /* if (retVal.success) {
          Get.back(result: true);
          Utils.showToast(msg: '등록이 완료되었습니다.');
        }
      } else {
        Utils.showToast(msg: '필수 입력값이 필요합니다.');
      }*/
      }
    } catch (err) {
      Get.log('_submmit err = ${err.toString()} ', isError: true);
    } finally {

    }
  }

  Widget _errorDateSelect() {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              ),
              onPressed: () async{
                var datePicked = await DatePicker.showDateTimePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2018, 3, 5),
                    maxTime: DateTime.now(), onChanged: (date) {
                      print('change $date');
                    }, onConfirm: (date) {
                      controller.isErrorDateChoice.value = false;
                      var firstIndex = date
                          .toString().lastIndexOf(':');
                      var lastIndex = date
                          .toString().length;
                      controller.errorTime.value = date.toString().replaceRange(firstIndex, lastIndex, '');
                    }, currentTime: DateTime.now(), locale: LocaleType.ko);

                Get.log('${datePicked}');
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppTheme.gray_gray_200))
                ),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('날짜를 선택해주세요', style: AppTheme.bodyBody1
                        .copyWith(color: AppTheme.black),),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }


}

