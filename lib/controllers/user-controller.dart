import 'dart:developer';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    checkUserIsLoggedIn();
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
      canHostFlex.value = user.canHostFlex!;
      log(username.value);
      log(emailAddress.value);
      log(canHostFlex.value.toString());
    }).catchError((e){
      log(e);
    });
  }

  /// function to check if the user is currently logged in
  void checkUserIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('loggedIn') == true) {
      isLoggedIn.value = true;
      log('logged in');
    }
    else {
      log('User is not logged in');
    }
  }

  /// Bool variable to hold the bool state if the user is currently logged in
  final isLoggedIn = false.obs;

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

  /// Variable to hold user's type
  final canHostFlex = false.obs;

  /*api integration*/
  /// Tempral map to hold the invite length
  Map<String, String> invites = {
    '1' : 'oiwjnowfe782',
    '2' : 'posf232',
    '3' : 'oisjdfe23',
    '4' : '09uoisf',
    '5' : 'oisf789w',
    '6' : 'svhriubw63',
    '7' : '023jnsfss',
  };

  /// Tempral list to hold the list of invites
  List<String> invitesList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
  ];

}