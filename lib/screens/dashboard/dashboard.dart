import 'dart:developer';
import 'package:flex_my_way/screens/dashboard/pending-invites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flex_my_way/components/components.dart';
import '../../controllers/user-controller.dart';
import 'package:flex_my_way/util/util.dart';
import 'drawer.dart';
import 'package:flex_my_way/model/model.dart';

class Dashboard extends StatelessWidget {

  static const String id = "dashboard";
  Dashboard({Key? key}) : super(key: key);

  /// calling the user controller [UserController]
  final UserController userController = Get.put(UserController());

  ///widget to show the dialog for flex reminder
  Future<void> checkFlexReminder (BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: whiteColor,
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
                  Text(
                    'Reminder!',
                    style: TextStyle(

                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Text(
                      'We saved the flex you were trying to create. Click "Continue" to finish your flex and go live now!! ',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          primary: primaryColor,
                        ),
                        child: const Text(
                          'Cancel',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: TextButton(
                          onPressed: () async {

                          },
                          style: TextButton.styleFrom(
                            primary: primaryColor,
                          ),
                          child: const Text(
                            'Continue',
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
  Widget build(BuildContext context) {
    // checkFlexReminder(context);
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Obx(() => Scaffold(
        appBar: buildAppBarWithNotification(textTheme, context, userController.username.value),
        drawer: RefactoredDrawer(),
        body: DefaultTabController(
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
                      style: textTheme.headline5!.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 24),
                    ListTileButton(
                      title: userController.notification.isEmpty
                        ? 'You have ${userController.notification.length} pending invites. How would you like to deal with these?'
                        : 'No pending invites at the moment. Create Flex and invite your friends',
                      onPressed: () {
                        Navigator.pushNamed(context, PendingInvites.id);
                      },
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
      )
    );
  }

  /// Widget to hold column view for scheduled flex
  Widget _scheduled(List<Flexes> data) {
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
            return const ReusableDashBoardCard(
              eventName: 'Afro Nation Festival',
              noOfAttendees: '10',
              maxNoOfAttendees: '50',
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
    /*return SingleChildScrollView(
      child: Column(
        children: const [
          ReusableDashBoardCard(
            eventName: 'Afro Nation Festival',
            noOfAttendees: '10',
            maxNoOfAttendees: '50',
          ),
          ReusableDashBoardCard(
            eventName: 'Kelechi\'s Birthday Party',
            noOfAttendees: '43',
            maxNoOfAttendees: '50',
          ),
          ReusableDashBoardCard(
            eventName: 'Champions league final live at abule',
            noOfAttendees: '50',
            maxNoOfAttendees: '50',
          ),
        ],
      ),
    );*/
  }

  /// Widget to hold column view for completed flex
  Widget _completedFlex(List<Flexes> data) {
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
            return const ReusableDashBoardCard(
              eventName: 'Afro Nation Festival',
              noOfAttendees: '10',
              maxNoOfAttendees: '50',
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

class ReusableDashBoardCard extends StatelessWidget {

  const ReusableDashBoardCard({
    Key? key,
    this.image,
    required this.eventName,
    required this.noOfAttendees,
    required this.maxNoOfAttendees
  }) : super(key: key);

  final String? image;
  final String eventName;
  final String noOfAttendees;
  final String maxNoOfAttendees;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Container(
          width: SizeConfig.screenWidth,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: whiteColor,
          ),
          child: Row(
            children: [
              Container(
                width: SizeConfig.screenWidth! * 0.237,
                height: SizeConfig.screenHeight! * 0.104,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: AssetImage(unsplashImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventName,
                      style: textTheme.headline6!.copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: SizeConfig.screenHeight! * 0.013),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '10/50',
                          style: textTheme.bodyText2!.copyWith(
                            fontSize: 15,
                            color: neutralColor.withOpacity(0.5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          AppStrings.confirmedInvitees,
                          style: textTheme.bodyText2!.copyWith(
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
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
