import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flex_my_way/controllers/controllers.dart';
import 'package:flex_my_way/components/components.dart';
import 'package:flex_my_way/util/util.dart';
import 'package:flex_my_way/networking/networking.dart';
import 'package:flex_my_way/model/model.dart';
import 'drawer.dart';

class PendingInvites extends StatelessWidget {

  static const String id = "pendingInvites";
  PendingInvites({Key? key}) : super(key: key);

  /// calling the user controller [UserController]
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Obx(() => Scaffold(
        appBar: buildAppBarWithNotification(textTheme, context, userController.username.value),
        body: Stack(
          children: [
            Column(
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
                    style: textTheme.headline5!.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 10),
                userController.flexInvites.isNotEmpty
                  ? Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    acceptAll();
                                  },
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                  ),
                                  child: Text(
                                    'Accept All',
                                    style: textTheme.button!.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: greenColor,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    rejectAll();
                                  },
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                  ),
                                  child: Text(
                                    'Deny All',
                                    style: textTheme.button!.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: errorColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Container(
                          height: SizeConfig.screenHeight! * 0.7,
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                          child: ListView.builder(
                            itemCount: userController.flexInvites.length,
                            itemBuilder: (BuildContext context, int index) {
                              ///TODO: get the invite object and pass it to the pending invite button
                              var invites = userController.flexInvites.elementAt(index);
                              return ReusablePendingInviteButton(
                                invite: userController.flexInvites[index],
                                index: index,
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : Expanded(
                    child: Center(
                        child: SpinKitCircle(
                          color: primaryColor.withOpacity(0.9),
                          size: 65,
                        ),
                    ),
                  ),
              ],
            ),
            userController.showInvitesSpinner.value == true
              ? Container(
                  child: AbsorbPointer(
                    absorbing: userController.showInvitesSpinner.value,
                    child: SpinKitCircle(
                      color: primaryColor.withOpacity(0.9),
                      size: 65,
                    ),
                  ),
                  color: userController.showInvitesSpinner.value == true
                    ? primaryColor.withOpacity(0.15)
                    : transparentColor,
                )
              : Container(),
          ],
        ),
      )
    );
  }

  /// Function to make api POST request
  /// To accept attendee
  void acceptAll() async {
    Map<String, dynamic> body = {
      'flexCode': 'flexCode',
      'participants': 'participants'
    };
    // for (int i = 0; i < userController.flexInvites.length; i++) {
    //   participants.add(userController.flexInvites[i].attendeeId!);
    // }
    userController.showInvitesSpinner.value = true;
    var api = FlexDataSource();
    await api.acceptAttendee(body).then((flex) {
      userController.showInvitesSpinner.value = false;
      userController.flexInvites.removeRange(0, userController.flexInvites.length -1);
      userController.update();
    }).catchError((e){
      userController.showInvitesSpinner.value = false;
      log(e);
      Functions.showMessage(e);
    });
  }

  /// Function to make api POST request
  /// To reject attendee
  void rejectAll() async {
    List<String> participants = [];
    for (int i = 0; i < userController.flexInvites.length; i++) {
      participants.add(userController.flexInvites[i].flexId!);
    }
    Map<String, dynamic> body = {
      'participants': participants
    };
    userController.showInvitesSpinner.value = true;
    var api = FlexDataSource();
    print(participants);
    await api.rejectAttendee(body).then((flex) {
      userController.showInvitesSpinner.value = false;
      userController.flexInvites.removeRange(0, userController.flexInvites.length -1);
      userController.update();
    }).catchError((e){
      userController.showInvitesSpinner.value = false;
      log(e);
      Functions.showMessage(e);
    });
  }

}

class ReusablePendingInviteButton extends StatelessWidget {

  final FlexInvite? invite;
  final int index;

  ReusablePendingInviteButton({
    Key? key,
    this.invite,
    required this.index
  }) : super(key: key);

  /// calling the user controller [UserController]
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
                        style: textTheme.bodyText2!,
                        children: [
                          TextSpan(
                            text: '#${invite?.attendeeId}',
                            style: textTheme.bodyText1!.copyWith(
                              fontSize: 18,
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
                      'Afro Nation Festival',
                      style: textTheme.bodyText2!.copyWith(
                        fontSize: 14,
                        color: neutralColor.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        acceptAttendee(invite!.flexCode!, invite!.attendeeId!);
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
                        rejectAttendee(invite!.flexCode!, invite!.attendeeId!);
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
            ],
          ),
        ),
        const  SizedBox(height: 15),
      ],
    );
  }

  /// Function to make api POST request
  /// To accept attendee
  void acceptAttendee(String flexCode, String? participants) async {
    Map<String, dynamic> body = {
      'flexCode': flexCode,
      'participant': participants
    };
    userController.showInvitesSpinner.value = true;
    var api = FlexDataSource();
    await api.acceptAttendee(body).then((flex) {
      userController.showInvitesSpinner.value = false;
      userController.flexInvites.removeAt(index);
      userController.update();
      userController.getDashboardFlex();
    }).catchError((e) {
      userController.showInvitesSpinner.value = false;
      log(e);
      Functions.showMessage(e);
    });
  }

  /// Function to make api POST request
  /// To reject attendee
  void rejectAttendee(String flexCode, String participants) async {
    Map<String, dynamic> body = {
      'flexCode': flexCode,
      'participant': participants
    };
    userController.showInvitesSpinner.value = true;
    var api = FlexDataSource();
    await api.rejectAttendee(body).then((flex) {
      userController.showInvitesSpinner.value = false;
      userController.flexInvites.removeAt(index);
      userController.update();
      userController.getDashboardFlex();
    }).catchError((e){
      userController.showInvitesSpinner.value = false;
      log(e);
      Functions.showMessage(e);
    });
  }

}


