import 'package:flex_my_way/screens/host/host_a_flex.dart';
import 'package:flex_my_way/screens/host/host_registration.dart';
import 'package:flutter/material.dart';
import '../util/constants/constants.dart';
import '../util/constants/strings.dart';
import '../util/size-config.dart';

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
              onBoardingImage,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            Center(
              child: Text(
                AppStrings.youDeyGround,
                textAlign: TextAlign.center,
                style: textTheme.headline1!.copyWith(
                  color: whiteColor,
                  fontSize: 60,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
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
                CircleAvatar(
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
              ],
            )
          ],
        ),
      ),
    );
  }
}
