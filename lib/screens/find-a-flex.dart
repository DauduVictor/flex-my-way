import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flex_my_way/screens/host/host-a-flex.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../util/constants/constants.dart';
import '../util/constants/strings.dart';
import '../util/size-config.dart';
import 'join/join.dart';
import 'onboarding/login.dart';

class FindAFlex extends StatefulWidget {

  static const String id = "findAFlex";
  const FindAFlex({Key? key}) : super(key: key);

  @override
  State<FindAFlex> createState() => _FindAFlexState();
}

class _FindAFlexState extends State<FindAFlex> {

  /// Bool variable to hold the bool state if the user is currently logged in
  bool isLoggedIn = false;

  /// function to check if the user is currently logged in
  void checkUserIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      if(prefs.getBool('loggedIn') == true) {
        setState(() {
          isLoggedIn = true;
        });
      }
  }

  @override
  void initState() {
    checkUserIsLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: splashBackgroundColor,
      body: Container(
        padding: const EdgeInsets.all(30.0),
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
          children: [
            const SizedBox(height: 30),
            isLoggedIn == true
              ? Align(
                alignment: Alignment.topLeft,
                child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 22,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(left: 8),
                        shape: const CircleBorder(),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: whiteColor,
                        size: 22,
                      ),
                    ),
                  ),
              )
              : const SizedBox(height: 30),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.6,
              child: Center(
                child: DefaultTextStyle(
                  style: textTheme.headline1!.copyWith(
                    color: whiteColor,
                    fontSize: 60,
                    fontWeight: FontWeight.w500,
                  ),
                  child: AnimatedTextKit(
                    repeatForever: true,
                    pause: const Duration(milliseconds: 300),
                    animatedTexts: [
                      FadeAnimatedText(
                        AppStrings.youDeyGround,
                        textAlign: TextAlign.center,
                        duration: const Duration(seconds: 4),
                      ),
                      FadeAnimatedText(
                        AppStrings.hostPartyWithEase,
                        textAlign: TextAlign.center,
                        duration: const Duration(seconds: 4),
                      ),
                      FadeAnimatedText(
                        AppStrings.inviteAFriend,
                        textAlign: TextAlign.center,
                        duration: const Duration(seconds: 4),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () => Get.toNamed(HostAFlex.id),
                        child: CircleAvatar(
                          backgroundColor: whiteColor,
                          radius: 42,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: splashBackgroundColor,
                            child: Text(
                              AppStrings.host,
                              style: textTheme.headline6!.copyWith(
                                  color: whiteColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(Join.id),
                        child: CircleAvatar(
                          backgroundColor: whiteColor,
                          radius: 42,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: whiteColor,
                            child: Text(
                              AppStrings.join,
                              style: textTheme.headline6!.copyWith(
                                  color: splashBackgroundColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  isLoggedIn == false
                    ? Column(
                        children: [
                          SizedBox(height: SizeConfig.screenHeight! * 0.08),
                          Text(
                            'Have an account already?',
                            style: textTheme.bodyText1!.copyWith(
                              color: whiteColor,
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 5),
                          GestureDetector(
                            onTap: () => Get.toNamed(Login.id),
                            child: Text(
                              'Login here',
                              style: textTheme.button!.copyWith(
                                color: whiteColor,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}