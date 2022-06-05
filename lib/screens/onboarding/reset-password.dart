import 'dart:developer';
import 'package:flex_my_way/util/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/button.dart';
import '../../components/circle-indicator.dart';
import '../../components/text-form-field.dart';
import '../../controllers/onboarding-controller.dart';
import '../../networking/user-datasource.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/functions.dart';
import '../../util/size-config.dart';
import 'login.dart';

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
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
        },
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.resetPassword,
                        style: textTheme.headline4!.copyWith(fontSize: 30),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'We have sent a code to your registered Email. \nEnter your Email, Code and new Password to reset your password',
                        textAlign: TextAlign.center,
                        style: textTheme.bodyText1!,
                      ),
                      const SizedBox(height: 32),
                      _buildForm(textTheme),
                      const SizedBox(height: 24),
                      Button(
                        label: AppStrings.resetPassword,
                        onPressed: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
                          if(_formKey.currentState!.validate()){
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
          )
        ),
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
            textEditingController: controller.resetPasswordEmailAddressController,
            hintText: 'Your Email Address',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if(value!.isEmpty) {
                return 'This field is required';
              }
              if(value.length < 3 || !value.contains('@')){
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
              if(value!.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
          /// new password
          CustomTextFormField(
            textEditingController: controller.resetPasswordPasswordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: controller.resetPasswordObscurePassword.value,
            textInputAction: TextInputAction.next,
            hintText: 'New Password',
            suffix: Obx(() => GestureDetector(
                onTap: () {
                  controller.resetPasswordObscurePassword.toggle();
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,17.5 ,10 ,0),
                  child: Text(
                    controller.resetPasswordObscurePassword.value == true ? 'SHOW' : 'HIDE',
                    style: textTheme.button!.copyWith(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                ),
              )
            ),
            validator: (value) {
              if(value!.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
          /// confirm new password
          CustomTextFormField(
            textEditingController: controller.resetPasswordConfirmPasswordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            textInputAction: TextInputAction.done,
            hintText: 'Confirm Password',
            validator: (value) {
              if(value!.isEmpty) {
                return 'This field is required';
              }
              if(value != controller.resetPasswordPasswordController.text) {
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
      'email' : controller.resetPasswordEmailAddressController.text,
      'password' : controller.resetPasswordPasswordController.text,
      'code' : controller.resetCodeController.text
    };
    await api.resetPassword(body).then((value) async {
      controller.loginShowSpinner.value = false;
      Functions.showMessage(value);
      Get.toNamed(Login.id);
    }).catchError((e){
      controller.loginShowSpinner.value = false;
      Functions.showMessage(e.toString());
      log(e);
    });
  }

}
