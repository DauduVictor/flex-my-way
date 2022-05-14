import 'dart:developer';
import 'package:get/get.dart';
import '../database/user-db-helper.dart';
import '../model/user.dart';

class UserController extends GetxController {

  /// Instantiating the user model
  var user = User();

  Future<User> getCurrentUser() async {
    var db = DatabaseHelper();
    Future<User> user = db.getUser();
    return user;
  }

  @override
  void onInit() {
    _getCurrentUser();
    super.onInit();
  }

  /// Function to get user details from the database
  void _getCurrentUser() async {
    await getCurrentUser().then((user) {
      userName.value = user.name!;
      // nameController.text = user.name!;
      // emailAddressController.text = user.email!;
      // phoneNumberController.text = user.phone!;
      // gender = user.gender!;
      // occuapationController.text = user.occupation!;
      // preferredFlex = user.preferredFlex!;
      log(userName.value);
    }).catchError((e){
      log(e);
    });
  }

  /// Variable to hold the user's name
  final userName = 'there'.obs;

}