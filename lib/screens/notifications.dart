import 'package:flex_my_way/util/constants/constants.dart';
import 'package:flutter/material.dart';
import '../components/app-bar.dart';

class Notifications extends StatefulWidget {

  static const String id = "notifications";
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: buildAppBar(context, textTheme, 'Notifications'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24),
          child: Container(
            color: Colors.black,
            child: ExpansionPanelList(
              animationDuration: const Duration(milliseconds:700),
              expandedHeaderPadding: const EdgeInsets.all(0),
              children: [
                ExpansionPanel(
                  backgroundColor: primaryColor,
                  canTapOnHeader: true,
                  body: const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 7, 15),
                    child: Text(
                      'You’ve got a text from our sur team. Head over there.This is an example of the expanded body',
                      style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return const Padding(
                      padding: EdgeInsets.fromLTRB(15, 8, 0, 10),
                      child: Text(
                        'You’ve got a message from our support team. Head over there.',
                        style: TextStyle(
                          color: whiteColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    );
                  },
                  isExpanded: false,
                ),
              ],
              // expansionCallback: (int item, bool status) {
              //   setState(() {
              //   });
              // },
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationButton extends StatelessWidget {

  final void Function() onPressed;
  final String title;

  const NotificationButton({
    Key? key,
    required this.onPressed,
    required this.title,
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
                  title,
                  style: const TextStyle(
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

