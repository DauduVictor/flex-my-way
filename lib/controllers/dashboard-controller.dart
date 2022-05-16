import 'dart:developer';
import 'package:flex_my_way/controllers/user-controller.dart';
import 'package:get/get.dart';
import '../database/user-db-helper.dart';
import '../model/user.dart';

class DashboardController extends GetxController {

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
    log(userName.value);
  }

  /// Variable to hold the user's name
  final userName = 'there'.obs;
}