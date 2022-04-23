import 'dart:async';
import 'package:flex_my_way/screens/find-a-flex.dart';
import 'package:flex_my_way/screens/onboarding/onboarding-screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../util/constants/constants.dart';
import '../util/size-config.dart';
import 'dashboard/dashboard.dart';

class SplashScreen extends StatefulWidget {

  static const String id = "splashScreen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  /// Function to navigate to the next screen after the splash screen is completed
  void _navigate() {
    Timer(const Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.getBool('loggedIn') == true
        ? Get.offAndToNamed(Dashboard.id)
        : Get.offAndToNamed(FindAFlex.id);
      // if (prefs.getBool('loggedIn') == true) {
      //   Navigator.pushReplacementNamed(context, Dashboard.id);
      // }
      // else if (prefs.getBool('onBoarded') == false) {
      //   Navigator.pushReplacementNamed(context, OnboardingScreen.id);
      // }
      // Navigator.pushReplacementNamed(context, FindAFlex.id);
    });
  }

  @override
  void initState() {
    _navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        color: splashBackgroundColor,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Flexmyway',
                style: textTheme.headline2!.copyWith(
                  color: whiteColor,
                  fontSize: 50,
                  fontFamily: 'Neon',
                ),
              ),
              SizedBox(
                height: 75,
                width: 60,
                child: Image.asset(
                  splashScreenLocationImage2,
                ),
              ),
              // SvgPicture.asset(uploadIcon),
            ],
          ),
        ),
      ),
    );
  }
}
