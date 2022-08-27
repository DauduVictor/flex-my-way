import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flex_my_way/model/model.dart';
import '../database/user-db-helper.dart';

class OnboardingController extends GetxController {

  @override
  void onInit() {
    getCurrentUser();
    _getCurrentUser();
    super.onInit();
  }

  Future<User> getCurrentUser() async {
    var db = DatabaseHelper();
    Future<User> user = db.getUser();
    return user;
  }

  /// Function to get user details from the database
  void _getCurrentUser() async {
    await getCurrentUser().then((user) {
      loginEmailAddressController.text = user.email!;
      forgotPasswordEmailAddressController.text = user.email!;
      resetPasswordEmailAddressController.text = user.email!;
      log(loginEmailAddressController.text);
    });
  }

  /*Controllers and Variables for log in*/
  /// TextEditingController for email address
  final TextEditingController loginEmailAddressController = TextEditingController();

  /// TextEditingController for email address
  final TextEditingController loginPasswordController = TextEditingController();

  /// Variable to hold the bool value for login screen password field
  final loginObscureText = true.obs;

  /// Variable to hold the bool value of show spinner
  final loginShowSpinner = false.obs;

  /*Controllers and variables for sign in*/
  /// TextEditingController for email address
  final TextEditingController signupEmailAddressController = TextEditingController();

  /// TextEditingController for email address
  final TextEditingController signupPasswordController = TextEditingController();

  /// TextEditingController for email address
  final TextEditingController signupConfirmPasswordController = TextEditingController();

  /// A [TextEditingController] to control the input text for host name
  final TextEditingController signupNameController = TextEditingController();

  /// A [TextEditingController] to control the input text for host phone number
  final TextEditingController signupPhoneNumberController = TextEditingController();

  /// A [TextEditingController] to control the input text for host phone number
  final TextEditingController signupOccupationController = TextEditingController();

  /// A variable to hold the type of flex
  String signupTypeOfFlex = '';

  /// A variable to hold the gender
  String signupGender = '';

  /// A variable to hold the info source
  String signupInfoSource = '';

  /// Bool value to hold the obscure state for password
  final signupObscurePassword = true.obs;

  /*Controller and Variables for forgot password*/
  /// TextEditingController for email address
  final TextEditingController forgotPasswordEmailAddressController = TextEditingController();

  /*Controller and Variables for reset password*/
  /// TextEditingController for email address
  final TextEditingController resetPasswordEmailAddressController = TextEditingController();

  /// TextEditingController for code
  final TextEditingController resetCodeController = TextEditingController();

  /// TextEditingController for password
  final TextEditingController resetPasswordPasswordController = TextEditingController();

  /// TextEditingController for password
  final TextEditingController resetPasswordConfirmPasswordController = TextEditingController();

  ///Variable to hold the bool value of password field obscure text
  final resetPasswordObscurePassword = true.obs;

}