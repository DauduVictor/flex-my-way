import 'package:flex_my_way/screens/flex-media/flexery.dart';
import 'package:flex_my_way/screens/settings/privacy-policy.dart';
import 'package:flex_my_way/screens/settings/terms-and-condition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flex_my_way/util/util.dart';
import '../find-a-flex.dart';
import '../flex-history/flex-history.dart';
import '../settings/settings.dart';
import 'dashboard.dart';
import 'package:flex_my_way/controllers/controllers.dart';

class RefactoredDrawer extends StatelessWidget {

  RefactoredDrawer({Key? key}) : super(key: key);

  /// calling the user controller [UserController]
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Drawer(
      backgroundColor: const Color(0xFFC4C4C4),
      child: Container(
        color: backgroundColor,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(30, 30, 24, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(17),
                        child: Icon(
                          Icons.close_rounded,
                          color: primaryColor,
                          size: 31,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppStrings.flexId,
                    style: textTheme.bodyText1,
                  ),
                  const SizedBox(height: 3.5),
                  Text(
                    '#0123456789',
                    style: textTheme.headline5!.copyWith(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DrawerButton(
                      routeName: 'Home',
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        Get.back();
                        Get.toNamed(Dashboard.id);
                      },
                    ),
                    DrawerButton(
                      routeName: 'Join/Host a Flex',
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        Get.back();
                        Get.toNamed(FindAFlex.id);
                      },
                    ),
                    DrawerButton(
                      routeName: 'Flexery',
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        Get.back();
                        Get.toNamed(Flexery.id);
                      },
                    ),
                    DrawerButton(
                      routeName: AppStrings.settings,
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        Get.back();
                        Get.toNamed(Settings.id);
                      },
                    ),
                    DrawerButton(
                      routeName: 'Flex History',
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        Get.back();
                        Get.toNamed(FlexHistory.id);
                      },
                    ),
                    // DrawerButton(
                    //   routeName: 'FlexGuard (Coming Soon)',
                    //   onPressed: () {},
                    // ),
                    // DrawerButton(
                    //   routeName: 'FlexMe (Coming Soon)',
                    //   onPressed: () {},
                    // ),
                    // DrawerButton(
                    //   routeName: 'FlexVend (Coming Soon)',
                    //   onPressed: () {},
                    // ),
                    // DrawerButton(
                    //   routeName: 'Flexvite (Coming Soon)',
                    //   onPressed: () {},
                    // ),
                    // DrawerButton(
                    //   routeName: 'FlexPromo (Coming  Soon)',
                    //   onPressed: () {},
                    // ),
                  ],
                ),
              ),
            ),
            /// legal
            Container(
              width: SizeConfig.screenWidth,
              padding: const EdgeInsets.fromLTRB(30, 0, 24, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Legal',
                    style: textTheme.bodyText1!.copyWith(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.toNamed(TermsAndCondition.id);
                    },
                    child: Text(
                      AppStrings.termsAndConditions,
                      style: textTheme.bodyText1!.copyWith(
                        color: neutralColor.withOpacity(0.5),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.toNamed(PrivacyPolicy.id);
                    },
                    child: Text(
                      AppStrings.privacyPolicy,
                      style: textTheme.bodyText1!.copyWith(
                        color: neutralColor.withOpacity(0.5),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerButton extends StatelessWidget {

  final String routeName;
  final void Function() onPressed;

  const DrawerButton({
    Key? key,
    required this.routeName,
    required this.onPressed
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.fromLTRB(30, 12, 24, 12),
          ),
          child: SizedBox(
            width: SizeConfig.screenWidth,
            child: Text(
              routeName,
              style: textTheme.bodyText1!.copyWith(fontSize: 21, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
