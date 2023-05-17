import 'package:carousel_slider/carousel_slider.dart';
import 'package:egu_industry/app/common/app_theme.dart';
import 'package:flutter/material.dart';
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
        // height: 294,
        // width: double.infinity,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          // clipBehavior: Clip.none,
          // fit: StackFit,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 294,
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
                /*
                _sliderContainer('assets/app/slide01.png'),
                _sliderContainer('assets/app/slide02.png'),
                _sliderContainer('assets/app/slide03.png'),
                _sliderContainer('assets/app/slide04.png'),
                _sliderContainer('assets/app/slide05.png'),
                */

/*
                _btnSliderContainer(
                  imgUrl: 'assets/app/slide01.png',
                  onpress: () => Get.to(const BarIntroPage(),
                      transition: Transition.downToUp),
                ),
                */
                _sliderContainer('assets/app/slide01.png'),
                _btnSliderContainer(
                  imgUrl: 'assets/app/slide02.png',
                  onpress: () => Get.to(const BarIntroPage(),
                      transition: Transition.downToUp),
                ),
                _btnSliderContainer(
                    imgUrl: 'assets/app/slide03.png',
                    onpress: () => Get.to(const SectionIntroPage(),
                        transition: Transition.downToUp)),
                _btnSliderContainer(
                    imgUrl: 'assets/app/slide04.png',
                    onpress: () => Get.to(const PlateIntroPage(),
                        transition: Transition.downToUp)),
                _btnSliderContainer(
                    imgUrl: 'assets/app/slide05.png',
                    onpress: () => Get.to(const ColdIntroPage(),
                        transition: Transition.downToUp)),
              ],
            ),
            Container(
              // height: 20,
                padding: const EdgeInsets.only(
                    left: AppTheme.spacing_m_16,
                    right: AppTheme.spacing_m_16,
                    bottom: AppTheme.spacing_m_16),
                child: StepProgressIndicator(
                  totalSteps: 5,
                  padding: 0,
                  size: 2,
                  currentStep: mainSlideIndex + 1,
                  selectedColor: AppTheme.light_ui_01,
                  unselectedColor: AppTheme.light_ui_07,
                )),
          ],
        ),
      ),
    );
  }
}
