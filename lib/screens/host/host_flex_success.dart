import 'package:flex_my_way/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/strings.dart';
import '../../util/size-config.dart';
import '../onboarding/login.dart';

class HostFlexSuccess extends StatelessWidget {

  static const String id = "hostFlexSuccess";
  const HostFlexSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 60, 30, 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(successImage),
              const SizedBox(height: 32),
              Text(
                AppStrings.congratulations,
                style: textTheme.headline4,
              ),
              const SizedBox(height: 4),
              Text(
                AppStrings.yourFlexIsLive,
                style: textTheme.headline4,
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text: AppStrings.importSelected,
                        style: textTheme.bodyText2,
                        children: [
                          TextSpan(
                            text: AppStrings.betaSMS,
                            style: textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: AppStrings.bothAtVery,
                            style: textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      AppStrings.clickTheirIcon,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      AppStrings.youCanAlsoShare,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 32),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: whiteColor,
                      ),
                      child: Column(
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: AppStrings.kelechiMo,
                              style: textTheme.bodyText2!
                                  .copyWith(fontWeight: FontWeight.w600),
                              children: [
                                TextSpan(
                                    text: AppStrings.isInviting,
                                    style: textTheme.bodyText2),
                                TextSpan(
                                  text: AppStrings.invitingDate,
                                  style: textTheme.bodyText2!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            AppStrings.clickTheBelow,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            AppStrings.flexURL,
                            textAlign: TextAlign.center,
                            style: textTheme.bodyText2!.copyWith(color: primaryColor),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(19),
                              backgroundColor: primaryColorVariant,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )
                          ),
                          child: Center(
                            child: Text(
                              AppStrings.betaSMSCaps,
                              style: textTheme.bodyText2!.copyWith(
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(19),
                            backgroundColor: primaryColorVariant,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Icon(
                            Icons.share_rounded,
                            size: 35,
                            color: whiteColor,
                          ),
                        ),
                        const SizedBox(width: 24),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(19),
                              backgroundColor: primaryColorVariant,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )
                          ),
                          child: const Icon(
                            Icons.file_copy,
                            size: 35,
                            color: whiteColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.screenHeight! * 0.05),
                    Button(
                      label: AppStrings.goHome,
                      onPressed: () {
                        Navigator.pushNamed(context, Login.id);
                      },
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
