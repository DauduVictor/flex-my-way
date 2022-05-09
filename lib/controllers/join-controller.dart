import 'dart:developer';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class JoinController extends GetxController {

  @override
  void onInit() {
    checkUserIsLoggedIn();
    super.onInit();
  }

  /// Bool variable to hold the bool state if the user is currently logged in
  final isLoggedIn = false.obs;

  /// Bool variable to hold the bool state of showSpinner
  final showSpinner = false.obs;

  /// function to check if the user is currently logged in
  void checkUserIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('loggedIn') == true) {
      isLoggedIn.value = true;
    }
    else {
      log('User is not logged in');
    }
  }

  /// Function to launch the url for the video link
  Future <void> launchVideo(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  /// tempoary bool value to show that a flex is paid
  final isPaid = false;

  /// tempoary variable to store flex id
  String flexId = 'X2jdIB';

  /// tempoary bool variable to show the skeleton animation of a flex loading
  final isFlexLoaded = false;

}