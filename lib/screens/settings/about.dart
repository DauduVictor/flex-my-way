import 'package:flutter/material.dart';
import '../../components/app-bar.dart';
import '../../components/list-tile-button.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/strings.dart';

class About extends StatelessWidget {

  static const String id = "about";
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: buildAppBar(context, textTheme, AppStrings.about),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24),
          child: Column(
            children: [
              ListTileButton(
                onPressed: () { },
                title: 'Twitter',
              ),
              ListTileButton(
                onPressed: () { },
                title: 'Instagram',
              ),
              ListTileButton(
                onPressed: () { },
                title: 'Telegram',
              ),
              ListTileButton(
                onPressed: () { },
                title: 'Whatsapp',
              ),
              ListTileButton(
                onPressed: () { },
                title: 'TikTok',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
