import 'package:carousel_slider/carousel_slider.dart';
import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/print/bluetooth_printer.dart';
import 'package:egu_industry/app/print/pos_printer.dart';
import 'package:egu_industry/app/print/print_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


import 'package:egu_industry/app/routes/app_route.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';


class MainSlideWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainSlideWidgetSate();
}

class _MainSlideWidgetSate extends State<MainSlideWidget> {

  int mainSlideIndex = 0;

  Widget _sliderContainer(String imgUrl) {
    return Container(
      child: Image.asset(imgUrl,
          width: double.infinity, height: 294, fit: BoxFit.cover),
    );
  }

  Widget _btnSliderContainer(
      {required String imgUrl, required Function() onpress}) {
    return Material(
      child: InkWell(
        onTap: onpress,
        child: Ink.image(
          image: AssetImage(
            imgUrl,
          ),
          height: 294,
          fit: BoxFit.cover,
        ),

        // child: Container(
        //   child: Image.asset(imgUrl,
        //       width: double.infinity, height: 294, fit: BoxFit.cover),
        // ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent)
            ),
            child: Stack(
                alignment: AlignmentDirectional.bottomCenter,

                children: [
                  CarouselSlider(
                      options: CarouselOptions(
                        height: 300,
                        viewportFraction: 1.0,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlay: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            mainSlideIndex = index;
                          });
                        },
                        // enlargeCenterPage: false,
                      ),
                      items: [
                        Stack(
                          children: [
                            _sliderContainer('assets/app/Group_225.png'),
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('단동', style: AppTheme.newTitleDisplay
                                      .copyWith(color: AppTheme.white),),
                                  Text('Red Brass', style: AppTheme.a24400
                                      .copyWith(color: AppTheme.white),),
                                  SizedBox(height: 14,),
                                  Text('단동 1종 ~ 3종', style: AppTheme.a16400
                                      .copyWith(color: AppTheme.white),)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            _sliderContainer('assets/app/Group_227.png'),
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('동', style: AppTheme.newTitleDisplay
                                      .copyWith(color: AppTheme.white),),
                                  Text('Copper', style: AppTheme.a24400
                                      .copyWith(color: AppTheme.white),),
                                  SizedBox(height: 14,),
                                  Text('타프피치동/일산탈동/무산소동', style: AppTheme.a16400
                                      .copyWith(color: AppTheme.white),)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            _sliderContainer('assets/app/Group_228.png'),
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('황동', style: AppTheme.newTitleDisplay
                                      .copyWith(color: AppTheme.white),),
                                  Text('Brass', style: AppTheme.a24400.copyWith(
                                      color: AppTheme.white),),
                                  SizedBox(height: 14,),
                                  Text('황동 1종 ~ 3종', style: AppTheme.a16400
                                      .copyWith(color: AppTheme.white),)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            _sliderContainer('assets/app/Group_226.png'),
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('인청동', style: AppTheme.newTitleDisplay
                                      .copyWith(color: AppTheme.white),),
                                  Text('Phodphor Bronze', style: AppTheme.a24400
                                      .copyWith(color: AppTheme.white),),
                                  SizedBox(height: 14,),
                                  Text('인청동 1종 ~ 3종', style: AppTheme.a16400
                                      .copyWith(color: AppTheme.white),)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            _sliderContainer('assets/app/Group_229.png'),
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('기타합급', style: AppTheme.newTitleDisplay
                                      .copyWith(color: AppTheme.white),),
                                  Text('Alloy', style: AppTheme.a24400.copyWith(
                                      color: AppTheme.white),),
                                  SizedBox(height: 14,),
                                  Text('C194/LFC/주석동/C4250', style: AppTheme
                                      .a16400.copyWith(color: AppTheme.white),),
                                  Text('뇌관용동/네이벌 황동', style: AppTheme.a16400
                                      .copyWith(color: AppTheme.white),)
                                ],
                              ),
                            ),
                          ],
                        )

                      ])
                ])));
  }
}