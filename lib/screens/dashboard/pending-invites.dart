import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flex_my_way/controllers/controllers.dart';
import 'package:flex_my_way/components/components.dart';
import 'package:flex_my_way/util/util.dart';
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
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
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
                    onPressed: () {},
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 24),
                  child: Column(
                    children: const [
                      ReusablePendingInviteButton(),
                      ReusablePendingInviteButton(),
                      ReusablePendingInviteButton(),
                      ReusablePendingInviteButton(),
                      ReusablePendingInviteButton(),
                      ReusablePendingInviteButton(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

