import 'package:flex_my_way/util/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../components/app-bar.dart';

class Notifications extends StatefulWidget {

  static const String id = "notifications";
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  /// Bool variable to hold the state of the expanded panel
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: buildAppBar(context, textTheme, 'Notifications'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24),
          child: Column(
            children: [
              NotificationButton(
                title: 'Please contact the customer care as we noticed an authorized access to your account',
                onPressed: () {
                  setState(() => _expanded = !_expanded);
                },
                expanded: _expanded,
              ),
              NotificationButton(
                title: 'Please contact the customer care as we noticed an authorized access to your account',
                onPressed: () {
                  setState(() => _expanded = !_expanded);
                },
                expanded: _expanded,
              ),
              NotificationButton(
                title: 'Please contact the customer care as we noticed an authorized access to your account',
                onPressed: () {
                  setState(() => _expanded = !_expanded);
                },
                expanded: _expanded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationButton extends StatelessWidget {

  final void Function() onPressed;
  final String title;
  final bool expanded;

  const NotificationButton({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.expanded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: AnimatedContainer(
            height: expanded == true ? 125 : 72,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(24.0),
            ),
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastOutSlowIn,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      expanded == false
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                      size: 21,
                      color: whiteColor,
                    ),
                    expanded == true
                      ? Padding(
                          padding: EdgeInsets.only(top: 12.0),
                          child: GestureDetector(
                            onTap: () {
                              print('delete notification');
                            },
                            child: const Icon(
                              IconlyBold.delete,
                              size: 19,
                              color: whiteColor,
                            ),
                          ),
                      )
                      : Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

