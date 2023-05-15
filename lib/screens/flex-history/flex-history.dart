import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:flex_my_way/controllers/controllers.dart';
import 'package:flex_my_way/screens/flex-history/flex-history-detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flex_my_way/util/util.dart';
import 'package:flex_my_way/model/model.dart';

import '../dashboard/drawer.dart';

class FlexHistory extends StatelessWidget {

  static const String id = 'flexHistory';
  FlexHistory({Key? key}) : super(key: key);

  /// calling the user controller [UserController]
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      drawer: RefactoredDrawer(),
      body: WillPopScope(
        onWillPop: Functions.onWillPops,
        child: Container(
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
                                Scaffold.of(context).openDrawer();
                              },
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.fromLTRB(11, 8, 12, 8),
                                  shape: const CircleBorder(),
                                ),
                                child: const Icon(
                                  Icons.menu,
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
                          style: textTheme.headlineSmall!.copyWith(
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
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Gilroy',
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        'Present',
                                        style: TextStyle(
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Gilroy',
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        'Future',
                                        style: TextStyle(
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Gilroy',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
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
      ),
    );
  }

  /// Widget to hold column view for past flex
  Widget _pastFlex(List<HistoryFlex> data) {
    log(':::pastFlexLength: ${data.length}');
    if (userController.isPastLoaded.value == true) {
      if (data.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                empty,
                width: 70,
                height: 70,
              ),
              const SizedBox(height: 20),
              const Text(
                'You have no past flex',
                style: TextStyle(fontSize: 16.5),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      } else {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return  ReusableFlexHistoryPastButton(
              title: data[index].flexDetails!.name!,
              month: Functions.getFlexDayAndMonth(data[index].flexDetails!.fromDate!)[0],
              day: Functions.getFlexDayAndMonth(data[index].flexDetails!.fromDate!)[1],
              flex: data[index].flexDetails!,
              position: index,
            );
          },
        );
      }
    } else {
      return Center(
        child: SpinKitCircle(
          color: primaryColor.withOpacity(0.9),
          size: 50,
        ),
      );
    }
  }

  /// Widget to hold column view for past flex
  Widget _presentFlex(List<HistoryFlex> data) {
    log(':::presentFlexLength: ${data.length}');
    if (userController.isPresentLoaded.value == true) {
      if (data.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                empty,
                width: 70,
                height: 70,
              ),
              const SizedBox(height: 20),
              const Text(
                'You have no present flex',
                style: TextStyle(fontSize: 16.5),
              ),
              const SizedBox(height: 5),
            ],
          ),
        );
      } else {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return ReusableFlexHistoryButton(
              title: data[index].flexDetails!.name!,
              month: Functions.getFlexDayAndMonth(data[index].flexDetails!.fromDate!)[0],
              day: Functions.getFlexDayAndMonth(data[index].flexDetails!.fromDate!)[1],
              flex: data[index].flexDetails!,
              ishost: false,
              position: index,
            );
          },
        );
      }
    } else {
      return Center(
        child: SpinKitCircle(
          color: primaryColor.withOpacity(0.9),
          size: 50,
        ),
      );
    }
  }

  /// Widget to hold column view for past flex
  Widget _futureFlex(List<HistoryFlex> data) {
    log(':::futureFlexLength: ${data.length}');
    if (userController.isFutureLoaded.value == true) {
      if (data.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                empty,
                width: 70,
                height: 70,
              ),
              const SizedBox(height: 20),
              const Text(
                'You have no future flex',
                style: TextStyle(fontSize: 16.5),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      } else {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return ReusableFlexHistoryButton(
              title: data[index].flexDetails!.name!,
              month: Functions.getFlexDayAndMonth(data[index].flexDetails!.fromDate!)[0],
              day: Functions.getFlexDayAndMonth(data[index].flexDetails!.fromDate!)[1],
              flex: data[index].flexDetails!,
              ishost: false,
              position: index,
            );
          },
        );
      }
    } else {
      return Center(
        child: SpinKitCircle(
          color: primaryColor.withOpacity(0.9),
          size: 50,
        ),
      );
    }
  }

}

class ReusableFlexHistoryPastButton extends StatelessWidget {

  final String title;
  final String month;
  final String day;
  final Flexes flex;
  final int position;

  const ReusableFlexHistoryPastButton({
    Key? key,
    required this.title,
    required this.month,
    required this.day,
    required this.flex,
    required this.position
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Bounce(
      infinite: true,
      from: 3,
      duration: Duration(seconds: 3 + position),
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              Get.to(() => FlexHistoryDetail(flex: flex, past: true));
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
                        title.capitalizeFirst!,
                        style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w600),
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
                        style: textTheme.headlineSmall!.copyWith(
                          color: primaryColor,
                          fontSize: 20.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        day,
                        style: textTheme.headlineSmall!.copyWith(
                          fontSize: 20.5,
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
      ),
    );
  }
}

class ReusableFlexHistoryButton extends StatelessWidget {

  final String title;
  final String month;
  final String day;
  final bool ishost;
  final Flexes flex;
  final int position;

  const ReusableFlexHistoryButton({
    Key? key,
    required this.title,
    required this.month,
    required this.day,
    required this.ishost,
    required this.flex,
    required this.position
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Bounce(
      infinite: true,
      from: 3,
      duration: Duration(seconds: 3 + position),
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              Get.to(() => FlexHistoryDetail(flex: flex, past: false,));
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
                        title.capitalizeFirst!,
                        style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w600),
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
                            style: textTheme.headlineSmall!.copyWith(
                              color: primaryColor,
                              fontSize: 20.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            day,
                            style: textTheme.headlineSmall!.copyWith(
                              fontSize: 20.5,
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
                      style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                    )
                      : Container(),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
