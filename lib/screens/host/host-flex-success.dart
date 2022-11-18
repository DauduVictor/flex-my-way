import 'package:flex_my_way/components/button.dart';
import 'package:flex_my_way/model/flex.dart';
import 'package:flex_my_way/screens/flex-history/flex-history-detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../dashboard/dashboard.dart';
import 'package:flex_my_way/util/util.dart';
import 'package:flex_my_way/controllers/controllers.dart';
import '../onboarding/login.dart';
import 'package:share_plus/share_plus.dart';
import 'beta-sms.dart';

class HostFlexSuccess extends StatelessWidget {

  static const String id = "hostFlexSuccess";
  HostFlexSuccess({Key? key}) : super(key: key);

  /// calling the [HostController] for [HostFlexSuccess]
  final HostController hostController = Get.put(HostController());

  /// calling the [AccountController] for [HostFlexSuccess]
  final UserController accountController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 60, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(successImage),
              const SizedBox(height: 32),
              Text(
                AppStrings.congratulations,
                style: textTheme.headline5!.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                AppStrings.yourFlexIsLive,
                textAlign: TextAlign.center,
                style: textTheme.headline5!.copyWith(fontWeight: FontWeight.w600),
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
                          Obx(() {
                              return RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: accountController.username.value,
                                  style: textTheme.bodyText2!
                                      .copyWith(fontWeight: FontWeight.w600),
                                  children: [
                                    TextSpan(
                                        text: AppStrings.isInviting,
                                        style: textTheme.bodyText2),
                                    TextSpan(
                                      text: Functions.getFormattedDateTimeText(hostController.dateController.text),
                                      style: textTheme.bodyText2!
                                          .copyWith(fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              );
                            }
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            AppStrings.clickTheBelow,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          GestureDetector(
                            onTap: () {
                              // Get.to(() => FlexHistoryDetail(flexSuccess: hostController.createdFlex!));
                            },
                            child: Text(
                              AppStrings.flexURL,
                              textAlign: TextAlign.center,
                              style: textTheme.bodyText2!.copyWith(color: primaryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            // Get.toNamed(BetaSms.id);
                            Functions.showMessage('This feature will be available soon!!');
                          },
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
                        TextButton(
                          onPressed: () {
                            Share.share('check out my app https://flexmyway.com');
                          },
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
                        TextButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                                text: hostController.createdFlex!.joinCode!)).then((value) {
                                  Functions.showMessage('Flex link copied');
                            }).catchError((e){
                              Functions.showMessage('Could not copy flex link');
                            });
                          },
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
                        Get.delete<HostController>();
                        Get.offAllNamed(Dashboard.id);
                      },
                    ),
                    const SizedBox(height: 40),
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
