import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/pages/dolbal/facility_page.dart';
import 'package:egu_industry/app/pages/facilityFirst/facility_first_step1_page.dart';
import 'package:egu_industry/app/pages/home/home_page.dart';
import 'package:egu_industry/app/pages/inventoryCounting/inventory_counting_page.dart';
import 'package:egu_industry/app/pages/productLocation/product_location_page.dart';
import 'package:egu_industry/app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonDialogWidget extends StatelessWidget {
  String? contentText;
  Widget? contentWidget;
  int? flag;
  int pageFlag;

  Function()? onOk;


  CommonDialogWidget(
      {super.key,
        this.contentText,
        this.contentWidget,
        this.onOk,
        this.flag,
        required this.pageFlag
      });

  Widget _contentText(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12, bottom: 12),
      child: Center(
        child: Text(
          contentText ?? '',
          style: AppTheme.bodyBody2,
          overflow: TextOverflow.ellipsis,
          maxLines: 10,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      scrollable: true,
      content: contentWidget ?? _contentText(context),
      buttonPadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.all(0),
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.only(top: 16, bottom: 12),
      actions: [
        Material(
          child: TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(5)))),
                padding: MaterialStateProperty.all(const EdgeInsets.all(0))),
            // 성공
            onPressed: () {
              pageFlag == 1 ?
              Get.offAllNamed(Routes.FACILITY_FIRST) :  pageFlag == 2 ? Get.offAllNamed(Routes.FACILITY) :  pageFlag == 3 ? Get.offAllNamed(Routes.PRODUCT_LOCATION) :
              pageFlag == 4 ? Get.back() : Get.offAllNamed(Routes.MAIN);
            //  Get.back();
            //  Get.back();
            },
            child: Container(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                color: Colors.black,
                child: Center(
                    child: Text(
                      '확인',
                      style: AppTheme.titleSubhead2.copyWith(color: AppTheme.white)
                    )),
              ),
            ),
        ),
      ],
    );
  }
}
