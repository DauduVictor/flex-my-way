import 'dart:async';
import 'dart:io';

import 'package:flex_my_way/util/size-config.dart';
import 'package:flutter/material.dart';
import '../util/constants/constants.dart';
import '../util/constants/strings.dart';
import 'find-a-flex.dart';

class SplashScreen extends StatefulWidget {

  static const String id = "splashScreen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  /// Function to navigate after the splash screen loader ends
  void _navigate() {
    Timer(const Duration(microseconds: 10), () {
      setState(() {
        _width = 0;
      });
      _navigateTo();
    });
  }

  void _navigateTo() {
    Timer(const Duration(seconds: 5), () {
      Navigator.pushNamed(context, FindAFlex.id);
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
      backgroundColor: splashBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
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

