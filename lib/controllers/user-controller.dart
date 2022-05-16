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
    getCurrentUserDetail();
    super.onInit();
  }

  /// Function to get user details from the database
  void getCurrentUserDetail() async {
    await getCurrentUser().then((user) {
      username.value = user.name!;
      emailAddress.value = user.email!;
      phoneNumber.value = user.phone!;
      gender.value = user.gender!;
      preferredFlex.value = user.preferredFlex!;
      infoSource.value = user.infoSource!;
      occupation.value = user.occupation!;
    }).catchError((e){
      log(e);
    });
  }

  /// Variable to hold the user's name
  final username = 'there'.obs;

  /// Variable to hold user's email
  final emailAddress = ''.obs;

  /// Variable to hold user's phone number
  final phoneNumber = ''.obs;

  /// Variable to hold user's gender
  final gender = ''.obs;

  /// Variable to hold user's preferred flex
  final preferredFlex = ''.obs;

  /// Variable to hold user's info source
  final infoSource = ''.obs;

  /// Variable to hold user's occupation
  final occupation = ''.obs;

}