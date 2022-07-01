import 'dart:developer';
import 'controllers.dart';
import 'package:flex_my_way/screens/settings/edit-profile-detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/splash-screen.dart';
import '../util/constants/constants.dart';

class SettingsController extends GetxController {

  /// calling the user controller [UserController]
  final UserController userController = Get.find<UserController>();

  @override
  void onInit() {
    _getCurrentUser();
    super.onInit();
  }

  /// Function to get user details from the database
  void _getCurrentUser() {
    userName.value = userController.username.value;
    nameController.text = userController.username.value;
    emailAddressController.text = userController.emailAddress.value;
    phoneNumberController.text = userController.phoneNumber.value;
    gender = userController.gender.value;
    occuapationController.text = userController.occupation.value;
    preferredFlex = userController.preferredFlex.value;
    canHostFlex.value = userController.canHostFlex.value;
    log(userName.value);
    log(canHostFlex.value.toString());
  }

  /*Controllers and Variables for log in*/
  /// Variable to hold the user's name
  final userName = 'there'.obs;

  /// A [TextEditingController] to control the input text for current password
  final TextEditingController currentPasswordController = TextEditingController();

  /// A [TextEditingController] to control the input text for new password
  final TextEditingController newPasswordController = TextEditingController();

  /// A [TextEditingController] to control the input text for new password
  final TextEditingController confirmPasswordController = TextEditingController();

  /// bool variable to hold the status of show edit password
  final showEditPassword = false.obs;

  /// bool variable to hold the bool state of show spinner
  final showSpinner = false.obs;

  /// bool variable to hold the status of current password obscure text
  final obscureCurrentPassword = true.obs;

  /// bool variable to hold the status of new password obscure text
  final obscureNewPassword = true.obs;

  /// bool variable to hold the status of confirm password obscure text
  final obscureConfirmPassword = true.obs;

  /*Controllers and Variable for edit profile details*/
  /// A [TextEditingController] to control the input text for name
  final TextEditingController nameController = TextEditingController();

  /// A [TextEditingController] to control the input text for email address
  final TextEditingController emailAddressController = TextEditingController();

  /// A [TextEditingController] to control the input text for phone number
  final TextEditingController phoneNumberController = TextEditingController();

  /// A [TextEditingController] to control the input text for occupation
  final TextEditingController occuapationController = TextEditingController();

  /// Variable to hold the value of the gender
  String gender = genders[0];

  /// Variable to hold the value of the preferred flex
  String preferredFlex = preferredFlexes[0];

  /// Variable to hold user's type
  final canHostFlex = false.obs;

  /// Function to refresh user details after [EditProfileDetail]
  void refreshUserDetails() {
    userController.getCurrentUserDetail();
  }

  /// Function to update controllers when user details change
  void logOut() async {
    Get.delete<HostController>();
    Get.delete<JoinController>();
    Get.delete<OnboardingController>();
    Get.delete<UserController>();
    Get.delete<SettingsController>();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedIn', false);
    prefs.remove('bearerToken');
    Get.offAllNamed(SplashScreen.id);
  }

}