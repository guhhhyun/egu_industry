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
        decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent)
        ),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,

          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 350,
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
                _sliderContainer('assets/app/slide2.jpeg'),
                _sliderContainer('assets/app/slide2.jpeg'),
                _sliderContainer('assets/app/slide2.jpeg'),
                _sliderContainer('assets/app/slide2.jpeg'),
                /*_btnSliderContainer(
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
                        transition: Transition.downToUp)),*/
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      // height: 20,
                        padding: const EdgeInsets.only(
                            left: AppTheme.spacing_m_16,
                            right: AppTheme.spacing_m_16,
                            bottom: AppTheme.spacing_m_16),
                        child: Container(
                          width: 50,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black45
                          ),
                          child: Center(child: Text('${mainSlideIndex + 1} / 5', style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white
                          ),)),
                        )
                    )/*StepProgressIndicator(
                          totalSteps: 5,
                          padding: 0,
                          size: 2,
                          currentStep: mainSlideIndex + 1,
                          selectedColor: AppTheme.light_ui_01,
                          unselectedColor: AppTheme.light_ui_07,
                        )
                    ),*/
                  ],
                ),
                Container(
                  height: 36,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                    color: Colors.white
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
