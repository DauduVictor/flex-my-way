import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flex_my_way/model/model.dart';

class JoinController extends GetxController {

  /// Bool variable to hold the bool state of showSpinner
  final showSpinner = false.obs;

  /// Function to launch the url for the video link
  Future <void> launchVideo(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  /// tempoary bool value to show that a flex is paid
  final isPaid = false;

  /// tempoary variable to store flex id
  String flexId = 'sZgZ0o';

  /// tempoary bool variable to show the skeleton animation of a flex loading
  final isFlexLoaded = true;

  /// Function to get user location and use [LatLang] in the map
  Future<String> formatLocation(double lat, double lon) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(lat, lon);
    Placemark place = placeMarks[0];
    return ('${place.street}, ${place.locality}, ${place.country}');
  }

  /* integrations*/
  Flexes? joinedFlex;

}