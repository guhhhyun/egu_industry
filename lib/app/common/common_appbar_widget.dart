
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../routes/app_route.dart';
import 'app_theme.dart';

class CommonAppbarWidget extends StatelessWidget {
  String title;
  Widget? titleWidget;
  bool isLogo;

  PreferredSizeWidget? bottom;

  CommonAppbarWidget(
      {Key? key,
      required this.title,
      required this.isLogo,
      this.titleWidget,
      this.bottom})
      : super(key: key);

  Widget _homeIcon() {
    return IconButton(
      onPressed: () {
        Get.offAllNamed(Routes.MAIN);
      },
      icon: Icon(Icons.home),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: false,
      title: titleWidget ??
              Text(
                title,
                style: AppTheme.titleSubhead4.copyWith(color: Colors.black),
              ),
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      floating: true,

      expandedHeight: 30.0,
      //bottom: bottom,
    );
  }
}
