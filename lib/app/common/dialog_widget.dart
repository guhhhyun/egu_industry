import 'package:flutter/material.dart';

class CommonConfirmWidget extends StatelessWidget {
  String title;
  String? contentText;
  Widget? contentWidget;

  Function()? onOk;
  Function()? onCancel;
  Function()? onConfirm;

  CommonConfirmWidget(
      {super.key,
        required this.title,
        this.contentText,
        this.contentWidget,
        this.onOk,
        this.onCancel,
        this.onConfirm});

  Widget _contentText() {
    return Container(
      child: Text(
        contentText ?? '',
        style:
        TextStyle(),
        overflow: TextOverflow.ellipsis,
        maxLines: 10,
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
      content: contentWidget == null ? _contentText() : contentWidget,
      buttonPadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.only(
          left: 16, right: 16),
      titlePadding: const EdgeInsets.all(0),
      actions: [
        onConfirm != null
            ? TextButton(
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
          onPressed: onConfirm,
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
            : Row(
          children: [
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                    shape:
                    MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5)))),
                    /*backgroundColor: MaterialStateProperty.all<Color>(
                      AppTheme.light_cancel,
                    ),*/
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.all(0))),

                // 취소
                onPressed: onCancel,
                child: Container(
                  // width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                  ),
                  child: Center(
                      child: Text('취소',
                          style: TextStyle())),
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                    shape:
                    MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(5)))),
                    /*backgroundColor: MaterialStateProperty.all<Color>(
                      AppTheme.light_primary,
                    ),*/
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.all(0))),
                // 성공
                onPressed: onOk,
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
              ),
            )
          ],
        )
      ],
    );
  }
}
