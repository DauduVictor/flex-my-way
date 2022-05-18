import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flex_my_way/controllers/controllers.dart';
import 'package:flex_my_way/components/components.dart';
import 'package:flex_my_way/util/util.dart';
import 'package:flex_my_way/networking/networking.dart';
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
        drawer: const RefactoredDrawer(),
        body: Column(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      acceptAll('', []);
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
                      rejectAll('', []);
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 24),
                child: userController.invites.isNotEmpty
                  ? ListView.builder(
                      itemCount: userController.invites.length,
                      itemBuilder: (BuildContext context, int index) {
                        var invites = userController.invitesList.elementAt(index);
                        return ReusablePendingInviteButton(invites: invites);
                      },
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SpinKitCircle(
                          color: primaryColor.withOpacity(0.9),
                          size: 65,
                        ),
                      ],
                  ),
              ),
            ),
            // Expanded(
            //   child: SingleChildScrollView(
            //     child: Padding(
            //       padding: const EdgeInsets.fromLTRB(20, 15, 20, 24),
            //       child: Column(
            //         children: const [
            //           ReusablePendingInviteButton(),
            //           ReusablePendingInviteButton(),
            //           ReusablePendingInviteButton(),
            //           ReusablePendingInviteButton(),
            //           ReusablePendingInviteButton(),
            //           ReusablePendingInviteButton(),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      )
    );
  }
}

/// Function to make api POST request
/// To accept attendee
void acceptAll(String flexCode, List<String>? participants) async {
  Map<String, dynamic> body = {
    'participants': participants
  };
  var api = FlexDataSource();
  await api.acceptAttendee(flexCode, body).then((flex) {
    /// update the controller here
  }).catchError((e){
    log(e);
    Functions.showMessage(e);
  });
}

/// Function to make api POST request
/// To reject attendee
void rejectAll(String flexCode, List<String> participants) async {
  Map<String, dynamic> body = {
    'participants': participants
  };
  var api = FlexDataSource();
  await api.rejectAttendee(flexCode, body).then((flex) {
    /// update the controller here
  }).catchError((e){
    log(e);
    Functions.showMessage(e);
  });
}
