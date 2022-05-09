import 'dart:developer';
import 'dart:io';
import 'package:contacts_service/contacts_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/future-values.dart';
import '../util/constants/constants.dart';

class HostController extends GetxController {

  /// Instantiating a class of future values
  var futureValues = FutureValues();

  @override
  void onInit() {
    checkUserIsLoggedIn();
    super.onInit();
  }

  /// Variable to hold the bool state of spinner
  final showSpinner = false.obs;

  /*Controllers and Variables for host a flex*/
  /// A [TextEditingController] to control the input text for name flex
  final TextEditingController nameFlexController = TextEditingController();

  /// A [TextEditingController] to control the input text for select a date
  final TextEditingController dateController = TextEditingController();

  /// A [TextEditingController] to control the input text for event hash tag
  final TextEditingController eventHashTagController = TextEditingController();

  /// A [TextEditingController] to control the input text for number of people
  final TextEditingController numberOfPeopleController = TextEditingController();

  /// A [TextEditingController] to control the input text for event amount
  final TextEditingController eventAmountController = TextEditingController();

  /// A [TextEditingController] to control the input text for banner image
  final TextEditingController bannerImageController = TextEditingController();

  /// A [TextEditingController] to control the input text for event amount
  final TextEditingController flexRulesController = TextEditingController();

  /// A [TextEditingController] to control the input text for event amount
  final TextEditingController videoLinkController = TextEditingController();

  /// A [TextEditingController] to control the input text for searching flex address
  final TextEditingController searchAddress = TextEditingController();

  /// A [TextEditingController] to control the input text for flex address
  final TextEditingController flexAddress = TextEditingController();

  /// A variable to hold the payment status
  final paid = ''.obs;

  /// A variable to hold the public or private status
  final publicOrPrivate = ''.obs;

  /// A variable to hold the flex location
  final displayFlexLocation = ''.obs;

  /// A variable to hold the gender restriction
  bool? genderRestriciton;

  /// A variable to hold the consumable policy
  final consumablePolicy = ''.obs;

  /// A variable to hold the age rate
  final ageRating = ''.obs;

  /// A variable to hold the type of flex
  final typeOfFlex = ''.obs;

  /// A variable to hold the lat of flex
  final lat = ''.obs;

  /// A variable to hold the long of flex
  final long = ''.obs;

  /// File Variable to hold the file source of the selected image
  File? image;

  /*Controller and Variable for terms and conditions*/
  /// A [TextEditingController] to control the input text for bvn
  final TextEditingController bvnController = TextEditingController();

  /// bool value to hold the state of terms and condition
  final termsAndConditionsAccepted = false.obs;

  /// bool value to hold the state of privacy policy
  final privacyPolicyAccepted = false.obs;

  /// Bool variable to hold the bool state if the user is currently logged in
  final isLoggedIn = false.obs;

  /// function to check if the user is currently logged in
  void checkUserIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('loggedIn') == true) {
      isLoggedIn.value = true;
      print('logged in');
    }
    else {
      log('User is not logged in');
    }
  }

  /// Function to get user location and use [LatLang] in the map
  void getUserLocation() async {
    await futureValues.getUserLocation().then((value) async {
      lat.value = double.parse(value[0]).toString();
      long.value = double.parse(value[1]).toString();
      List<Placemark> placeMarks = await placemarkFromCoordinates(double.parse(value[0]), double.parse(value[1]));
      Placemark place = placeMarks[0];
      flexAddress.text = ('${place.street}, ${place.locality}, ${place.country}');
    }).catchError((e) async {
      log(e);
      throw e;
    });
  }

  /*Controller and Variables for host registration*/
  /// A [TextEditingController] to control the input text for host name
  final TextEditingController hostNameController = TextEditingController();

  /// A [TextEditingController] to control the input text for host email
  final TextEditingController hostEmailAddressController = TextEditingController();

  /// A [TextEditingController] to control the input text for host password
  final TextEditingController hostPasswordController = TextEditingController();

  /// A [TextEditingController] to control the input text for host phone number
  final TextEditingController hostPhoneNumberController = TextEditingController();

  /// A [TextEditingController] to control the input text for occupation
  final TextEditingController occupationController = TextEditingController();

  /// Bool value to hold the obscure state for password
  final hostObscureText = true.obs;

  /// Function to get the formatted date for date time picker
  String _formatDate(DateTime date) {
    return DateFormat.yMd('en_US').format(date);
  }


  /*Controller and Variable for betasms*/
  /// A [TextEditingController] to control the input text for current password
  final TextEditingController betasmsNoOfPeople = TextEditingController();

  /// A [TextEditingController] to control the input text for current password
  final TextEditingController contactController = TextEditingController();

  /// Bool variable to hold use database
  final useDatabase = yesOrNo[1].obs;

  /// Variable to hold the bool value for uploaded contact
  final isUploaded = false.obs;

  /// Variable to hold the bool value for editing contact numbers
  final editingContact = false.obs;

  /// Variable to hold a list of contact model
  List<Contact> contact = [];

  /*Api Integration*/

}