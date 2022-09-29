import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flex_my_way/screens/host/host-flex-success.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flex_my_way/util/util.dart';
import 'package:flex_my_way/components/components.dart';
import 'package:flex_my_way/networking/networking.dart';
import 'package:flex_my_way/controllers/controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_count_down/timer_count_down.dart';
import '../onboarding/login.dart';
import '../settings/settings.dart';
import '../web-view.dart';

class HostFlexTermsAndConditions extends StatefulWidget {

  static const String id = "hostFlexTermsAndConditions";
  const HostFlexTermsAndConditions({Key? key}) : super(key: key);

  @override
  State<HostFlexTermsAndConditions> createState() => _HostFlexTermsAndConditionsState();
}

class _HostFlexTermsAndConditionsState extends State<HostFlexTermsAndConditions> {

  /// calling the [HostController] for [HostFlexTermsAndConditions]
  final HostController hostController = Get.put(HostController());

  /// calling the [HostController] for [HostFlexTermsAndConditions]
  final UserController userController = Get.put(UserController());

  /// Google map controller
  final Completer<GoogleMapController> _mapController = Completer();

  /// Function for _onMapCreated
  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }


  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  /// bool value to hold the state of user logged in
  bool isLoggedIn = false;

  @override
  void initState() {
    checkUserIsLoggedIn();
    super.initState();
  }

  /// function to check if the user is currently logged in
  void checkUserIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('loggedIn') == true) {
      setState(() {
        isLoggedIn = true;
        log('logged in');
      });
    }
    else {
      log('User is not logged in');
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        title: Text(
          AppStrings.hostAFlex,
          style: textTheme.headline4!.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: DismissKeyboard(
        child: SizedBox(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: SingleChildScrollView(
            child: Obx(() => AbsorbPointer(
                absorbing: hostController.showSpinner.value,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          AppStrings.termsAndConditions,
                          style: textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight! * 0.47,
                        padding: const EdgeInsets.fromLTRB(2, 24, 2, 10),
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(24)),
                        child: const RawScrollbar(
                          thumbColor: primaryColor,
                          radius: Radius.circular(8.0),
                          thickness: 4.0,
                          isAlwaysShown: true,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: SingleChildScrollView(
                              child: Text(AppStrings.loremIpsum),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      // hostController.paid.value == 'Paid'
                      //   ? Padding(
                      //       padding: const EdgeInsets.symmetric(horizontal: 30),
                      //       child: Form(
                      //         key: _formKey,
                      //         child: CustomTextFormField(
                      //           hintText: AppStrings.yourBVN,
                      //           textEditingController: hostController.bvnController,
                      //           validator: (value) {
                      //             if(value!.isEmpty && hostController.paid.value == 'Paid') {
                      //               return 'This field is required';
                      //             }
                      //             return null;
                      //           },
                      //         ),
                      //       ),
                      //     )
                      //   : Container(),
                      Text(
                        AppStrings.acceptThe,
                        style: textTheme.headline5!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          AppStrings.termsAndConditions,
                          style: textTheme.bodyText2,
                        ),
                        trailing: Checkbox(
                          value: hostController.termsAndConditionsAccepted.value,
                          onChanged: (value) {
                            hostController.termsAndConditionsAccepted.toggle();
                          },
                        ),
                      ),
                      const SizedBox(height: 5),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          AppStrings.privacyPolicy,
                          style: textTheme.bodyText2!,
                        ),
                        trailing: Checkbox(
                          value: hostController.privacyPolicyAccepted.value,
                          onChanged: (value) {
                            hostController.privacyPolicyAccepted.toggle();
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      Align(
                        alignment: Alignment.center,
                        child: Opacity(
                          opacity: (hostController.termsAndConditionsAccepted.value
                            && hostController.privacyPolicyAccepted.value) == true
                              ? 1.0 : 0.7,
                          child: Button(
                            label: AppStrings.finish,
                            onPressed: () {
                              if(hostController.termsAndConditionsAccepted.value
                                  && hostController.privacyPolicyAccepted.value) {
                                isLoggedIn == true
                                  ? _showPreviewDialog(context, textTheme)
                                  : login();
                              }
                            },
                            child: hostController.showSpinner.value == false
                              ?  null
                              : const SizedBox(
                                  height: 19,
                                  width: 19,
                                  child: CircleProgressIndicator(),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ),
          ),
        ),
      ),
    );
  }

  _showPreviewDialog(BuildContext context, TextTheme textTheme) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.9),
      builder: (context) => Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 60),
                Text(
                  'Flex Preview',
                  style: textTheme.headline2!.copyWith(
                    color: whiteColor,
                    fontSize: 27,
                    fontWeight: FontWeight.w600
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: whiteColor,
                    size: 31,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 3.0,
                    color: whiteColor,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          initialPage: 0,
                          autoPlay: true,
                          viewportFraction: 1,
                          height: SizeConfig.screenHeight! * 0.77,
                        ),
                        items: hostController.image.map((e) {
                          return Image.file(
                            File(e.path.toString()),
                            height: SizeConfig.screenHeight! * 0.7,
                            fit: BoxFit.cover,
                          );
                        }).toList(),
                      )
                    ),
                    DraggableScrollableSheet(
                        minChildSize: 0.5,
                        initialChildSize: 0.5,
                        maxChildSize: 0.7,
                        builder: (context, scrollController) {
                          return Container(
                            width: SizeConfig.screenWidth,
                            padding: const EdgeInsets.only(top: 4),
                            decoration:  const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                              color: backgroundColor,
                            ),
                            child: SingleChildScrollView(
                              controller: scrollController,
                              physics: const BouncingScrollPhysics(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            hostController.nameFlexController.text,
                                            style: textTheme.headline4!.copyWith(
                                              color: primaryColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 30,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 26),
                                        Container(
                                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(23),
                                            color: whiteColor,
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                Functions.getFlexDayAndMonth(
                                                  DateTime.parse(hostController.dateController.text))[0],
                                                style: textTheme.headline5!.copyWith(
                                                  color: primaryColor,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                Functions.getFlexDayAndMonth(
                                                    DateTime.parse(hostController.dateController.text))[1],
                                                style: textTheme.headline5!.copyWith(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Time',
                                                style: textTheme.bodyText1!.copyWith(
                                                  fontSize: 16,
                                                  color: neutralColor.withOpacity(0.5),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                '${Functions.getFlexTime(hostController.startTime!)} - '
                                                    '${Functions.getFlexTime(hostController.endTime!)}',
                                                style: textTheme.bodyText1!.copyWith(
                                                  fontSize: 18.5,
                                                  color: neutralColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          style: TextButton.styleFrom(
                                            backgroundColor: primaryColor, //const Color(0xFFE9EEF4),
                                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                          ),
                                          child: hostController.showSpinner.value == false
                                              ? Text(
                                                  hostController.paid.value == 'Free' ? 'Join Flex' : 'Buy Flex Ticket',
                                                  style: textTheme.button!.copyWith(
                                                    fontSize: 15,
                                                    color: whiteColor,
                                                  ),
                                                )
                                              : const Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 18),
                                                  child: SizedBox(
                                                    height: 17,
                                                    width: 17,
                                                    child: CircleProgressIndicator(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 32),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppStrings.host,
                                              style: textTheme.headline5!.copyWith(
                                                color: neutralColor.withOpacity(0.5),
                                                fontSize: 16.5,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              userController.username.value,
                                              style: textTheme.bodyText1!.copyWith(
                                                fontSize: 18.5,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              'First Time Host',
                                              style: textTheme.headline5!.copyWith(
                                                color: primaryColor,
                                                fontSize: 16.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Container(
                                        //   width: 72,
                                        //   height: 72,
                                        //   decoration: BoxDecoration(
                                        //     borderRadius: BorderRadius.circular(16),
                                        //     image: const DecorationImage(
                                        //       image: AssetImage(hostImage),
                                        //       fit: BoxFit.cover,
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    /// video link button
                                    hostController.videoLinkController.text != ''
                                      ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(() => WebViewer(url: hostController.videoLinkController.text));
                                          },
                                          child: Stack(
                                            children: const [
                                              Icon(
                                                Icons.movie,
                                                color: primaryColor,
                                                size: 57,
                                              ),
                                              Positioned(
                                                top: 23,
                                                left: 19,
                                                child: Icon(
                                                  Icons.play_arrow,
                                                  color: whiteColor,
                                                  size: 21,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                    )
                                      : const SizedBox(),
                                    /// about
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'About/Rules',
                                          style: textTheme.bodyText1!.copyWith(
                                            fontSize: 18.5,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          hostController.flexRulesController.text,
                                          style: textTheme.headline5!.copyWith(fontSize: 16.5),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 25),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        //guest
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Guests',
                                                style: textTheme.bodyText1!.copyWith(
                                                  fontSize: 18.5,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                '0 / ${hostController.numberOfPeopleController.text} Total',
                                                style: textTheme.headline5!.copyWith(fontSize: 16.5),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        //provided
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Consumable Policy',
                                                style: textTheme.bodyText1!.copyWith(
                                                  fontSize: 18.5,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                hostController.consumablePolicy.value,
                                                style: textTheme.headline5!.copyWith(fontSize: 16.5),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 25),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        //nature of flex
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Nature of Flex',
                                                style: textTheme.bodyText1!.copyWith(
                                                  fontSize: 18.5,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                hostController.typeOfFlex.value,
                                                style: textTheme.headline5!.copyWith(fontSize: 16.5),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        //rsvp
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'RSVP',
                                                style: textTheme.bodyText1!.copyWith(
                                                  fontSize: 18.5,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                userController.phoneNumber.value,
                                                style: textTheme.headline5!.copyWith(fontSize: 16.5),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 32),
                                    Container(
                                      width: SizeConfig.screenWidth,
                                      height: SizeConfig.screenHeight! * 0.25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: GoogleMap(
                                          mapType: MapType.normal,
                                          initialCameraPosition: CameraPosition(
                                            target: LatLng(
                                              double.parse(hostController.lat.value),
                                              double.parse(hostController.long.value),
                                            ),
                                            zoom: 18.0,
                                          ),
                                          onMapCreated: _onMapCreated,
                                          scrollGesturesEnabled: false,
                                          zoomControlsEnabled: false,
                                          zoomGesturesEnabled: false,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    TextButton(
                                      onPressed: () async {
                                        Clipboard.setData(
                                            ClipboardData(
                                                text: hostController.flexAddress.text)
                                        ).then((value) {
                                          Functions.showMessage('Flex location copied');
                                        }).catchError((e){
                                          Functions.showMessage('Could not copy flex link');
                                        });
                                      },
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.content_copy_outlined,
                                            color: primaryColor,
                                            size: 12,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            'Click to Copy Address',
                                            style: textTheme.headline5!.copyWith(
                                              color: primaryColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: SizeConfig.screenWidth! * 0.4,
              child: Button(
                label: '',
                color: whiteColor,
                labelColor: primaryColor,
                onPressed: () {
                  if (userController.canHostFlex.value == true) {
                    Get.back();
                    _hostFlex();
                  } else {
                    Get.back();
                    _showRedirectToProfileUpgrade(textTheme, context);
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Go live',
                      style: textTheme.bodyText2!.copyWith(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.rss_feed_outlined,
                      color: primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  /// Function to make api call to host flex
  void _hostFlex() async {
    hostController.showSpinner.value = true;
    Map<String, String> body = {
      'lat': hostController.lat.value,
      'lng': hostController.long.value,
      'name': hostController.nameFlexController.text,
      'fromDate': hostController.startTime.toString(),
      'toDate': hostController.endTime.toString(),
      'capacity': hostController.numberOfPeopleController.text,
      'ageRating': hostController.ageRating.value,
      'flexType': hostController.typeOfFlex.value,
      'hashtag': hostController.eventHashTagController.text,
      'payStatus': hostController.paid.value,
      'viewStatus': hostController.publicOrPrivate.value,
      'showOnAccepted': hostController.displayFlexLocation.value == 'Yes'
        ? 'true'
        : 'false',
      'genderRestriction': '${hostController.genderRestriciton}',
      'consumablesPolicy': hostController.consumablePolicy.value,
      'flexRules': hostController.flexRulesController.text,
      'videoLink': hostController.videoLinkController.text,
    };
    var api = FlexDataSource();
    await api.createFlex(hostController.multiPartImages.value, body).then((flexSuccess) {
      hostController.image.clear();
      hostController.multiPartImages.clear();
      hostController.update();
      /// calling the [UserController] for [HostFlexTermsAndConditions]
      final UserController userController = Get.put(UserController());
      userController.getDashboardFlex();
      userController.getFlexHistory();
      hostController.createdFlex = flexSuccess;
      hostController.showSpinner.value = false;
      Get.offAllNamed(HostFlexSuccess.id);
    }).catchError((e){
      hostController.showSpinner.value = false;
      log(':::error: $e');
      print(e);
      Functions.showMessage(e.toString());
    });
  }

  ///widget to prompt user if they want to logout
  Future<void> _showRedirectToProfileUpgrade(TextTheme textTheme, BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: Text(
          AppStrings.profileUpgrade,
          style: textTheme.headline5!.copyWith(fontWeight: FontWeight.w600),
        ),
        content: Text(
          AppStrings.profileUpgradePrompt,
          style: textTheme.bodyText1!.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            style: TextButton.styleFrom(
              primary: primaryColor,
            ),
            child: const Text('Cancel'),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton(
              onPressed: () async {
                Get.back();
                Get.toNamed(Settings.id);
              },
              style: TextButton.styleFrom(
                primary: primaryColor,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    AppStrings.profileUpgrade,
                  ),
                  Countdown(
                    seconds: 5,
                    build: (context, double time) => Text(
                      ' (${time.toInt()})',
                    ),
                    onFinished: () {
                      if(!mounted) return;
                      Get.back();
                      Get.toNamed(Settings.id);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Function to login and set a notifier of re - hosting saved flex
  void login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('flexReminder', true);
    Navigator.pushNamed(context, Login.id);
  }
}