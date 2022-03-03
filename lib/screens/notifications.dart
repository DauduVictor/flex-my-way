import 'package:flex_my_way/util/constants/constants.dart';
import 'package:flex_my_way/util/fonts.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {

  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 75,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
        ),
        backgroundColor: backgroundColor,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: lightTextColor,
            size: 17,
          ),
          onPressed: () {},
        ),
        title: Text(
          'Notifications',
          style: textTheme.headline4!.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24),
          child: Column(
            children: [
              ReusableNotificationButton(
                onPressed: () { },
                notificationTitle: 'You’ve got a message from our support team. Head over there.',
              ),
              ReusableNotificationButton(
                onPressed: () { },
                notificationTitle: 'Afro Nation Flex is happening in 2 hours. Feel the flex.',
              ),
              ReusableNotificationButton(
                onPressed: () { },
                notificationTitle: 'You’ve got a message from our support team. Head over there.',
              ),
              ReusableNotificationButton(
                onPressed: () { },
                notificationTitle: 'You’ve got a message from our support team. Head over there.',
              ),
              ReusableNotificationButton(
                onPressed: () { },
                notificationTitle: 'Afro Nation Flex is happening in 2 hours. Feel the flex.',
              ),
              ReusableNotificationButton(
                onPressed: () { },
                notificationTitle: 'You’ve got a message from our support team. Head over there.',
              ),
              ReusableNotificationButton(
                onPressed: () { },
                notificationTitle: 'You’ve got a message from our support team. Head over there.',
              ),
              ReusableNotificationButton(
                onPressed: () { },
                notificationTitle: 'Afro Nation Flex is happening in 2 hours. Feel the flex.',
              ),
              ReusableNotificationButton(
                onPressed: () { },
                notificationTitle: 'You’ve got a message from our support team. Head over there.',
              ),
              const SizedBox(height: 8),
              Text(
                'That’s all you’ve got for now',
                style: TextStyle(
                  color: neutralColor.withOpacity(0.4),
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableNotificationButton extends StatelessWidget {

  final void Function() onPressed;
  final String notificationTitle;

  const ReusableNotificationButton({
    Key? key,
    required this.onPressed,
    required this.notificationTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  notificationTitle,
                  style: TextStyle(
                    color: whiteColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Icon(
                  Icons.chevron_right_rounded,
                  size: 21,
                  color: whiteColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
