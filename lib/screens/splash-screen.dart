import 'dart:async';

import 'package:flex_my_way/screens/onboarding/onboarding-screen.dart';
import 'package:flutter/material.dart';
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
    Timer(const Duration(seconds: 5), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.getBool('loggedIn') == true
          ? Navigator.pushReplacementNamed(context, Dashboard.id)
          : Navigator.pushNamed(context, OnboardingScreen.id);
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
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              splashImage,
            ),
            fit: BoxFit.cover
          ),
        ),
      ),
    );
  }
}
