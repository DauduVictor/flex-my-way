import 'dart:developer';
import 'package:flex_my_way/model/model.dart';
import 'package:flex_my_way/networking/flex-datasource.dart';
import 'package:flex_my_way/screens/dashboard/notifications.dart';
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
    getDashboardFlex();
    getFlexHistory();
    getNotifications();
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

  RxList<Notification> notification = <Notification>[].obs;

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

  /// Function to get dashboard flex [with param - scheduled, completed]
  void getDashboardFlex() async {
    var api = FlexDataSource();

    /// get scheduled flex tab
    await api.getDashboardFlex('scheduled').then((value) {
      return null;
    }).catchError((e) {
      log(':::error: $e');
    });

    ///get completed flex tab
    await api.getDashboardFlex('completed').then((value) {
      return null;
    }).catchError((e) {
      log(':::error: $e');
    });

  }

  /// Function to get dashboard flex [with param - scheduled, completed]
  void getFlexHistory() async {
    var api = FlexDataSource();

    ///get past flex tab
    await api.getFlexHistory('past').then((value) {
      return null;
    }).catchError((e) {
      log(':::error: $e');
    });

    ///get present flex tab
    await api.getFlexHistory('present').then((value) {
      return null;
    }).catchError((e) {
      log(':::error: $e');
    });

    ///get future flex tab
    await api.getFlexHistory('future').then((value) {
      return null;
    }).catchError((e) {
      log(':::error: $e');
    });
  }

  /// Function to get notifications
  void getNotifications() async {
    var api = FlexDataSource();
    await api.getNotifications('scheduled').then((value) {
      notification.value = value;
      log(':::notificationLength: ${notification.length}');
    }).catchError((e) {
      log(':::error: $e');
    });
  }

}