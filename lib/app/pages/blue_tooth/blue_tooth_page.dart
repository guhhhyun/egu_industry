import 'package:egu_industry/app/pages/blue_tooth/blue_tooth_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';


class BluetoothPage extends StatelessWidget {
  BluetoothPage({Key? key}) : super(key: key);

  BlueToothController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Container(
            child: Column(
              children: [
                Text(''),
                TextButton(
                    onPressed: () {
                    },
                    child: Text('네이티브에서 값 가져오기'))
              ],
            ),
          )),

    );
  }
}
