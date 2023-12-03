import 'dart:developer';
import 'dart:io';
import 'package:flex_my_way/networking/flex-datasource.dart';
import 'package:flex_my_way/screens/host/host-a-flex.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bloc/future-values.dart';
import 'package:flex_my_way/util/util.dart';
import 'package:flex_my_way/model/model.dart';
import 'controllers.dart';
import 'package:http/http.dart' as http;

class EditController extends GetxController {
  /// Instantiating a class of [FlexDataSource]
  var api = FlexDataSource();

  ///Instantiating the class of [Flexes]
  Flexes? flex;

  bool showSearchSpinner = false;

  /// Variable to hold prediction
  GooglePlacesPredictionModel? googlePlacesPredictionModel;

  GooglePlacesPredictionModel? googlePlacesPredictionModel2;

  Future getFlexDetails(String flexCode) async {
    showSpinner.value = true;
    await api.getFlexDetails(flexCode).then((value) {
      flex = value;
      log('flex prop ::: ${value.toString()}');
      update();
      populateValues();
      showSpinner.value = false;
    }).catchError((e) {
      log(e);
      showSpinner.value = false;
      Functions.showToast(e.toString());
    });
  }

  ///Function to populate text controllers and all
  void populateValues() async {
    try {
      lat.value = flex!.locationCoordinates!.lat!.toString();
      long.value = flex!.locationCoordinates!.lng!.toString();
      nameFlexController.text = flex!.name!;
      dateController.text = _formatDate(flex!.fromDate!);
      allowPickTime.value = true;
      pickedDate = flex!.fromDate!;
      startTimeController.text = Functions.getFlexTime(flex!.fromDate!);
      endTimeController.text = Functions.getFlexTime(flex!.toDate!);
      startTime = flex!.fromDate!;
      endTime = flex!.toDate!;
      numberOfPeopleController.text = flex!.capacity!.toString();
      eventHashTagController.text = flex!.hashtag!;
      ageRating.value = flex!.ageRating! == '18' ? '18+' : 'Below 18';
      typeOfFlex.value = flex!.flexType!;
      displayFlexLocation.value = flex!.showOnAccepted! == false ? 'No' : 'Yes';
      bannerImageController.text =
          '${flex!.bannerImage!.length} Image(s) uploaded';
      publicOrPrivate.value = flex!.viewStatus!;
      paid.value = flex!.payStatus!;
      genderRestriction.value = flex!.genderRestriction! == 'Both'
          ? 'All genders allowed'
          : flex!.genderRestriction!;
      consumablePolicy.value = flex!.consumablesPolicy!;
      flexRulesController.text = flex!.flexRules!;
      videoLinkController.text = flex!.videoLink!;
      // check if recurring dates is not empty and add to form
      if (flex!.recurringDates != null) {
        if (flex!.recurringDates!.isNotEmpty) {
          for (int i = 0; i < flex!.recurringDates!.length; i++) {
            reoccuringDates.add(ReoccuringWidget(
              reoccuringDate: DateFormat('dd/MM/yyyy')
                  .format(flex!.recurringDates![i].fromDate),
              onDeleteTap: () {
                deleteDate(
                  DateFormat('dd/MM/yyyy')
                      .format(flex!.recurringDates![i].fromDate),
                );
              },
            ));
          }
        }
      }

      // check if recurring location is not empty and add to form
      if (flex!.broadcastLocations != null) {
        if (flex!.broadcastLocations!.isNotEmpty) {
          for (int i = 0; i < flex!.broadcastLocations!.length; i++) {
            reoccuringLocations.add(ReoccuringWidget(
              reoccuringDate: flex!.broadcastLocations![i].locationName ?? '',
              onDeleteTap: () {
                deleteBrodcast(flex!.broadcastLocations![i].locationName ?? '');
              },
            ));
            reoccuringLatLongs.add(
              [
                flex!.broadcastLocations![i].coordinates?.lat.toString() ?? '',
                flex!.broadcastLocations![i].coordinates?.lng.toString() ?? '',
                flex!.broadcastLocations![i].locationName ?? '',
              ],
            );
          }
        }
      }
      flexAddress.text = await formatLocation(
          flex!.locationCoordinates!.lat!, flex!.locationCoordinates!.lng!);
      update();
    } catch (e) {
      Fluttertoast.showToast(msg: 'An error occured tryig to get flex details');
    }
  }

  // function to delete reoccuring date from list
  void deleteDate(String format) {
    reoccuringDates.removeWhere((element) => element.reoccuringDate == format);
    update();
  }

  // function to delete reoccuring date from list
  void deleteBrodcast(String location) {
    for (int i = 0; i < reoccuringLocations.length; i++) {
      if (reoccuringLocations[i].reoccuringDate.toLowerCase() ==
          location.toLowerCase()) {
        // remove the broadcast textual data location from the list of broadcast
        reoccuringLocations.remove(reoccuringLocations[i]);

        // remove the broadcast lat long locaton from list of brodcast
        reoccuringLatLongs.removeAt(i);
        update();
      }
    }
  }

  /// Instantiating a class of future values
  var futureValues = FutureValues();

  /// Variable to hold the bool state of spinner
  final showSpinner = false.obs;

  /// Variable to hold the bool state of spinner
  final showSaveSpinner = false.obs;

  /*Controllers and Variables for host a flex*/
  /// A [TextEditingController] to control the input text for name flex
  final TextEditingController nameFlexController = TextEditingController();

  /// A [TextEditingController] to control the input text for select a date
  final TextEditingController dateController = TextEditingController();

  /// A [TextEditingController] to control the input text for select a date
  final TextEditingController startTimeController = TextEditingController();

  /// A [TextEditingController] to control the input text for select a date
  final TextEditingController endTimeController = TextEditingController();

  /// A [TextEditingController] to control the input text for event hash tag
  final TextEditingController eventHashTagController = TextEditingController();

  /// A [TextEditingController] to control the input text for number of people
  final TextEditingController numberOfPeopleController =
      TextEditingController();

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

  /// A variable to hold the flex start time
  DateTime? pickedDate;

  /// A variable to hold the flex start time
  DateTime? startTime;

  /// A variable to hold the flex end time
  DateTime? endTime;

  /// A variable to check if user can pick time or not
  final allowPickTime = false.obs;

  /// A variable to hold the payment status
  final paid = ''.obs;

  /// A variable to hold the public or private status
  final publicOrPrivate = ''.obs;

  /// A variable to hold the flex location
  final displayFlexLocation = ''.obs;

  /// A variable to hold the gender restriction
  final genderRestriction = ''.obs;

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
  RxList<File> image = <File>[].obs;

  RxList<ReoccuringWidget> reoccuringDates = <ReoccuringWidget>[].obs;

  RxList<ReoccuringWidget> reoccuringLocations = <ReoccuringWidget>[].obs;

  RxList<List<String>> reoccuringLatLongs = <List<String>>[].obs;

  RxList<http.MultipartFile> multiPartImages = <http.MultipartFile>[].obs;

  /// Function to convert file to multipart
  void convertFileToMultipart() async {
    multiPartImages.value = [];
    update();
    for (int i = 0; i < image.length; i++) {
      multiPartImages.add(
        await http.MultipartFile.fromPath('bannerImage', image[i].path),
      );
    }
    log(':::lengthOfMultiPartImages: ${multiPartImages.length}');
  }

  /// Variable to hold a list of location that user types
  RxList<Location> location = <Location>[].obs;

  final loginEditSpinner = false.obs;

  FlexSuccess? createdFlex;
  //RxList<FlexSuccess>? createdFlex = <FlexSuccess>[].obs;

  bool isAddressSearch = false;

  /// Function to get user location and use [LatLang] in the map
  Future<void> getUserLocation() async {
    isAddressSearch = true;
    update();
    await futureValues.getUserLocation().then((value) async {
      isAddressSearch = false;
      update();
      lat.value = double.parse(value[0]).toString();
      long.value = double.parse(value[1]).toString();
      List<Placemark> placeMarks = await placemarkFromCoordinates(
          double.parse(value[0]), double.parse(value[1]));
      Placemark place = placeMarks[0];
      flexAddress.text =
          ('${place.name} ${place.street}, ${place.locality}, ${place.country}');
    }).catchError((e) async {
      isAddressSearch = false;
      update();
      throw (e);
    });
  }

  /// Function to launch the url for the video link
  Future<void> launchVideo() async {
    if (!await launch(videoLinkController.text))
      throw 'Could not launch ${videoLinkController.text}';
  }

  /// Function to get user location and use [LatLang] in the map
  Future<String> formatLocation(double lat, double lon) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(lat, lon);
    Placemark place = placeMarks[0];
    return ('${place.street}, ${place.locality}, ${place.country}');
  }

  /// Function to get user location and use [LatLang] in the map
  void getUserLatLongByAddress(String address) async {
    List<Location> locations = await locationFromAddress(address);
    location.value = locations;
  }

  /// Function to get the formatted date for date time picker
  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  /*Api Integration*/
  editFlex(String code) async {
    loginEditSpinner.value = true;
    List broadcastLocation = [];
    List recurringDates = [];
    for (final latLngBroadcast in reoccuringLatLongs) {
      broadcastLocation.add({
        'locationName': latLngBroadcast[2],
        'coordinates': {
          'lat': latLngBroadcast[0],
          'lng': latLngBroadcast[1],
        }
      });
    }
    for (final broadcastTime in reoccuringDates) {
      final dateString = broadcastTime.reoccuringDate.split('/');
      final newDate = DateTime(
        int.parse(dateString[2]),
        int.parse(dateString[1]),
        int.parse(dateString[0]),
      );
      final fromDate = DateTime(
        newDate.year,
        newDate.month,
        newDate.day,
        startTime?.hour ?? 0,
        startTime?.minute ?? 0,
        startTime?.second ?? 0,
        startTime?.millisecond ?? 0,
      );
      recurringDates.add(
        {
          'fromDate': fromDate.toString(),
          'toDate': endTime.toString(),
        },
      );
    }
    Map<String, dynamic> body = {
      'lat': lat.value,
      'lng': long.value,
      'name': nameFlexController.text,
      'fromDate': startTime.toString(),
      'toDate': endTime.toString(),
      'capacity': numberOfPeopleController.text,
      'ageRating': ageRating.value == '18+' ? '18' : '17',
      'flexType': typeOfFlex.value,
      'hashtag': eventHashTagController.text,
      'payStatus': paid.value,
      'viewStatus': publicOrPrivate.value,
      'showOnAccepted': displayFlexLocation.value == 'Yes' ? 'true' : 'false',
      'genderRestriction': genderRestriction.value != 'All genders allowed'
          ? genderRestriction
          : 'Both',
      'consumablesPolicy': consumablePolicy.value,
      'flexRules': flexRulesController.text,
      'videoLink': videoLinkController.text,
      'broadcastLocations': broadcastLocation,
      'recurringDates': recurringDates,
    };
    var api = FlexDataSource();
    await api.editFlex(multiPartImages, body, code).then((value) {
      /// calling the [UserController] for [HostFlexTermsAndConditions]
      final UserController userController = Get.put(UserController());
      userController.getDashboardFlex();
      userController.getFlexHistory();
      Functions.showToast('Flex updated successfully');
      loginEditSpinner.value = false;
      Get.back();
    }).catchError((e) {
      convertFileToMultipart();
      loginEditSpinner.value = false;
      log(':::error: $e');
      Functions.showToast(e.toString());
    });
  }
}
