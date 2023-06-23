import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/common_appbar_widget.dart';

import 'package:egu_industry/app/pages/dolbal/facility_controller.dart';
import 'package:egu_industry/app/pages/facilityFirst/facility_first_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

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
    controller.errorTime.value = DateFormat('yyyy.MM.dd HH:mm').format(DateTime.now());
    controller.errorTime2.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return SliverToBoxAdapter(
        child: Obx(() => Container(
          color: AppTheme.white,
          padding: EdgeInsets.only(left: 18, right: 18, top: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _basicContainerItem(context, '의뢰번호', '자동생성'),
              SizedBox(height: 30,),
              _basicContainerItem(context, '장애일시', '${controller.errorTime.value}'),
              SizedBox(height: 30,),
              _inspectionGubunItem(context),
              SizedBox(height: 30,),
             _facilityChoiceItem(context),
              SizedBox(height: 30,),
              controller.selectedMach.value == '선택해주세요' ? _anotherFacilityItem() : Container(),
              SizedBox(height: 30,),
              _engineTeamItem(context),
              SizedBox(height: 30,),
              _titleTextFieldItem(),
              SizedBox(height: 30,),
              _contentTextFieldItem(),
              SizedBox(height: 30,),
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
  Widget _basicContainerItem(BuildContext context, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: AppTheme.titleSubhead4
                .copyWith(color: AppTheme.light_text_primary)),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 14, bottom: 14),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppTheme.gray_gray_200))
          ),
          child: Text(content
            , style: AppTheme.bodyBody1.copyWith(color: AppTheme.light_placeholder),),
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
            style: AppTheme.titleSubhead4
                .copyWith(color: AppTheme.light_text_primary)),
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
                          style: AppTheme.bodyBody1
                              .copyWith(color: value == '선택해주세요' ? AppTheme.light_placeholder : AppTheme.black),
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
                          style: AppTheme.bodyBody1
                              .copyWith(color: value == '선택해주세요' ? AppTheme.light_placeholder : AppTheme.black),
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
            style: AppTheme.titleSubhead4
                .copyWith(color: AppTheme.light_text_primary)),
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
                          style: AppTheme.bodyBody1
                              .copyWith(color: value == '선택해주세요' ? AppTheme.light_placeholder : AppTheme.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedMachIndex.value = controller.machList.indexOf(value);
                      controller.selectedMachCd.value = controller.machCdList[controller.selectedMachIndex.value];
                      controller.selectedMach.value = value!;

                      Get.log('$value 선택!!!!');
                      // Get.log('${HomeApi.to.BIZ_DATA('L_USER_001')}');
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
            style: AppTheme.titleSubhead4
                .copyWith(color: AppTheme.light_text_primary)),
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
           // maxLines: 5,
            controller: controller.textFacilityController,
            textInputAction: TextInputAction.search,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              fillColor: Colors.white,
              filled: true,
              hintText: '설비가 없는경우 직접 입력해주세요',
              hintStyle: AppTheme.bodyBody1.copyWith(color: AppTheme.light_placeholder),
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
                      style: AppTheme.titleSubhead4
                          .copyWith(color: AppTheme.light_text_primary)),
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
                              style: AppTheme.bodyBody1
                                  .copyWith(color: value == '선택해주세요' ? AppTheme.light_placeholder : AppTheme.black),
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
                      style: AppTheme.titleSubhead4
                          .copyWith(color: AppTheme.light_text_primary)),
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
                              style: AppTheme.bodyBody1
                                  .copyWith(color: value == '선택해주세요' ? AppTheme.light_placeholder : AppTheme.black),
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
            style: AppTheme.titleSubhead4
                .copyWith(color: AppTheme.light_text_primary)),
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
              hintStyle: AppTheme.bodyBody1.copyWith(color: AppTheme.light_placeholder),
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
            style: AppTheme.titleSubhead4
                .copyWith(color: AppTheme.light_text_primary)),
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
              hintStyle: AppTheme.bodyBody1.copyWith(color: AppTheme.light_placeholder),
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
        MaterialStateProperty.all<Color>(AppTheme.light_ui_03),
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
        } else if (resultFile2 == null) {
          resultFile2 = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['jpg', 'pdf', 'png'],
          );
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
          style: AppTheme.titleSubhead4
              .copyWith(color: AppTheme.light_text_primary),
        ),
        const SizedBox(
          height: AppTheme.spacing_xxs_4,
        ),
        Text(
          '의뢰내용과 관련된 사진을 올려주세요',
          style: AppTheme.bodyBody1
              .copyWith(color: AppTheme.light_text_tertiary),
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

/*/// 파일 저장쿼리 넘기기
  void _submmit() async {
    try {
      if (formKey.currentState?.validate() == true) {
        formKey.currentState?.save();

        var queryParameters = <String, dynamic>{};
      //  queryParameters['inquiryCd'] = selectCategory.code;
      //  queryParameters['title'] = titleTextController.text;
      //  queryParameters['content'] = contentTextController.text;

        const maxFileSize = 1024 * 1024 * 10;

        if (resultFile1 != null) {
          var path = resultFile1!.files.first.path ?? '';

          if (maxFileSize < resultFile1!.files.first.size) {
            Utils.showToast(msg: '10M 이하의 파일만 업로드 가능합니다.');
            return;
          }

          if (path != '') {
            queryParameters['ex_file0'] = await MultipartFile.fromFile(path);
          }
        }
        if (resultFile2 != null) {
          var path = resultFile2!.files.first.path ?? '';

          if (maxFileSize < resultFile2!.files.first.size) {
            Utils.showToast(msg: '10M 이하의 파일만 업로드 가능합니다.');
            return;
          }

          if (path != '') {
            queryParameters['ex_file1'] = await MultipartFile.fromFile(path);
          }
        }
        var formData = FormData.fromMap(queryParameters);

        bLoading.value = true;

        var retVal = await HomeApi.to.reqInsertInquiry(formData: formData);

        if (retVal.success) {
          Get.back(result: true);
          Utils.showToast(msg: '등록이 완료되었습니다.');
        }
      } else {
        Utils.showToast(msg: '필수 입력값이 필요합니다.');
      }
    } catch (err) {
      Get.log('_submmit err = ${err.toString()} ', isError: true);
    } finally {
      bLoading.value = false;
    }
  }*/


}

