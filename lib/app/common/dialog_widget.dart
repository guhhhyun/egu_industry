import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonDialogWidget extends StatelessWidget {
  String title;
  String? contentText;
  Widget? contentWidget;

  Function()? onOk;


  CommonDialogWidget(
      {super.key,
        required this.title,
        this.contentText,
        this.contentWidget,
        this.onOk,
      });

  Widget _contentText(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
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
      title: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Text(
            title,
            style: TextStyle(),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      content: contentWidget == null ? _contentText(context) : contentWidget,
      buttonPadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.only(
          left: 16, right: 16),
      titlePadding: const EdgeInsets.all(0),
      actions: [
        TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(5)))),
              /*backgroundColor: MaterialStateProperty.all<Color>(
                AppTheme.light_primary,
              ),*/
              padding:
              MaterialStateProperty.all(const EdgeInsets.all(0))),
          // 성공
          onPressed: () {
            Get.back();
          },
          child: Container(
            // width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 20,
            ),
            child: Center(
                child: Text(
                  '확인',
                  style: TextStyle(),
                )),
          ),
        )
      ],
    );
  }
}
