import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flex_my_way/screens/host/host_a_flex.dart';
import 'package:flex_my_way/screens/host/host_registration.dart';
import 'package:flutter/material.dart';
import '../util/constants/constants.dart';
import '../util/constants/strings.dart';
import '../util/size-config.dart';
import 'join/join.dart';

class FindAFlex extends StatelessWidget {

  static const String id = "findAFlex";
  const FindAFlex({Key? key}) : super(key: key);

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
            const SizedBox(height: 50),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, HostRegistration.id),
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
                    onTap: () => Navigator.pushNamed(context, Join.id),
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
            ),
          ],
        ),
      ),
    );
  }
}
