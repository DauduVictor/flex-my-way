import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/app-bar.dart';
import '../../controllers/dashboard-controller.dart';
import '../../util/constants/constants.dart';
import '../../util/size-config.dart';
import 'drawer.dart';


class PendingInvites extends StatelessWidget {

  static const String id = "pendingInvites";
  PendingInvites({Key? key}) : super(key: key);

  /// calling the [DashboardController] for [PendingInvites]
  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Obx(() => Scaffold(
        appBar: buildAppBarWithNotification(textTheme, context, controller.userName.value),
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

class ReusablePendingInviteButton extends StatelessWidget {

  const ReusablePendingInviteButton({
    Key? key,
  }) : super(key: key);

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
                            text: '#12345678',
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
                        color: neutralColor.withOpacity(0.5),
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
                      onPressed: () {},
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
                      onPressed: () {},
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
}
