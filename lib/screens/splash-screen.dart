import 'dart:async';
import 'package:flex_my_way/components/components.dart';
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
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Center(
              child: Text(
                'Flexmyway',
                style: textTheme.headline2!.copyWith(
                  color: whiteColor,
                  fontSize: 48.5,
                  fontFamily: 'Neon',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              child: const CircleProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }
}

///Function to get if user has been onboarded with help of
/// [SharedPreferences]
void getBoolFromSp() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //check if user is first time user
  if (prefs.getBool('isFirstTimeUser') == false) {
    await prefs.setBool('isFirstTimeUser', true);
  } else {
    await prefs.setBool('isFirstTimeUser', true);
  }
  if (prefs.getBool('onBoarded') == true) {
    if (prefs.getBool('loggedIn') == true) {
      var futureValue = FutureValues();
      Future<User> user = futureValue.getCurrentUser();
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
    } else {
      Get.offAndToNamed(FindAFlex.id);
    }
  } else {
    Get.offAndToNamed(OnboardingScreen.id);
  }
}
