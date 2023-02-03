import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_my_way/screens/dashboard/pending-invites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flex_my_way/components/components.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/user-controller.dart';
import 'package:flex_my_way/util/util.dart';
import '../host/host-a-flex.dart';
import 'drawer.dart';
import 'package:flex_my_way/model/model.dart';

import 'edit-flex.dart';

class Dashboard extends StatefulWidget {

  static const String id = "dashboard";
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  /// calling the user controller [UserController]
  final UserController userController = Get.put(UserController());


  /// Function to check if the user was trying to host a flex
  void checkFlexReminderFromSp() {
    Future.delayed(const Duration(milliseconds: 2000), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getBool('flexReminder') == true) checkFlexReminder();
    });
  }

  String img1 = "https://picsum.photos/146";
  String img2 = "https://picsum.photos/159";

  ///widget to show the dialog for flex reminder
  checkFlexReminder () {
    return showDialog<void> (
      context: context,
      barrierDismissible: true,
      barrierColor: neutralColor.withOpacity(0.6),
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.fromLTRB(16, 30, 16, 21),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: whiteColor,
            ),
            child: Material(
              borderRadius: BorderRadius.circular(4),
              color: whiteColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.notification_important,
                    color: Color(0xFF17B899),
                    size: 55,
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Reminder',
                    style: TextStyle(
                      color: neutralColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Flexmyway got your back. Click "Continue" to finish your flex and go live!!',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: TextButton.styleFrom(
                          primary: primaryColor,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        ),
                        child: const Text(
                          'Cancel',
                        ),
                      ),
                      const SizedBox(width: 30),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: TextButton(
                          onPressed: () async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setBool('flexReminder', false);
                            Get.back();
                            Get.toNamed(HostAFlex.id);
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            backgroundColor: primaryColor,
                          ),
                          child: const Text(
                            'Continue',
                            style: TextStyle(color: whiteColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    checkFlexReminderFromSp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userController.checkUserIsLoggedIn();
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Obx(() => Scaffold(
        appBar: buildAppBarWithNotification(textTheme, context, userController.username.value),
        drawer: RefactoredDrawer(),
        body: WillPopScope(
          onWillPop: Functions.onWillPops,
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Container(
                  width: SizeConfig.screenWidth,
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.manageYourFlex,
                        style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 24),
                      Visibility(
                        visible: userController.canHostFlex.value,
                        child: ListTileButton(
                          title: userController.flexInvites.isNotEmpty
                            ? 'You have ${userController.flexInvites.length} pending invites. How would you like to deal with these?'
                            : 'No pending invites at the moment. Create Flex and invite your friends',
                          onPressed: () {
                             Get.toNamed(PendingInvites.id);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(35, 24, 35, 3),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: BounceInDown(
                            duration: const Duration(milliseconds: 600),
                            child: SizedBox(
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
                                      'Scheduled',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Gilroy',
                                      ),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      'Completed',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Gilroy',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child: TabBarView(
                            children: [
                              _scheduled(userController.scheduledFlex),
                              _completedFlex(userController.completedFlex),
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
      )
    );
  }

  /// Widget to hold column view for scheduled flex
  Widget _scheduled(List<DashboardFLex> data) {
    log(':::scheduledFlexLength: ${data.length}');
    if (userController.isScheduledLoaded.value == true) {
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
                'You have no scheduled flex',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      } else {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return ReusableDashBoardCard(
              dashboardFLex: data[index],
              isScheduled: true,
            );
          },
        );
      }
    } else {
      return Center(
        child: SpinKitCircle(
          color: primaryColor.withOpacity(0.9),
          size: 40,
        ),
      );
    }
  }

  /// Widget to hold column view for completed flex
  Widget _completedFlex(List<DashboardFLex> data) {
    log(':::completedFlexLength: ${data.length}');
    if (userController.isScheduledLoaded.value == true) {
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
                'You have no completed flex',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      } else {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return ReusableDashBoardCard(
              dashboardFLex: data[index],
              isScheduled: false
            );
          },
        );
      }
    } else {
      return Center(
        child: SpinKitCircle(
          color: primaryColor.withOpacity(0.9),
          size: 40,
        ),
      );
    }
  }

  DateTime? currentBackPressTime;

  Future<bool> _onWillPops() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Functions.showMessage('Press back again to exit');
      return Future.value(false);
    }
    return Future.value(true);
  }
}

class ReusableDashBoardCard extends StatelessWidget {

  const ReusableDashBoardCard({
    Key? key,
    required this.isScheduled,
    required this.dashboardFLex,
  }) : super(key: key);

  final bool isScheduled;
  final DashboardFLex dashboardFLex;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return SlideInUp(
      child: Column(
        children: [
          Container(
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: whiteColor,
            ),
            clipBehavior: Clip.hardEdge,
            child: TextButton(
              onPressed: () {
                if (isScheduled) {
                  Get.to(() => EditFlex(flexCode: dashboardFLex.flexCode));
                }
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: SizeConfig.screenWidth! * 0.237,
                        height: SizeConfig.screenHeight! * 0.104,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: CachedNetworkImage(
                          alignment: Alignment.topCenter,
                          imageUrl: dashboardFLex.flexImage!,
                          progressIndicatorBuilder: (context, url, downloadProgress) {
                            return SpinKitCircle(
                              color: primaryColor.withOpacity(0.7),
                              size: 30,
                            );
                          },
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: neutralColor.withOpacity(0.4),
                            size: 30,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dashboardFLex.flexName!,
                              style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: SizeConfig.screenHeight! * 0.013),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${dashboardFLex.confirmedInvitees}/${dashboardFLex.flexCapacity}',
                                  style: textTheme.bodyMedium!.copyWith(
                                    fontSize: 15,
                                    color: neutralColor.withOpacity(0.5),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  AppStrings.confirmedInvitees,
                                  style: textTheme.bodyMedium!.copyWith(
                                    fontSize: 15,
                                    color: neutralColor.withOpacity(0.5),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  if(isScheduled)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Edit',
                            style: textTheme.bodyMedium!.copyWith(
                              fontSize: 13,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.arrow_forward,
                            size: 13,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}