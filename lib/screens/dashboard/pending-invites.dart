import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flex_my_way/controllers/controllers.dart';
import 'package:flex_my_way/components/components.dart';
import 'package:flex_my_way/util/util.dart';
import 'package:flex_my_way/networking/networking.dart';
import 'package:flex_my_way/model/model.dart';

class PendingInvites extends StatelessWidget {
  static const String id = "pendingInvites";
  PendingInvites({Key? key}) : super(key: key);

  /// calling the user controller [UserController]
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    List<ReusablePendingInviteButton> buildReusableInviteWidget = [];
    List<ReusablePendingInviteButton> buildReusableAcceptedWidget = [];
    List<ReusablePendingInviteButton> buildReusableRejectedWidget = [];
    return Scaffold(
      appBar: buildAppBarWithNotification(
          textTheme, context, userController.username.value),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: SizeConfig.screenWidth,
            padding: const EdgeInsets.fromLTRB(27, 12, 20, 15),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: appBarBottomBorder,
            ),
            child: Text(
              'Pending Invites',
              style: textTheme.headlineSmall!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GetBuilder(
              init: userController,
              builder: (controller) => Visibility(
                visible: userController.isFlexInvitesLoaded.value == true,
                replacement: Center(
                  child: SpinKitCircle(
                    color: primaryColor.withOpacity(0.9),
                    size: 45,
                  ),
                ),
                child: userController.flexInvites.isNotEmpty
                    ? SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GetBuilder(
                                init: UserController(),
                                builder: (controller) {
                                  buildReusableInviteWidget.clear();
                                  for (final pendingInvite
                                      in controller.flexInvites) {
                                    if (pendingInvite.attendeeStatus ==
                                        'Pending') {
                                      buildReusableInviteWidget.add(
                                        ReusablePendingInviteButton(
                                          invite: pendingInvite,
                                        ),
                                      );
                                    }
                                  }
                                  return Column(
                                    children: buildReusableInviteWidget.isEmpty
                                        ? [
                                            const Center(
                                              child: Text(
                                                'No pending invites at this time',
                                                style: TextStyle(fontSize: 17),
                                              ),
                                            ),
                                          ]
                                        : buildReusableInviteWidget,
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Accepted Invites',
                                style: textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: greenColor,
                                ),
                              ),
                              const SizedBox(height: 15),
                              GetBuilder(
                                init: UserController(),
                                builder: (controller) {
                                  buildReusableAcceptedWidget.clear();
                                  for (final acceptedInvite
                                      in controller.flexInvites) {
                                    if (acceptedInvite.attendeeStatus ==
                                        'Approved') {
                                      buildReusableAcceptedWidget.add(
                                        ReusablePendingInviteButton(
                                          invite: acceptedInvite,
                                          showFlexStatus: true,
                                          isFlexAccepted: true,
                                        ),
                                      );
                                    }
                                  }
                                  return Column(
                                    children: buildReusableAcceptedWidget,
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Rejected Invites',
                                style: textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: errorColor,
                                ),
                              ),
                              const SizedBox(height: 15),
                              GetBuilder(
                                init: UserController(),
                                builder: (controller) {
                                  buildReusableRejectedWidget.clear();
                                  for (final rejectedInvite
                                      in controller.flexInvites) {
                                    if (rejectedInvite.attendeeStatus ==
                                        'Rejected') {
                                      buildReusableRejectedWidget.add(
                                        ReusablePendingInviteButton(
                                          invite: rejectedInvite,
                                          showFlexStatus: true,
                                          isFlexAccepted: false,
                                        ),
                                      );
                                    }
                                  }
                                  return Column(
                                    children: buildReusableRejectedWidget,
                                  );
                                },
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).padding.bottom,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: SizeConfig.screenHeight! * 0.3),
                            SvgPicture.asset(
                              empty,
                              width: 70,
                              height: 70,
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'No pending, accepted or rejected invites at this time',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Function to make api POST request
  /// To accept attendee
  void acceptAll() async {
    // Map<String, dynamic> body = {};
    // for (int i = 0; i < userController.flexInvites.length; i++) {
    //   body[userController.flexInvites[i].flexCode!] =
    //       userController.flexInvites[i].attendeeId!;
    // }
    // userController.showInvitesSpinner.value = true;
    // var api = FlexDataSource();
    // await api.acceptAttendee(body).then((flex) {
    //   userController.showInvitesSpinner.value = false;
    //   userController.flexInvites
    //       .removeRange(0, userController.flexInvites.length - 1);
    //   userController.update();
    // }).catchError((e) {
    //   userController.showInvitesSpinner.value = false;
    //   log(e);
    //   Functions.showMessage(e);
    // });
  }

  /// Function to make api POST request
  /// To reject attendee
  void rejectAll() async {
    Map<String, List<String>> body = {};
    // for (int i = 0; i < userController.flexInvites.length; i++) {
    //   print([userController.flexInvites[i].flexCode, userController.flexInvites[i].attendeeId]);
    //   if(body.keys.contains(userController.flexInvites[i].flexCode)) {
    //     body[userController.flexInvites[i].flexCode!] =
    //   }
    //   body[userController.flexInvites[i].flexCode!] = [userController.flexInvites[i].attendeeId!];
    // }
    // userController.showInvitesSpinner.value = true;
    // var api = FlexDataSource();
    // await api.rejectAttendee(body).then((flex) {
    //   userController.showInvitesSpinner.value = false;
    //   userController.flexInvites.removeRange(0, userController.flexInvites.length -1);
    //   userController.update();
    // }).catchError((e){
    //   userController.showInvitesSpinner.value = false;
    //   log(e);
    //   Functions.showMessage(e);
    // });
  }
}

class ReusablePendingInviteButton extends StatelessWidget {
  final FlexInvite? invite;
  final bool showFlexStatus;
  final bool isFlexAccepted;

  ReusablePendingInviteButton({
    Key? key,
    this.invite,
    this.showFlexStatus = false,
    this.isFlexAccepted = false,
  }) : super(key: key);

  /// calling the user controller [UserController]
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isUpdateInviteContainer = ValueNotifier(false);
    return Column(
      children: [
        Container(
          width: SizeConfig.screenWidth,
          padding: const EdgeInsets.fromLTRB(32, 28, 5, 28),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: textTheme.bodyMedium!,
                        children: [
                          TextSpan(
                            text: '#${invite?.attendeeId}',
                            style: textTheme.bodyLarge!.copyWith(
                              fontSize: 18.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const TextSpan(
                            text: ' wants in.',
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${invite?.flexName}',
                      style: textTheme.bodyMedium!.copyWith(
                        fontSize: 14.5,
                        color: neutralColor.withOpacity(0.7),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              showFlexStatus
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 2),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: isFlexAccepted
                            ? greenColor.withOpacity(0.3)
                            : errorColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        isFlexAccepted ? 'Accepted' : 'Rejected',
                        style: textTheme.bodyMedium!.copyWith(
                          fontSize: 12.5,
                          color: blackColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : ValueListenableBuilder(
                      valueListenable: isUpdateInviteContainer,
                      builder: (context, val, _) {
                        return Visibility(
                          visible: isUpdateInviteContainer.value == false,
                          replacement: Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: SpinKitCircle(
                              color: primaryColor.withOpacity(0.9),
                              size: 23,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: TextButton(
                                  onPressed: () {
                                    acceptAttendee(
                                      invite!.flexCode!,
                                      invite!.attendeeId!,
                                      isUpdateInviteContainer,
                                    );
                                  },
                                  child: const Icon(
                                    Icons.check,
                                    color: greenColor,
                                    size: 25,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: TextButton(
                                  onPressed: () {
                                    rejectAttendee(
                                      invite!.flexCode!,
                                      invite!.attendeeId!,
                                      isUpdateInviteContainer,
                                    );
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: errorColor,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  /// Function to make api POST request
  /// To accept attendee
  void acceptAttendee(
    String flexCode,
    String? participants,
    ValueNotifier<bool> isUpdateInviteContainer,
  ) async {
    Map<String, dynamic> body = {
      "approvals": [
        {'flexCode': flexCode, 'participant': participants}
      ]
    };
    isUpdateInviteContainer.value = true;
    var api = FlexDataSource();
    await api.acceptAttendee(body).then((flex) async {
      Functions.showMessage('User added to confirmed guest list!');
      await userController.getFlexInvites();
      isUpdateInviteContainer.value = false;
      userController.update();
      userController.getDashboardFlex();
      userController.update();
    }).catchError((e) {
      isUpdateInviteContainer.value = false;
      log(e);
      Functions.showMessage(e);
    });
  }

  /// Function to make api POST request
  /// To reject attendee
  void rejectAttendee(
    String flexCode,
    String participants,
    ValueNotifier<bool> isUpdateInviteContainer,
  ) async {
    Map<String, dynamic> body = {
      "rejections": [
        {'flexCode': flexCode, 'participant': participants}
      ]
    };
    isUpdateInviteContainer.value = true;
    var api = FlexDataSource();
    await api.rejectAttendee(body).then((flex) async {
      Functions.showMessage('User rejected from attending!');
      await userController.getFlexInvites();
      isUpdateInviteContainer.value = false;
      userController.update();
      userController.getDashboardFlex();
      userController.update();
    }).catchError((e) {
      isUpdateInviteContainer.value = false;
      log(e);
      Functions.showMessage(e);
    });
  }
}
