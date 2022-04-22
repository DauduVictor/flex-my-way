import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../database/user-db-helper.dart';
import '../model/user.dart';
import '../util/constants/constants.dart';

class SettingsController extends GetxController {

  @override
  void onInit() {
    _getCurrentUser();
    super.onInit();
  }

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
      log(userName.value);
    }).catchError((e){
      log(e);
    });
  }

  /*Controllers and Variables for log in*/
  /// Variable to hold the user's name
  var userName = 'there'.obs;

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final formKey = GlobalKey<FormState>();

  /// A [TextEditingController] to control the input text for current password
  final TextEditingController currentPasswordController = TextEditingController();

  /// A [TextEditingController] to control the input text for new password
  final TextEditingController newPasswordController = TextEditingController();

  /// bool variable to hold the status of show edit password
  final showEditPassword = false.obs;

  /// bool variable to hold the bool state of show spinner
  final showSpinner = false.obs;

  /// bool variable to hold the status of current password obscure text
  final obscureCurrentPassword = false.obs;

  /// bool variable to hold the status of current password obscure text
  final obscureNewPassword = false.obs;

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

  /// Variable to hold the value of the gender
  String preferredFlex = preferredFlex[0];

}