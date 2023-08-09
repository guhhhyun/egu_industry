
import 'package:egu_industry/app/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../routes/app_route.dart';
import 'app_theme.dart';

class CommonAppbarWidget extends StatelessWidget {
  String title;
  Widget? titleWidget;
  bool isLogo;
  bool isFirstPage;

  PreferredSizeWidget? bottom;

  CommonAppbarWidget(
      {Key? key,
      required this.title,
      required this.isLogo,
      this.titleWidget,
      this.bottom,
      required this.isFirstPage
      })
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
      titleSpacing: 0,
      leading: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
        ),
        onPressed: () {
          isFirstPage ?
          Get.offAll(HomePage()) : Get.back();
        },
        child: SvgPicture.asset('assets/app/arrow2Left.svg', color: AppTheme.black,),
      ),
      centerTitle: false,
      title: titleWidget ??
              Text(
                title,
                style: AppTheme.a18700.copyWith(color: Colors.black),
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
