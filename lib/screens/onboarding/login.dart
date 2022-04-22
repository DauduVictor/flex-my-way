import 'dart:developer';
import 'package:flex_my_way/controllers/onboarding-controller.dart';
import 'package:flex_my_way/networking/user-datasource.dart';
import 'package:flex_my_way/screens/dashboard/dashboard.dart';
import 'package:flex_my_way/screens/onboarding/sign-up.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/button.dart';
import '../../components/circle-indicator.dart';
import '../../components/text-form-field.dart';
import '../../database/user-db-helper.dart';
import '../../model/user.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/functions.dart';
import '../../util/size-config.dart';
import 'forgot_password.dart';

class Login extends StatelessWidget {

  static const String id = 'login';
  Login({Key? key}) : super(key: key);

  /// calling the onboarding controller for [Login]
  final OnboardingController controller = Get.put(OnboardingController());

  ///A [GlobalKey] to hold the form state of my form widget for form validation
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
                        'Login',
                        style: textTheme.headline4!.copyWith(fontSize: 30),
                      ),
                      const SizedBox(height: 32),
                      _buildForm(textTheme),
                      const SizedBox(height: 24),
                      Button(
                        label: 'Log in',
                        onPressed: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
                          if(_formKey.currentState!.validate()){
                            _login(controller);
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
                      RichText(
                        text: TextSpan(
                          style: textTheme.bodyText1!,
                          children: [
                            const TextSpan(
                              text: 'Forgot your password? ',
                            ),
                            TextSpan(
                              text: 'Click Here',
                              style: textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w600),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                Get.toNamed(ForgotPassword.id);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Don’t have an account?',
                        textAlign: TextAlign.center,
                        style: textTheme.bodyText1!,
                      ),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(SignUp.id);
                        },
                        child: Text(
                          'Sign Up',
                          textAlign: TextAlign.center,
                          style: textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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
            textEditingController: controller.loginEmailAddressController,
            hintText: 'Your Email Address',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if(value!.isEmpty) {
                return 'This field is required';
              }
              if(value.length < 3 && !value.contains('@') && !value.contains('.')) {
                return 'This field is required';
              }
              return null;
            },
          ),
          CustomTextFormField(
            textEditingController: controller.loginPasswordController,
            keyboardType: TextInputType.text,
            obscureText: controller.loginObscureText.value,
            textInputAction: TextInputAction.done,
            hintText: 'Your Password',
            suffix: Obx(() => GestureDetector(
                onTap: () {
                  controller.loginObscureText.value = !controller.loginObscureText.value;
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,17.5 ,10 ,0),
                  child: Text(
                    controller.loginObscureText.value == true ? 'SHOW' : 'HIDE',
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
        ],
      ),
    );
  }

  /// Function to make api call to login
  void _login(OnboardingController controller) async {
    // if(!mounted) return;
    controller.loginShowSpinner.value = true;
    var api = UserDataSource();
    Map<String, String> body = {
      'email' : controller.loginEmailAddressController.text,
      'password' : controller.loginPasswordController.text
    };
    await api.signIn(body).then((user) async {
      // if(!mounted) return;
      controller.loginShowSpinner.value = false;
      var db = DatabaseHelper();
      await db.initDb();
      await db.saveUser(user);
      _addBoolToSP(user);
    }).catchError((e){
      // if(!mounted) return;
      controller.loginShowSpinner.value = false;
      Functions.showMessage(e);
      log(e);
    });
  }

  /// This function adds a true boolean value to show user is logged in and also
  /// saves token as reference from the [user] model using [SharedPreferences]
  /// It moves to the [Dashboard] after saving those details
  _addBoolToSP(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', true);
    await prefs.setString('bearerToken', user.bearer_token!);
    Get.toNamed(Dashboard.id);
  }

}