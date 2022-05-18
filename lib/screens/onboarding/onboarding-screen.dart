import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flex_my_way/util/util.dart';
import '../find-a-flex.dart';

class OnboardingScreen extends StatefulWidget {

  static const String id = "onboardingScreen";
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  /// Function to navigate after the splash screen loader ends
  void _navigate()  {
    Timer(const Duration(microseconds: 6), () {
      setState(() {
        _width = 0;
      });
      _navigateTo();
    });
  }

  void _navigateTo() {
    Timer(const Duration(seconds: 5), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('onBoarded', true);
      Get.offAndToNamed(FindAFlex.id);
    });
  }

  double  _width = 1;

  @override
  void initState() {
    _navigate();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              splashImage,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              AppStrings.celebrateTogether,
              style: textTheme.headline5!.copyWith(color: whiteColor),
            ),
            const SizedBox(height: 24),
            Text(
              AppStrings.flexMyWay,
              style: textTheme.headline1!.copyWith(
                fontSize: 100,
                color: whiteColor, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),
            Container(
              height: 10,
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white12,
              ),
              child: AnimatedContainer(
                margin: EdgeInsets.only(right: SizeConfig.screenWidth!.toDouble() * _width),
                curve: Curves.bounceInOut,
                duration: const Duration(milliseconds: 4950),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

