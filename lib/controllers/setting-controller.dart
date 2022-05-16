import 'dart:developer';
import 'package:flex_my_way/controllers/dashboard-controller.dart';
import 'package:flex_my_way/controllers/host-controller.dart';
import 'package:flex_my_way/controllers/join-controller.dart';
import 'package:flex_my_way/controllers/onboarding-controller.dart';
import 'package:flex_my_way/controllers/user-controller.dart';
import 'package:flex_my_way/screens/settings/edit-profile-detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/splash-screen.dart';
import '../util/constants/constants.dart';

class SettingsController extends GetxController {

  /// calling the user controller [UserController]
  final UserController userController = Get.put(UserController());

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
    // log(userName.value);
  }

  /*Controllers and Variables for log in*/
  /// Variable to hold the user's name
  final userName = 'there'.obs;


  /// A [TextEditingController] to control the input text for current password
  final TextEditingController currentPasswordController = TextEditingController();

  /// A [TextEditingController] to control the input text for new password
  final TextEditingController newPasswordController = TextEditingController();

  /// bool variable to hold the status of show edit password
  final showEditPassword = false.obs;

  /// bool variable to hold the bool state of show spinner
  final showSpinner = false.obs;

  /// bool variable to hold the status of current password obscure text
  final obscureCurrentPassword = true.obs;

  /// bool variable to hold the status of current password obscure text
  final obscureNewPassword = true.obs;

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

  /// Function to refresh user details after [EditProfileDetail]
  void refreshUserDetails() {
    userController.getCurrentUserDetail();
  }

  /// Function to update controllers when user details change
  void logOut() async {
    Get.delete<DashboardController>();
    Get.delete<HostController>();
    Get.delete<JoinController>();
    Get.delete<OnboardingController>();
    Get.delete<UserController>();
    Get.delete<SettingsController>();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedIn', false);
    Get.offAllNamed(SplashScreen.id);
  }

}