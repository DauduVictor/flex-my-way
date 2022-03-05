import 'package:flutter/material.dart';
import '../../components/app-bar.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/strings.dart';
import '../../util/size-config.dart';

class PrivacyPolicy extends StatefulWidget {

  static const String id = "privacyPolicy";
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: buildAppBar(context, textTheme, AppStrings.privacyPolicy),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          padding: const EdgeInsets.fromLTRB(2, 24, 2, 10),
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(24)),
          child: const RawScrollbar(
            thumbColor: primaryColor,
            radius: Radius.circular(8.0),
            thickness: 4.0,
            isAlwaysShown: true,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Text(AppStrings.loremIpsum + AppStrings.loremIpsum + AppStrings.loremIpsum),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
