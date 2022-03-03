import 'package:flex_my_way/components/reusable-button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/strings.dart';

class HostFlexSuccess extends StatelessWidget {

  static const String id = "hostFlexSuccess";
  const HostFlexSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
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
              RichText(
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
              const Text(AppStrings.clickTheirIcon),
              const SizedBox(height: 24),
              const Text(AppStrings.youCanAlsoShare),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    RichText(
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
                    const Text(AppStrings.clickTheBelow),
                    const SizedBox(height: 24),
                    Text(
                      AppStrings.flexURL,
                      style: textTheme.bodyText2!
                          .copyWith(color: primaryColor),
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
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primaryColorVariant,
                      ),
                      child: Center(
                        child: SvgPicture.asset(shareIcon),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primaryColorVariant,
                      ),
                      child: Center(
                        child: SvgPicture.asset(copyIcon),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Button(
                label: AppStrings.goHome,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
