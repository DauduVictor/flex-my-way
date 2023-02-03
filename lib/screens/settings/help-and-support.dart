import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../components/app-bar.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/strings.dart';
import '../../util/size-config.dart';

class HelpAndSupport extends StatelessWidget {

  static const String id = "helpAndSupport";
  const HelpAndSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: buildAppBar(context, textTheme, AppStrings.helpAndSupport),
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        padding: const EdgeInsets.only(top: 40, bottom: 90.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(helpHeadSetImage),
                const SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! * 0.22),
                  child: Text(
                    'How can we help you?',
                    textAlign: TextAlign.center,
                    style: textTheme.button!.copyWith(fontSize: 26),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: primaryColor.withOpacity(0.2),
                  radius: 40,
                  child: const Icon(
                    Icons.phone_android,
                    color: primaryColor,
                    size: 26,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Call us on',
                  style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  '09023130910',
                  style: textTheme.button!.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: primaryColor.withOpacity(0.2),
                  radius: 40,
                  child: const Icon(
                    IconlyBold.message,
                    color: primaryColor,
                    size: 26,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Send us an e-mail',
                  style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  'hello@flexmyway.com',
                  style: textTheme.button!.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

