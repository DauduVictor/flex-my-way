import 'dart:developer';
import 'package:flex_my_way/screens/onboarding/reset-password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/button.dart';
import '../../components/circle-indicator.dart';
import '../../components/text-form-field.dart';
import '../../controllers/onboarding-controller.dart';
import '../../networking/user-datasource.dart';
import '../../util/constants/functions.dart';
import '../../util/size-config.dart';

class ForgotPassword extends StatelessWidget {

  static const String id = "forgotPassword";
  ForgotPassword({Key? key}) : super(key: key);

  /// calling the onboarding controller for [ForgotPassword]
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
                padding: const EdgeInsets.symmetric(horizontal: 45),
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/jpegs/login-decorated-screen.png'
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Forgot your password?',
                      textAlign: TextAlign.center,
                      style: textTheme.headline4!.copyWith(fontSize: 30),
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 21.0),
                      child: Text(
                        'Enter your Email and we will send a link to your registered email',
                        textAlign: TextAlign.center,
                        style: textTheme.bodyText1!,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Form(
                      key: _formKey,
                      child: CustomTextFormField(
                        textEditingController: controller.forgotPasswordEmailAddressController,
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
                    ),
                    const SizedBox(height: 8),
                    Button(
                      label: 'Send Recovery Email',
                      onPressed: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
                        if(_formKey.currentState!.validate()){
                          _forgotPassword();
                        }
                      },
                      child: controller.loginShowSpinner.value == true
                        ? const SizedBox(
                          height: 21,
                          width: 19,
                          child: CircleProgressIndicator()
                        )
                        : null,
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Back to Login',
                          textAlign: TextAlign.center,
                          style: textTheme.subtitle2!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Function to make api call for forgotPassword
  void _forgotPassword() async {
    controller.loginShowSpinner.value = true;
    var api = UserDataSource();
    Map<String, String> body = {
      'email' : controller.forgotPasswordEmailAddressController.text
    };
    await api.forgotPassword(body).then((value) async {
      controller.loginShowSpinner.value = false;
      Get.toNamed(ResetPassword.id);
      Functions.showMessage(value.toString());
    }).catchError((e){
      controller.loginShowSpinner.value = false;
      Functions.showMessage(e);
      log(e);
    });
  }

}
