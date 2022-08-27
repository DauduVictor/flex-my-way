import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../screens/dashboard/notifications.dart';
import '../util/constants/constants.dart';

AppBar buildAppBarWithNotification(
    TextTheme textTheme,
    BuildContext context,
    String userName
    ) {
  return AppBar(
    leadingWidth: 70,
    iconTheme: const IconThemeData(
      color: neutralColor,
    ),
    title: Text(
      'Hi, $userName',
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
                      return Notifications();
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
  );
}

AppBar buildAppBar(
    BuildContext context,
    TextTheme textTheme,
    String title,
    {bool? centerTitle}
    ) {
  return AppBar(
    toolbarHeight: 75,
    leadingWidth: 80,
    titleSpacing: 3,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30.0),
        bottomRight: Radius.circular(30.0),
      ),
    ),
    centerTitle: centerTitle ?? false,
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back_ios,
        color: lightTextColor,
        size: 21,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: Text(
      title,
      style: textTheme.headline5!.copyWith(fontSize: 23.5, fontWeight: FontWeight.w600),
    ),
  );
}
