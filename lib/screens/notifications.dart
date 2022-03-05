import 'package:flex_my_way/util/constants/constants.dart';
import 'package:flutter/material.dart';
import '../components/app-bar.dart';
import '../components/list-tile-button.dart';

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
          child: Column(
            children: [
              ListTileButton(
                onPressed: () { },
                title: 'You’ve got a message from our support team. Head over there.',
              ),
              ListTileButton(
                onPressed: () { },
                title: 'Afro Nation Flex is happening in 2 hours. Feel the flex.',
              ),
              ListTileButton(
                onPressed: () { },
                title: 'You’ve got a message from our support team. Head over there.',
              ),
              ListTileButton(
                onPressed: () { },
                title: 'You’ve got a message from our support team. Head over there.',
              ),
              ListTileButton(
                onPressed: () { },
                title: 'Afro Nation Flex is happening in 2 hours. Feel the flex.',
              ),
              ListTileButton(
                onPressed: () { },
                title: 'You’ve got a message from our support team. Head over there.',
              ),
              ListTileButton(
                onPressed: () { },
                title: 'You’ve got a message from our support team. Head over there.',
              ),
              ListTileButton(
                onPressed: () { },
                title: 'Afro Nation Flex is happening in 2 hours. Feel the flex.',
              ),
              ListTileButton(
                onPressed: () { },
                title: 'You’ve got a message from our support team. Head over there.',
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
