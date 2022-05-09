import 'dart:developer';
import 'package:flex_my_way/controllers/dashboard-controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../database/user-db-helper.dart';
import '../model/user.dart';
import '../util/constants/constants.dart';

class SettingsController extends GetxController {

   static DashboardController dashboardController = Get.put(DashboardController());

  @override
  void onInit() {
    _getCurrentUser();
    super.onInit();
  }

  // @override
  // // TODO: implement onStart
  // InternalFinalCallback<void> get onStart {
  //   showEditPassword.value = false;
  //   currentPasswordController.clear();
  //   newPasswordController.clear();
  //   update();
  //   return super.onStart;
  // }

  // @override
  // void onClose() {
  //   showEditPassword.value = false;
  //   currentPasswordController.clear();
  //   newPasswordController.clear();
  //   update();
  //   super.onClose();
  // }

  /// Instantiating the user model
  var user = User();

  Future<User> getCurrentUser() async {
    var db = DatabaseHelper();
    Future<User> user = db.getUser();
    return user;
  }

  /// Function to get user details from the database
  void _getCurrentUser() async {
    await getCurrentUser().then((user) {
      userName.value = user.name!;
      nameController.text = user.name!;
      emailAddressController.text = user.email!;
      phoneNumberController.text = user.phone!;
      gender = user.gender!;
      occuapationController.text = user.occupation!;
      preferredFlex = user.preferredFlex!;
      log(userName.value);
    }).catchError((e){
      log(e);
    });
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

  /// Function to update controllers when user details change
  void updateControllers() {
    dashboardController.update();
  }

}