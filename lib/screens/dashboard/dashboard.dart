import 'package:flex_my_way/components/list-tile-button.dart';
import 'package:flex_my_way/util/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../util/constants/strings.dart';
import '../../util/size-config.dart';
import '../notifications.dart';

class Dashboard extends StatefulWidget {

  static const String id = "dashboard";
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Text(
          'Hi, Kelechi',
          style: textTheme.headline5,
        ),
        actions: [
          Center(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 600),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return const Notifications();
                        },
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return Container(
                            color: whiteColor.withOpacity(animation.value),
                            child: SlideTransition(
                              position: animation.drive(
                                Tween(
                                  begin: const Offset(0.0, -1.0),
                                  end: Offset.zero,
                                ).chain(CurveTween(curve: Curves.easeInCubic)),
                              ),
                              child: child,
                            ),
                          );
                        },
                      ),
                    );
                  },
                  child: const Icon(
                    IconlyLight.notification,
                    color: Colors.black,
                    size: 23,
                  ),
                ),
                Positioned(
                  right: 2.3,
                  top: 0.8,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 35),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              width: SizeConfig.screenWidth,
              padding: const EdgeInsets.fromLTRB(35, 24, 35, 0),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: appBarBottomBorder,
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
                    title: 'You have 111 pending invites. How would you like to deal with these?',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 24),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(24.0),
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
                          _scheduled(),
                          _completedFlex(),
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
    );
  }

  /// Widget to hold column view for scheduled flex
  Widget _scheduled() {
    return SingleChildScrollView(
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
    );
  }

  /// Widget to hold column view for completed flex
  Widget _completedFlex() {
    return SingleChildScrollView(
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
    );
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
                width: SizeConfig.screenWidth! * 0.235,
                height: SizeConfig.screenHeight! * 0.11,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
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
