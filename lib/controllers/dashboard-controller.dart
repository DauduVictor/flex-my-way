import 'dart:developer';
import 'package:get/get.dart';
import '../database/user-db-helper.dart';
import '../model/user.dart';

class DashboardController extends GetxController {

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
    }).catchError((e){
      log(e);
    });
  }

  /// Variable to hold the user's name
  final userName = 'there'.obs;
}