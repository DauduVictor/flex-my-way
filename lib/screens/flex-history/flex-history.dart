import 'dart:developer';
import 'package:flex_my_way/controllers/controllers.dart';
import 'package:flex_my_way/screens/flex-history/flex-history-detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../util/constants/constants.dart';
import '../../../util/size-config.dart';
import 'package:flex_my_way/model/model.dart';

class FlexHistory extends StatelessWidget {

  static const String id = 'flexHistory';
  FlexHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(flexBackgroundImage),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 50),
              //appbar
              Hero(
                tag: 'cameraButton',
                child: Builder(
                    builder: (context) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          backgroundColor: whiteColor,
                          radius: 22,
                          child: TextButton(
                            onPressed: () {
                              Get.back();
                            },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.fromLTRB(12, 8, 6, 8),
                                shape: const CircleBorder(),
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: neutralColor,
                                size: 22,
                              ),
                          ),
                        ),
                      );
                    }
                ),
              ),
              //body of media
              Expanded(
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      Text(
                        'Flex History',
                        style: textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const SizedBox(height: 24),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 35),
                              height: 42,
                              child: TabBar(
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: primaryColor,
                                ),
                                unselectedLabelColor: neutralColor,
                                tabs: const [
                                  Tab(
                                    child: Text(
                                      'Past',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Gilroy',
                                      ),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      'Present',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Gilroy',
                                      ),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      'Future',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Gilroy',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: GetBuilder<UserController>(
                                  init: UserController(),
                                  builder: (controller) {
                                    return TabBarView(
                                      children: [
                                        _pastFlex(controller.pastFlex),
                                        _presentFlex(controller.presentFlex),
                                        _futureFlex(controller.futureFlex),
                                      ],
                                    );
                                  }
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget to hold column view for past flex
  Widget _pastFlex(List<Flexes> data) {
    log(':::pastFlexLength: ${data.length}');
    return SingleChildScrollView(
      child: Column(
        children: const [
          ReusableFlexHistoryPastButton(
            title: 'Afro Nation Wide Festival',
            month: 'DEC',
            day: '25',
          ),
          ReusableFlexHistoryPastButton(
            title: 'Bee Beach Party',
            month: 'DEC',
            day: '25',
          ),
        ],
      ),
    );
  }

  /// Widget to hold column view for past flex
  Widget _presentFlex(List<Flexes> data) {
    log(':::presentFlexLength: ${data.length}');
    return SingleChildScrollView(
      child: Column(
        children: const [
          ReusableFlexHistoryButton(
            title: 'Afro Nation Festival',
            month: 'DEC',
            day: '25',
            ishost: false,
          ),
          ReusableFlexHistoryButton(
            title: 'Bee Beach Party',
            month: 'DEC',
            day: '25',
            ishost: false,
          ),
          ReusableFlexHistoryButton(
            title: 'Synopsis Hangout',
            month: 'DEC',
            day: '25',
            ishost: true,
          ),
          ReusableFlexHistoryButton(
            title: 'Mainland Block Party',
            month: 'DEC',
            day: '25',
            ishost: true,
          ),
          ReusableFlexHistoryButton(
            title: 'Acumen House Party',
            month: 'DEC',
            day: '25',
            ishost: false,
          ),
        ],
      ),
    );
  }

  /// Widget to hold column view for past flex
  Widget _futureFlex(List<Flexes> data) {
    log(':::futureFlexLength: ${data.length}');
    return SingleChildScrollView(
      child: Column(
        children: const [
          ReusableFlexHistoryButton(
            title: 'Bee Beach Party',
            month: 'DEC',
            day: '25',
            ishost: false,
          ),
          ReusableFlexHistoryButton(
            title: 'Synopsis Hangout',
            month: 'DEC',
            day: '25',
            ishost: true,
          ),
          ReusableFlexHistoryButton(
            title: 'Mainland Block Party',
            month: 'DEC',
            day: '25',
            ishost: true,
          ),
          ReusableFlexHistoryButton(
            title: 'Acumen House Party',
            month: 'DEC',
            day: '25',
            ishost: false,
          ),
        ],
      ),
    );
  }

}

class ReusableFlexHistoryPastButton extends StatelessWidget {

  final String title;
  final String month;
  final String day;

  const ReusableFlexHistoryPastButton({
    Key? key,
    required this.title,
    required this.month,
    required this.day
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, FlexHistoryDetail.id);
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            backgroundColor: const Color(0xFFDFE3E7).withOpacity(0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            )
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.headline5!.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 26),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  color: whiteColor,
                ),
                child: Column(
                  children: [
                    Text(
                      month,
                      style: textTheme.headline5!.copyWith(
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      day,
                      style: textTheme.headline5!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class ReusableFlexHistoryButton extends StatelessWidget {

  final String title;
  final String month;
  final String day;
  final bool ishost;

  const ReusableFlexHistoryButton({
    Key? key,
    required this.title,
    required this.month,
    required this.day,
    required this.ishost
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, FlexHistoryDetail.id);
          },
          style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              backgroundColor: primaryColor.withOpacity(0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              )
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.headline5!.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 26),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(23),
                      color: whiteColor,
                    ),
                    child: Column(
                      children: [
                        Text(
                          month,
                          style: textTheme.headline5!.copyWith(
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          day,
                          style: textTheme.headline5!.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  ishost == true
                    ? Text(
                    'Host',
                    style: textTheme.subtitle1!.copyWith(fontWeight: FontWeight.w600),
                  )
                    : Container(),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
