import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/onboarding-controller.dart';
import '../../networking/user-datasource.dart';
import 'login.dart';
import 'package:flex_my_way/util/util.dart';
import 'package:flex_my_way/controllers/controllers.dart';
import 'package:flex_my_way/components/components.dart';

class ResetPassword extends StatelessWidget {
  static const String id = "resetPassword";
  ResetPassword({Key? key}) : super(key: key);

  /// calling the onboarding controller for [SignUp]
  final OnboardingController controller = Get.put(OnboardingController());

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: DismissKeyboard(
        child: Obx(() => AbsorbPointer(
              absorbing: controller.loginShowSpinner.value,
              child: SingleChildScrollView(
                child: Container(
                  height: SizeConfig.screenHeight,
                  width: SizeConfig.screenWidth,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(loginDecoratedImage),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45),
                    child: Column(
                      children: [
                        SizedBox(height: SizeConfig.screenHeight! * 0.04),
                        Text(
                          AppStrings.resetPassword,
                          style: textTheme.headlineMedium!
                              .copyWith(fontSize: 30.5),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'We have sent a code to your registered Email. \nEnter your Email, Code and new Password to reset your password',
                          textAlign: TextAlign.center,
                          style: textTheme.bodyLarge!,
                        ),
                        const SizedBox(height: 32),
                        _buildForm(textTheme),
                        const SizedBox(height: 24),
                        Button(
                          label: AppStrings.resetPassword,
                          onPressed: () {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus)
                              currentFocus.unfocus();
                            if (_formKey.currentState!.validate()) {
                              _resetPassword();
                            }
                          },
                          child: controller.loginShowSpinner.value == true
                              ? const SizedBox(
                                  height: 21,
                                  width: 19,
                                  child: CircleProgressIndicator())
                              : null,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  /// Widget to hold the form container
  Widget _buildForm(TextTheme textTheme) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            textEditingController:
                controller.resetPasswordEmailAddressController,
            hintText: 'Your Email Address',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value!.isEmpty) {
                return 'This field is required';
              }
              if (value.length < 3 || !value.contains('@')) {
                return 'This field is required';
              }
              return null;
            },
          ),
          CustomTextFormField(
            textEditingController: controller.resetCodeController,
            hintText: 'Code',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value!.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),

          /// new password
          CustomTextFormField(
            textEditingController: controller.resetPasswordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: controller.resetPasswordObscurePassword.value,
            textInputAction: TextInputAction.next,
            hintText: 'New Password',
            suffix: Obx(() => GestureDetector(
                  onTap: () {
                    controller.resetPasswordObscurePassword.toggle();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 17.5, 10, 0),
                    child: Text(
                      controller.resetPasswordObscurePassword.value == true
                          ? 'SHOW'
                          : 'HIDE',
                      style: textTheme.button!.copyWith(
                        fontSize: 14.5,
                        color: primaryColor,
                      ),
                    ),
                  ),
                )),
            validator: (value) {
              if (value!.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),

          /// confirm new password
          CustomTextFormField(
            textEditingController:
                controller.resetPasswordConfirmPasswordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            textInputAction: TextInputAction.done,
            hintText: 'Confirm Password',
            validator: (value) {
              if (value!.isEmpty) {
                return 'This field is required';
              }
              if (value != controller.resetPasswordController.text) {
                return 'Confirm your password';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  /// Function to make api call to login
  void _resetPassword() async {
    controller.loginShowSpinner.value = true;
    var api = UserDataSource();
    Map<String, String> body = {
      'email': controller.resetPasswordEmailAddressController.text,
      'password': controller.resetPasswordController.text,
      'code': controller.resetCodeController.text
    };
    await api.resetPassword(body).then((value) async {
      controller.loginShowSpinner.value = false;
      Functions.showToast('Password successfully reset!');
      Get.toNamed(Login.id);
    }).catchError((e) {
      controller.loginShowSpinner.value = false;
      Functions.showToast(e.toString());
      log(e);
    });
  }
}
