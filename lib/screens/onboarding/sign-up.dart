import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/button.dart';
import '../../components/circle-indicator.dart';
import '../../components/dropdown-field.dart';
import '../../components/text-form-field.dart';
import '../../controllers/onboarding-controller.dart';
import '../../networking/user-datasource.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/functions.dart';
import '../../util/constants/strings.dart';
import '../../util/size-config.dart';

class SignUp extends StatelessWidget {

  static const String id = "signUp";
  SignUp({Key? key}) : super(key: key);

  /// calling the onboarding controller for [SignUp]
  final OnboardingController controller = Get.put(OnboardingController());

  ///A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        backgroundColor: Colors.transparent,
        title: Text(
          'Sign Up',
          style: textTheme.headline4!.copyWith(fontSize: 30),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
        },
        child: Obx(() => AbsorbPointer(
            absorbing: controller.loginShowSpinner.value,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(loginDecoratedImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            _buildForm(textTheme),
                            const SizedBox(height: 16),
                            Button(
                              label: 'Sign Up',
                              onPressed: () {
                                FocusScopeNode currentFocus = FocusScope.of(context);
                                if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
                                if(_formKey.currentState!.validate()){
                                  _signUp();
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
                ),
              ],
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
          /// name
          CustomTextFormField(
            textEditingController: controller.signupNameController,
            hintText: 'Your Name',
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if(value!.isEmpty) {
                return 'This field is required';
              }
              if(value.length < 2){
                return 'This field is required';
              }
              return null;
            },
          ),
          /// email address
          CustomTextFormField(
            textEditingController: controller.signupEmailAddressController,
            hintText: 'Your Email Address',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if(value!.isEmpty) {
                return 'This field is required';
              }
              if(value.length < 3 || !value.contains('@') || !value.contains('.')){
                return 'This field is required';
              }
              return null;
            },
          ),
          /// password
          CustomTextFormField(
            textEditingController: controller.signupPasswordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: controller.signupObscurePassword.value,
            textInputAction: TextInputAction.next,
            hintText: 'Create Password',
            suffix: Obx(() => GestureDetector(
                onTap: () {
                  controller.signupObscurePassword.toggle();
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,17.5 ,10 ,0),
                  child: Text(
                    controller.signupObscurePassword.value == true ? 'SHOW' : 'HIDE',
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
              if(value.length < 4){
                return 'Password length too short';
              }
              return null;
            },
          ),
          /// confirm password
          CustomTextFormField(
            textEditingController: controller.signupConfirmPasswordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            textInputAction: TextInputAction.next,
            hintText: 'Confirm Password',
            validator: (value) {
              if(value!.isEmpty) {
                return 'This field is required';
              }
              if(value != controller.signupPasswordController.text) {
                return 'Confirm your password';
              }
              return null;
            },
          ),
          /// phone number
          CustomTextFormField(
            textEditingController: controller.signupPhoneNumberController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            hintText: 'Your Phone Number',
            validator: (value) {
              if(value!.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
          /// gender
          CustomDropdownButtonField(
            hintText: AppStrings.gender,
            items: genders,
            onChanged: (value) {
              value = value.toString();
                controller.signupGender = value.toString();
            },
            validator: (value) {
              if (controller.signupGender.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
          /// occupation
          CustomTextFormField(
            textEditingController: controller.signupOccupationController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            hintText: 'Your Occupation',
            validator: (value) {
              if(value!.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
          CustomDropdownButtonField(
            hintText: AppStrings.typeOfFlex,
            items: preferredFlexes,
            onChanged: (value) {
              value = value.toString();
                controller.signupTypeOfFlex = value.toString();
            },
            validator: (value) {
              if (controller.signupTypeOfFlex.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
          /// infoSource
          CustomDropdownButtonField(
            hintText: 'How did you hear about us',
            items: infoSource,
            onChanged: (value) {
              value = value.toString();
              controller.signupInfoSource = value.toString();
            },
            validator: (value) {
              if (controller.signupInfoSource.isEmpty) {
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
  void _signUp() async {
    controller.loginShowSpinner.value = true;
    var api = UserDataSource();
    Map<String, String> body = {
      'name': controller.signupNameController.text,
      'phone': controller.signupPhoneNumberController.text,
      'email' : controller.signupEmailAddressController.text,
      'password' : controller.signupPasswordController.text,
      'gender': controller.signupGender,
      'preferredFlex': controller.signupTypeOfFlex,
      'infoSource': controller.signupInfoSource,
      'occupation': controller.signupOccupationController.text
    };
    await api.signUp(body).then((value) async {
      controller.loginShowSpinner.value = false;
      Functions.showMessage('Registration Successful');
      Get.back();
    }).catchError((e){
      controller.loginShowSpinner.value = false;
      Functions.showMessage(e);
      log(e);
    });
  }

}
