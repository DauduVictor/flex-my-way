import 'dart:developer';
import 'package:flex_my_way/networking/networking.dart';
import 'package:flex_my_way/screens/settings/help-and-support.dart';
import 'package:flex_my_way/screens/settings/privacy-policy.dart';
import 'package:flex_my_way/screens/settings/terms-and-condition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:flex_my_way/components/components.dart';
import '../../controllers/setting-controller.dart';
import 'package:flex_my_way/util/util.dart';
import '../dashboard/drawer.dart';
import '../splash-screen.dart';
import 'about.dart';
import 'edit-profile-detail.dart';

class Settings extends StatelessWidget {

  static const String id = "settings";
  Settings({Key? key}) : super(key: key);

  /// calling the onboarding controller for [SettingsController]
  final SettingsController controller = Get.put(SettingsController());

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Obx(() => Scaffold(
          appBar: buildAppBarWithNotification(textTheme, context, controller.userName.value),
          drawer: RefactoredDrawer(),
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
            },
            child: Column(
              children: [
                Container(
                  width: SizeConfig.screenWidth,
                  padding: const EdgeInsets.fromLTRB(27, 12, 20, 15),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: appBarBottomBorder,
                  ),
                  child: Text(
                    AppStrings.settings,
                    style: textTheme.headline5!.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                if (controller.canHostFlex.value == false) Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                  child: ListTileButton(
                    title: AppStrings.becomeAHost,
                    onPressed: () {

                    },
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: AbsorbPointer(
                      absorbing: controller.showSpinner.value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                        child: Column(
                          children: [
                            ReusableSettingsButton(
                              name: AppStrings.editProfileDetails,
                              icon: IconlyLight.edit,
                              onPressed: () {
                                Get.toNamed(EditProfileDetail.id);
                              },
                            ),
                            AnimatedCrossFade(
                              duration: const Duration(milliseconds: 500),
                              firstCurve: Curves.easeIn,
                              secondCurve: Curves.fastOutSlowIn,
                              crossFadeState: controller.showEditPassword.value == false
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                              firstChild: ReusableSettingsButton(
                                name: AppStrings.editPassword,
                                icon: IconlyBroken.unlock,
                                onPressed: () {
                                  controller.showEditPassword.toggle();
                                },
                              ),
                              secondChild: Column(
                                children: [
                                  ReusableSettingsButton(
                                    name: AppStrings.editPassword,
                                    icon: IconlyBroken.unlock,
                                    onPressed: () {
                                      controller.showEditPassword.toggle();
                                    },
                                  ),
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        CustomTextFormField(
                                          hintText: AppStrings.enterCurrentPassword,
                                          textInputAction: TextInputAction.next,
                                          obscureText: controller.obscureCurrentPassword.value,
                                          keyboardType: TextInputType.visiblePassword,
                                          textEditingController: controller.currentPasswordController,
                                          suffix: GestureDetector(
                                            onTap: () {
                                              controller.obscureCurrentPassword.toggle();
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(0,17.5 ,10 ,0),
                                              child: Text(
                                                controller.obscureCurrentPassword.value == true ? 'SHOW' : 'HIDE',
                                                style: textTheme.button!.copyWith(
                                                  fontSize: 14,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          validator: (value) {
                                            if(value!.isEmpty) {
                                              return 'This field is required';
                                            }
                                            else if(value.length < 4) {
                                              return 'Password length too short';
                                            }
                                            return null;
                                          },
                                        ),
                                        CustomTextFormField(
                                          hintText: AppStrings.enterNewPassword,
                                          keyboardType: TextInputType.visiblePassword,
                                          textInputAction: TextInputAction.done,
                                          obscureText: controller.obscureNewPassword.value,
                                          textEditingController: controller.newPasswordController,
                                          suffix: GestureDetector(
                                            onTap: () {
                                              controller.obscureNewPassword.value = !controller.obscureNewPassword.value;
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(0,17.5 ,10 ,0),
                                              child: Text(
                                                controller.obscureNewPassword.value == true ? 'SHOW' : 'HIDE',
                                                style: textTheme.button!.copyWith(
                                                  fontSize: 14,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          validator: (value) {
                                            if(value.toString() != controller.currentPasswordController.text) {
                                              return 'Confirm your password';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Button(
                                      label: AppStrings.save,
                                      onPressed: () {
                                        FocusScopeNode currentFocus = FocusScope.of(context);
                                        if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
                                        if(_formKey.currentState!.validate()){
                                          _editPassword();
                                        }
                                      },
                                      child: controller.showSpinner.value == true
                                        ? const SizedBox(
                                          height: 21,
                                          width: 19,
                                          child: CircleProgressIndicator())
                                        : null,
                                    ),
                                  ),
                                  const SizedBox(height: 21),
                                ],
                              ),
                            ),
                            ReusableSettingsButton(
                              name: AppStrings.inviteYourFriends,
                              icon: Icons.share_outlined,
                              onPressed: () {},
                            ),
                            ReusableSettingsButton(
                              name: AppStrings.about,
                              icon: Icons.lightbulb_outline,
                              onPressed: () {
                                Get.toNamed(About.id);
                              },
                            ),
                            ReusableSettingsButton(
                              name: AppStrings.termsAndConditions,
                              icon: IconlyLight.dangerCircle,
                              onPressed: () {
                                Get.toNamed(TermsAndCondition.id);
                              },
                            ),
                            ReusableSettingsButton(
                              name: AppStrings.privacyPolicy,
                              icon: IconlyLight.paper,
                              onPressed: () {
                                Get.toNamed(PrivacyPolicy.id);
                              },
                            ),
                            ReusableSettingsButton(
                              name: AppStrings.helpAndSupport,
                              icon: IconlyLight.shieldDone,
                              onPressed: () {
                                Get.toNamed(HelpAndSupport.id);
                              },
                            ),
                            ReusableSettingsButton(
                              name: AppStrings.logOut,
                              icon: IconlyLight.logout,
                              onPressed: () {
                                _showLogOutDialog(textTheme, context);
                              },
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    )
                  ),
                ),
              ],
            )
          ),
        )
    );
  }

  ///widget to prompt user if they want to logout
  Future<void> _showLogOutDialog(TextTheme textTheme, BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: Text(
          AppStrings.logOut,
          style: textTheme.headline5!.copyWith(fontWeight: FontWeight.w600),
        ),
        content: Text(
          AppStrings.logOutPrompt,
          style: textTheme.bodyText1!.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            style: TextButton.styleFrom(
              primary: primaryColor,
            ),
            child: const Text(
              'Cancel',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton(
              onPressed: () async {
                controller.logOut();
              },
              style: TextButton.styleFrom(
                primary: primaryColor,
              ),
              child: const Text(
                AppStrings.logOut,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Function to make api call to edit user password
  void _editPassword() async {
    controller.showSpinner.value = true;
    var api = UserDataSource();
    Map<String, String> body = {
      "password": controller.newPasswordController.text
    };
    await api.resetPasswordWithId(body).then((value) {
      controller.showSpinner.value = false;
      Functions.showMessage('Password updated successfully');
    }).catchError((e){
      controller.showSpinner.value = false;
      Functions.showMessage(e);
      log(e);
    });
  }

}
