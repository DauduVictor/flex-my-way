import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/app-bar.dart';
import '../../components/list-tile-button.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/functions.dart';
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
                onPressed: () {
                  try {
                    launchUrl(Uri.parse('https://twitter.com/Flexmyway_?t=9pI10WbIB4-5FrxbwUWKTg&s=08'));
                  } catch (e) {
                    Functions.showMessage(e.toString());
                  }
                },
                title: 'Twitter',
              ),
              ListTileButton(
                onPressed: () {
                  try {
                    launchUrl(Uri.parse('https://instagram.com/flexmyway_account?igshid=ZDdkNTZiNTM='));
                  } catch (e) {
                    Functions.showMessage(e.toString());
                  }
                },
                title: 'Instagram',
              ),
              Visibility(
                visible: false,
                child: ListTileButton(
                  onPressed: () { },
                  title: 'Telegram',
                ),
              ),
              ListTileButton(
                onPressed: () {
                  try {
                    launchUrl(Uri.parse('https://wa.me/qr/LL223LZI2I6JF1'));
                  } catch (e) {
                    Functions.showMessage(e.toString());
                  }
                },
                title: 'Whatsapp',
              ),
              Visibility(
                visible: false,
                child: ListTileButton(
                  onPressed: () { },
                  title: 'TikTok',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
