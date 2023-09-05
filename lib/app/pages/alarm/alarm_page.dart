import 'package:egu_industry/app/common/app_theme.dart';
import 'package:egu_industry/app/common/global_service.dart';
import 'package:egu_industry/app/pages/alarm/alarm_controller.dart';
import 'package:egu_industry/app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AlarmPage extends GetView<AlarmController> {
  AlarmPage({Key? key}) : super(key: key);
  GlobalService gs = Get.find();

  Widget _title() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppTheme.light_ui_background,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: SvgPicture.asset(
          'assets/app/arrow2Left.svg',
        ),
      ),
      title: Text(
        '알림',
        style: AppTheme.a18700.copyWith(color: AppTheme.black),
      ),
      centerTitle: false,
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
          color: AppTheme.dark_text_secondary,
          height: 1,
        ),
        Column(children: [
          TabBar(
          //  isScrollable: true,
            //  indicatorSize: TabBarIndicatorSize.tab,
            controller: controller.tabController,
            indicatorColor: AppTheme.black,
            labelColor: AppTheme.black,
            onTap: (value) {
              if (value == 1) {
                gs.isLogin.value ? null : Get.toNamed(Routes.LOGIN_PAGE);
              }
            },
            unselectedLabelColor: AppTheme.light_ui_05,
            tabs: [
              Container(
                height: 60,
                alignment: Alignment.center,
                child: const Text(
                  '전체',
                  style: AppTheme.titleSubhead3,
                ),
              ),
              Container(
                height: 60,
                alignment: Alignment.center,
                child: const Text(
                  '미확인',
                  style: AppTheme.titleSubhead3,
                ),
              ),
              Container(
                height: 60,
                alignment: Alignment.center,
                child: const Text(
                  '확인',
                  style: AppTheme.titleSubhead3,
                ),
              ),
            ],
          ),
          Container(
            color: AppTheme.dark_text_secondary,
            height: 1,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 160,
            child: TabBarView(
              controller: controller.tabController,
              children: [
                _allBody(),
                _noConfirmBody(),
                _allBody(),
              ],
            ),
          ),
        ]),
      ]),
    );
  }

  Widget _allBody() {
    return RefreshIndicator(
        onRefresh: () async {
          controller.chkYn.value = '';
          await controller.checkList();
          return Future.value(true);
        },
        child: Stack(children: [
          CustomScrollView(slivers: [
            _allListArea()
          ])
        ]));
  }


  Widget _allListArea() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _allListItem(index: index, context: context);
        }, childCount: 10));
  }

  Widget _allListItem({required BuildContext context, required int index}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /*TextButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(0))),
          onPressed: () {
            Get.log('클릭!!');
          },
          child: */Container(
            decoration: const BoxDecoration(
                border:
                Border(bottom: BorderSide(color: AppTheme.gray_gray_200))),
            padding: const EdgeInsets.only(
                top: AppTheme.spacing_s_12, bottom: AppTheme.spacing_s_12),
            child: Theme(
              data:
              Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text('제목 ${index + 1}', style: AppTheme.a18700.copyWith(color: AppTheme.red_red_800),)
                        ],
                      )
                    ],
                  ),

                  //   initiallyExpanded: true,
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          color: AppTheme.light_ui_01,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: AppTheme.spacing_m_16,
                              top: AppTheme.spacing_xl_24,
                              right: AppTheme.spacing_m_16,
                              bottom: AppTheme.spacing_xl_24,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('장애일시: 2023-08-31 00:00', style: AppTheme.a16400.copyWith(color: AppTheme.black),),
                                    Text('경과시간: ${index + 1}h', style: AppTheme.a16400.copyWith(color: AppTheme.black),),
                                  ],
                                ),
                                const SizedBox(height: 12,),
                                Text('등록자: 강구현${index + 1}', style: AppTheme.a16400.copyWith(color: AppTheme.black),),
                                const SizedBox(height: 12,),
                                Text('장애내용: 설비 장애 코드 ${index + 1}', style: AppTheme.a16400.copyWith(color: AppTheme.black),),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
      ],
    );
  }

  Widget _noConfirmBody() {
    return RefreshIndicator(
        onRefresh: () async {
          controller.chkYn.value = 'N';
          await controller.checkList();
          return Future.value(true);
        },
        child: Stack(children: [
          CustomScrollView(slivers: [
            _noConformListArea()
          ])
        ]));
  }


  Widget _noConformListArea() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _noConfirmListItem(index: index, context: context);
        }, childCount: 5));
  }

  Widget _noConfirmListItem({required BuildContext context, required int index}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
              border:
              Border(bottom: BorderSide(color: AppTheme.gray_gray_200))),
          padding: const EdgeInsets.only(
              top: AppTheme.spacing_s_12, bottom: AppTheme.spacing_s_12),
          child: Theme(
            data:
            Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text('제목 ${index + 1}', style: AppTheme.a18700.copyWith(color: AppTheme.red_red_800),),
                      ],
                    )
                  ],
                ),
                // initiallyExpanded: true,
                backgroundColor: Colors.white,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        color: AppTheme.light_ui_01,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: AppTheme.spacing_m_16,
                            top: AppTheme.spacing_xl_24,
                            right: AppTheme.spacing_m_16,
                            bottom: AppTheme.spacing_xl_24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('장애일시: 2023-08-31 00:00', style: AppTheme.a16400.copyWith(color: AppTheme.black),),
                                  Text('경과시간: ${index + 1}h', style: AppTheme.a16400.copyWith(color: AppTheme.black),),
                                ],
                              ),
                              const SizedBox(height: 12,),
                              Text('등록자: 강다은${index + 1}', style: AppTheme.a16400.copyWith(color: AppTheme.black),),
                              const SizedBox(height: 12,),
                              Text('장애내용: 설비 장애 코드 ${index + 1}', style: AppTheme.a16400.copyWith(color: AppTheme.black),),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        child: Column(
          children: [_title(), _body(context)],
        ),
      ),
    );
  }
}
