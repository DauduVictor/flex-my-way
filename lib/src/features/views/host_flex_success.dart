import 'package:flex_my_way/src/content/constants/constants.dart';
import 'package:flex_my_way/src/content/utilities/app_images.dart';
import 'package:flex_my_way/src/shared/widgets/custom_elevated_button.dart';
import 'package:flex_my_way/src/shared/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HostFlexSuccess extends StatelessWidget {
  const HostFlexSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 60,
          bottom: 30,
          left: 30,
          right: 30,
        ),
        child: SingleChildScrollView(
          child: Consumer(
            builder: (_, ref, __) {
              // final viewModel = ref.watch();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppSvgs.successImage),
                  const Spacing.largeHeight(),
                  Text(
                    AppStrings.congratulations,
                    style: textTheme.headline4,
                  ),
                  const Spacing.tinyHeight(),
                  Text(
                    AppStrings.yourFlexIsLive,
                    style: textTheme.headline4,
                  ),
                  const Spacing.largeHeight(),
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
                  const Spacing.bigHeight(),
                  const Text(AppStrings.clickTheirIcon),
                  const Spacing.bigHeight(),
                  const Text(AppStrings.youCanAlsoShare),
                  const Spacing.bigHeight(),
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
                                        .copyWith(fontWeight: FontWeight.w600))
                              ]),
                        ),
                        const Spacing.bigHeight(),
                        const Text(AppStrings.clickTheBelow),
                        const Spacing.bigHeight(),
                        Text(
                          AppStrings.flexURL,
                          style: textTheme.bodyText2!
                              .copyWith(color: AppColors.primaryColor),
                        )
                      ],
                    ),
                  ),
                  const Spacing.bigHeight(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.primaryColorVariant,
                          ),
                          child: Center(
                              child: Text(
                            AppStrings.betaSMSCaps,
                            style: textTheme.bodyText2!.copyWith(
                              color: AppColors.whiteTextColor,
                            ),
                          )),
                        ),
                      ),
                      const Spacing.bigWidth(),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.primaryColorVariant,
                          ),
                          child: Center(
                            child: SvgPicture.asset(AppSvgs.shareIcon),
                          ),
                        ),
                      ),
                      const Spacing.bigWidth(),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.primaryColorVariant,
                          ),
                          child: Center(
                            child: SvgPicture.asset(AppSvgs.copyIcon),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacing.bigHeight(),
                  CustomElevatedButton(
                    label: AppStrings.goHome,
                    onPressed: () {},
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
