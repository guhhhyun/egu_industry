import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/pages/dolbal/facility_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ModalUserListWidget extends StatelessWidget {
  ModalUserListWidget({Key? key}) : super(key: key);
  FacilityController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40, bottom: 24, left: 16, right: 16),
        height: 500,
        child: CustomScrollView(
          slivers: [
            _title(),
            _listArea()
          ],
        ),
    );
  }

  Widget _title() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(left: 12, bottom: 24),
          child: Text('작업자 선택', style: AppTheme.titleHeadline.copyWith(color: AppTheme.black),
          )),
    );
  }

  Widget _listArea() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _listItem(index: index, context: context);
        }, childCount: controller.engineerList.length));
  }
  Widget _listItem({required BuildContext context,required int index}) {

    return Obx(() => TextButton(
      onPressed: () {
        controller.isEngineerSelectedList[index] == false ? controller.isEngineerSelectedList[index] = true
            : controller.isEngineerSelectedList[index] = false;
        controller.isEngineerSelectedList[index] == true
            ? controller.engineerSelectedList.add(controller.engineerList[index])
            : controller.engineerSelectedList.remove(controller.engineerList[index]);

          controller.selectedEnginner.value = controller.engineerSelectedList.toString();


      },
      child: Container(
          decoration: BoxDecoration(
              border: const Border(
                bottom:
                BorderSide(color: AppTheme.light_ui_08),
              )),
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(right: 12, top: 16, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  controller.isEngineerSelectedList[index] == false ?
                  Icon(Icons.check_circle, color: AppTheme.gray_c_gray_300) : Icon(Icons.check_circle, color: AppTheme.black),
                  SizedBox(width: 8,),
                  Text('${controller.engineerList[index]}', style: AppTheme.bodyBody2.copyWith(color: AppTheme.gray_gray_400, fontSize: 17),),
                ],
              ),
              Text('dldldldl', style: AppTheme.bodyBody2.copyWith(color: AppTheme.gray_gray_400, fontSize: 17))
            ],
          )),
    ));
  }
}
