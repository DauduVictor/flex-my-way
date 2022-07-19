import 'dart:developer';
import 'package:flex_my_way/model/model.dart';
import 'package:flex_my_way/networking/flex-datasource.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/user-db-helper.dart';
import 'package:flex_my_way/util/util.dart';

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
    getFlexInvites();
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

  /// function to check if the user is currently logged in
  void checkFlexReminder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('flexReminder') == true) {
      flexReminder.value = true;
      log('remind user');
    }
    else {
      log('no reminder');
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

  /// Variable to hold flex reminder
  final flexReminder = false.obs;

  //notifications
  /// Variable to hold notification delete spinner
  final showNotificationSpinner = false.obs;

  //notifications
  /// Variable to hold notification delete spinner
  final showInvitesSpinner = false.obs;

  RxList<Notification> notification = <Notification>[].obs;
  RxList<DashboardFLex> scheduledFlex = <DashboardFLex>[].obs;
  RxList<DashboardFLex> completedFlex = <DashboardFLex>[].obs;
  RxList<HistoryFlex> pastFlex = <HistoryFlex>[].obs;
  RxList<HistoryFlex> presentFlex = <HistoryFlex>[].obs;
  RxList<HistoryFlex> futureFlex = <HistoryFlex>[].obs;
  RxList<Flexes> flexInvites = <Flexes>[].obs;

  /*invites integration*/
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

  /* Dashboard integration*/
  /// Function to get dashboard flex [with param - scheduled, completed]

  final isScheduledLoaded = false.obs;
  final isCompletedLoaded = false.obs;

  void getDashboardFlex() async {
    var api = FlexDataSource();

    /// get scheduled flex tab
    await api.getDashboardFlex('scheduled').then((value) {
      isScheduledLoaded.value = true;
      scheduledFlex.value = value;
      print(value);
    }).catchError((e) {
      log(':::error: $e');
      Functions.showMessage(e);
    });

    ///get completed flex tab
    await api.getDashboardFlex('completed').then((value) {
      isCompletedLoaded.value = true;
      completedFlex.value = value;
      print(value);
    }).catchError((e) {
      log(':::error: $e');
      Functions.showMessage(e);
    });

  }

  /* Flex History Integration*/

  final isPastLoaded = false.obs;
  final isPresentLoaded = false.obs;
  final isFutureLoaded = false.obs;

  void getFlexHistory() async {
    var api = FlexDataSource();

    ///get past flex tab
    await api.getFlexHistory('past').then((value) {
      isPastLoaded.value = true;
      pastFlex.value = value;
    }).catchError((e) {
      log(':::error: $e');
      Functions.showMessage(e);
    });

    ///get present flex tab
    await api.getFlexHistory('present').then((value) {
      isPresentLoaded.value = true;
      presentFlex.value = value;
    }).catchError((e) {
      log(':::error: $e');
      // Functions.showMessage(e);
    });

    ///get future flex tab
    await api.getFlexHistory('future').then((value) {
      isFutureLoaded.value = true;
      futureFlex.value = value;
    }).catchError((e) {
      log(':::error: $e');
      // Functions.showMessage(e);
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

  /// Function to get flex invitees
  void getFlexInvites() async {
    var api = FlexDataSource();
    await api.getFlexInvites().then((value) {
      // flexInvites.value = value;
      log(':::notificationLength: ${notification.length}');
    }).catchError((e) {
      log(':::error: $e');
    });
  }

}