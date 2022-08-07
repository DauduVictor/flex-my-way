import 'dart:async';
import 'package:flex_my_way/screens/find-a-flex.dart';
import 'package:flex_my_way/screens/onboarding/onboarding-screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flex_my_way/util/util.dart';
import '../bloc/future-values.dart';
import '../model/user.dart';
import 'dashboard/dashboard.dart';
import 'onboarding/login.dart';

class SplashScreen extends StatefulWidget {

  static const String id = "splashScreen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  /// Function to navigate to the next screen after the splash screen is completed
  void _navigate() {
    Timer(const Duration(milliseconds: 1500), () => getBoolFromSp());
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
  ///Function to get if user has been onboarded with help of
  /// [SharedPreferences]
  void getBoolFromSp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('onBoarded') == true) {
      if (prefs.getBool('loggedIn') == true) {
        var _futureValue = FutureValues();
        Future<User> user = _futureValue.getCurrentUser();
        try {
          await user.then((value) async {
            if (value.id == null) {
              Get.offAndToNamed(Login.id);
            } else {
              Get.offAndToNamed(Dashboard.id);
            }
          });
        } catch (e) {
          Get.offAndToNamed(Login.id);
        }
      }
      else {
        Get.offAndToNamed(FindAFlex.id);
      }
    } else {
      Get.offAndToNamed(OnboardingScreen.id);
    }
  }
