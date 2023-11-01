import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flex_my_way/screens/host/host-flex-success.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../settings/terms-and-condition.dart';
import '../web-view.dart';

class HostFlexTermsAndConditions extends StatefulWidget {
  static const String id = "hostFlexTermsAndConditions";
  const HostFlexTermsAndConditions({Key? key}) : super(key: key);

  @override
  State<HostFlexTermsAndConditions> createState() =>
      _HostFlexTermsAndConditionsState();
}

class _HostFlexTermsAndConditionsState
    extends State<HostFlexTermsAndConditions> {
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
    if (prefs.getBool('loggedIn') == true) {
      setState(() {
        isLoggedIn = true;
        log('logged in');
      });
    } else {
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
          style:
              textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w600),
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
                            style: textTheme.headlineSmall!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight! * 0.47,
                          padding: const EdgeInsets.fromLTRB(2, 14, 2, 10),
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(24)),
                          child: const Scrollbar(
                            radius: Radius.circular(8.0),
                            thickness: 4.0,
                            thumbVisibility: true,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    HeadingText(textName: '1. Introduction'),
                                    SubHeadingText(
                                        textNo: '1.1.	',
                                        textName: AppStrings.section11),
                                    SubHeadingText(
                                        textNo: '1.2.	',
                                        textName: AppStrings.section12),
                                    SubHeadingText(
                                        textNo: '1.3.	',
                                        textName: AppStrings.section13),
                                    SubHeadingText(
                                        textNo: '1.4.	',
                                        textName: AppStrings.section14),
                                    SizedBox(height: 10),
                                    HeadingText(textName: '2. Definitions'),
                                    SubHeadingText(
                                        textNo: '2.1.	',
                                        textName: AppStrings.section21),
                                    SubHeadingText(
                                        textNo: '2.1.1 	',
                                        textName: AppStrings.section211),
                                    SubHeadingText(
                                        textNo: '2.1.2	',
                                        textName: AppStrings.section212),
                                    SubHeadingText(
                                        textNo: '2.1.3	',
                                        textName: AppStrings.section213),
                                    SizedBox(height: 10),
                                    HeadingText(
                                        textName: '3. Limitation of Liability'),
                                    SubHeadingText(
                                        textNo: '3.1.	',
                                        textName: AppStrings.section31),
                                    SizedBox(height: 10),
                                    HeadingText(
                                        textName:
                                            '4. Relationship of the parties'),
                                    SubHeadingText(
                                        textNo: '4.1.	',
                                        textName: AppStrings.section41),
                                    SubHeadingText(
                                        textNo: '4.1.1 	',
                                        textName: AppStrings.section411),
                                    SubHeadingText(
                                        textNo: '4.1.2	',
                                        textName: AppStrings.section412),
                                    SubHeadingText(
                                        textNo: '4.1.3	',
                                        textName: AppStrings.section413),
                                    SubHeadingText(
                                        textNo: '4.1.4	',
                                        textName: AppStrings.section414),
                                    SubHeadingText(
                                        textNo: '4.2.	',
                                        textName: AppStrings.section42),
                                    SubHeadingText(
                                        textNo: '4.3.	',
                                        textName: AppStrings.section43),
                                    SubHeadingText(
                                        textNo: '4.3.1 	',
                                        textName: AppStrings.section431),
                                    SubHeadingText(
                                        textNo: '4.3.2	',
                                        textName: AppStrings.section432),
                                    SubHeadingText(
                                        textNo: '4.3.3	',
                                        textName: AppStrings.section433),
                                    SubHeadingText(
                                        textNo: '4.3.4	',
                                        textName: AppStrings.section434),
                                    SubHeadingText(
                                        textNo: '4.4.	',
                                        textName: AppStrings.section44),
                                    SizedBox(height: 10),
                                    HeadingText(textName: '5. Amendment'),
                                    SubHeadingText(
                                        textNo: '5.1.	',
                                        textName: AppStrings.section51),
                                    SizedBox(height: 10),
                                    HeadingText(
                                        textName:
                                            '6. Account Information and useage'),
                                    SubHeadingText(
                                        textNo: '6.1.	',
                                        textName: AppStrings.section61),
                                    SubHeadingText(
                                        textNo: '6.2.	',
                                        textName: AppStrings.section62),
                                    SubHeadingText(
                                        textNo: '6.3.	',
                                        textName: AppStrings.section63),
                                    SizedBox(height: 10),
                                    HeadingText(textName: '7. Indemnity'),
                                    SubHeadingText(
                                        textNo: '7.1.	',
                                        textName: AppStrings.section71),
                                    SubHeadingText(
                                        textNo: '7.2.	',
                                        textName: AppStrings.section72),
                                    SizedBox(height: 10),
                                    HeadingText(
                                        textName: '8. Disclaimer and Warranty'),
                                    SubHeadingText(
                                        textNo: '8.1.	',
                                        textName: AppStrings.section71),
                                    SubHeadingText(
                                        textNo: '8.1.1 	',
                                        textName: AppStrings.section811),
                                    SubHeadingText(
                                        textNo: '8.1.2 	',
                                        textName: AppStrings.section812),
                                    SubHeadingText(
                                        textNo: '8.1.3 	',
                                        textName: AppStrings.section813),
                                    SubHeadingText(
                                        textNo: '8.2.	',
                                        textName: AppStrings.section82),
                                    SubHeadingText(
                                        textNo: '8.3.	',
                                        textName: AppStrings.section84),
                                    SubHeadingText(
                                        textNo: '8.4.	',
                                        textName: AppStrings.section82),
                                    SizedBox(height: 10),
                                    HeadingText(textName: '9. Termination'),
                                    SubHeadingText(
                                        textNo: '9.1.	',
                                        textName: AppStrings.section71),
                                    SubHeadingText(
                                        textNo: '9.1.1 	',
                                        textName: AppStrings.section911),
                                    SubHeadingText(
                                        textNo: '9.1.2 	',
                                        textName: AppStrings.section912),
                                    SubHeadingText(
                                        textNo: '9.1.3 	',
                                        textName: AppStrings.section913),
                                    SubHeadingText(
                                        textNo: '9.1.4 	',
                                        textName: AppStrings.section914),
                                    SizedBox(height: 10),
                                    HeadingText(textName: '10. Severability'),
                                    SubHeadingText(
                                        textNo: '10.1.	',
                                        textName: AppStrings.section101),
                                    SubHeadingText(
                                        textNo: '10.1.	',
                                        textName: AppStrings.section102),
                                    SubHeadingText(
                                        textNo: '10.1.	',
                                        textName: AppStrings.section103),
                                    SizedBox(height: 10),
                                    HeadingText(
                                        textName:
                                            '11. Governing Law and Dispute'),
                                    SubHeadingText(
                                        textNo: '11.1.	',
                                        textName: AppStrings.section111),
                                    SizedBox(height: 10),
                                    HeadingText(
                                        textName: '12. Entire Agreement'),
                                    SubHeadingText(
                                        textNo: '12.1.	',
                                        textName: AppStrings.section1221),
                                    SizedBox(height: 40),
                                  ],
                                ),
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
                          style: textTheme.headlineSmall!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            AppStrings.termsAndConditions,
                            style: textTheme.bodyMedium,
                          ),
                          trailing: Checkbox(
                            value:
                                hostController.termsAndConditionsAccepted.value,
                            onChanged: (value) {
                              hostController.termsAndConditionsAccepted
                                  .toggle();
                            },
                          ),
                        ),
                        const SizedBox(height: 5),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            AppStrings.privacyPolicy,
                            style: textTheme.bodyMedium!,
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
                            opacity: (hostController
                                            .termsAndConditionsAccepted.value &&
                                        hostController
                                            .privacyPolicyAccepted.value) ==
                                    true
                                ? 1.0
                                : 0.7,
                            child: Button(
                              label: AppStrings.finish,
                              onPressed: () {
                                if (hostController
                                        .termsAndConditionsAccepted.value &&
                                    hostController
                                        .privacyPolicyAccepted.value) {
                                  isLoggedIn == true
                                      ? _showPreviewDialog(context, textTheme)
                                      : login();
                                }
                              },
                              child: hostController.showSpinner.value == false
                                  ? null
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
                )),
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
                            fontSize: 27.5,
                            fontWeight: FontWeight.w600),
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
                              )),
                          DraggableScrollableSheet(
                              minChildSize: 0.5,
                              initialChildSize: 0.5,
                              maxChildSize: 0.7,
                              builder: (context, scrollController) {
                                return Container(
                                  width: SizeConfig.screenWidth,
                                  padding: const EdgeInsets.only(top: 4),
                                  decoration: const BoxDecoration(
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18, vertical: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  hostController
                                                      .nameFlexController.text,
                                                  style: textTheme
                                                      .headlineMedium!
                                                      .copyWith(
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 30.5,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 26),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 14,
                                                        horizontal: 18),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(23),
                                                  color: whiteColor,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      Functions.getFlexDayAndMonth(
                                                          DateTime.parse(
                                                              hostController
                                                                  .dateController
                                                                  .text))[0],
                                                      style: textTheme
                                                          .headlineSmall!
                                                          .copyWith(
                                                        color: primaryColor,
                                                        fontSize: 20.5,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Text(
                                                      Functions.getFlexDayAndMonth(
                                                          DateTime.parse(
                                                              hostController
                                                                  .dateController
                                                                  .text))[1],
                                                      style: textTheme
                                                          .headlineSmall!
                                                          .copyWith(
                                                        fontSize: 20.5,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 30),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Time',
                                                      style: textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                        fontSize: 16.5,
                                                        color: neutralColor
                                                            .withOpacity(0.5),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${Functions.getFlexTime(hostController.startTime!)} - '
                                                      '${Functions.getFlexTime(hostController.endTime!)}',
                                                      style: textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                        fontSize: 19,
                                                        color: neutralColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {},
                                                style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      primaryColor, //const Color(0xFFE9EEF4),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 20,
                                                      horizontal: 24),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                  ),
                                                ),
                                                child: hostController
                                                            .showSpinner
                                                            .value ==
                                                        false
                                                    ? Text(
                                                        hostController.paid
                                                                    .value ==
                                                                'Free'
                                                            ? 'Join Flex'
                                                            : 'Buy Flex Ticket',
                                                        style: textTheme
                                                            .labelLarge!
                                                            .copyWith(
                                                          fontSize: 15.5,
                                                          color: whiteColor,
                                                        ),
                                                      )
                                                    : const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 18),
                                                        child: SizedBox(
                                                          height: 17,
                                                          width: 17,
                                                          child:
                                                              CircleProgressIndicator(),
                                                        ),
                                                      ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 32),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    AppStrings.host,
                                                    style: textTheme
                                                        .headlineSmall!
                                                        .copyWith(
                                                      color: neutralColor
                                                          .withOpacity(0.5),
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    userController
                                                        .username.value,
                                                    style: textTheme.bodyLarge!
                                                        .copyWith(
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    'First Time Host',
                                                    style: textTheme
                                                        .headlineSmall!
                                                        .copyWith(
                                                      color: primaryColor,
                                                      fontSize: 17,
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
                                          hostController.videoLinkController
                                                      .text !=
                                                  ''
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.to(() => WebViewer(
                                                            url: hostController
                                                                .videoLinkController
                                                                .text));
                                                      },
                                                      child: const Stack(
                                                        children: [
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'About/Rules',
                                                style: textTheme.bodyLarge!
                                                    .copyWith(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                hostController
                                                    .flexRulesController.text,
                                                style: textTheme.headlineSmall!
                                                    .copyWith(fontSize: 17),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 25),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              //guest
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Guests',
                                                      style: textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                      '0 / ${hostController.numberOfPeopleController.text} Total',
                                                      style: textTheme
                                                          .headlineSmall!
                                                          .copyWith(
                                                              fontSize: 17),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              //provided
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Consumable Policy',
                                                      style: textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                      hostController
                                                          .consumablePolicy
                                                          .value,
                                                      style: textTheme
                                                          .headlineSmall!
                                                          .copyWith(
                                                              fontSize: 17),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 25),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              //nature of flex
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Nature of Flex',
                                                      style: textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                        fontSize: 18.5,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                      hostController
                                                          .typeOfFlex.value,
                                                      style: textTheme
                                                          .headlineSmall!
                                                          .copyWith(
                                                              fontSize: 17),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              //rsvp
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'RSVP',
                                                      style: textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                        fontSize: 18.5,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                      userController
                                                          .phoneNumber.value,
                                                      style: textTheme
                                                          .headlineSmall!
                                                          .copyWith(
                                                              fontSize: 17.5),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 32),
                                          Container(
                                            width: SizeConfig.screenWidth,
                                            height:
                                                SizeConfig.screenHeight! * 0.25,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: GoogleMap(
                                                mapType: MapType.normal,
                                                initialCameraPosition:
                                                    CameraPosition(
                                                  target: LatLng(
                                                    double.parse(hostController
                                                        .lat.value),
                                                    double.parse(hostController
                                                        .long.value),
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
                                              Clipboard.setData(ClipboardData(
                                                      text: hostController
                                                          .flexAddressController
                                                          .text))
                                                  .then((value) {
                                                Functions.showMessage(
                                                    'Flex location copied');
                                              }).catchError((e) {
                                                Functions.showMessage(
                                                    'Could not copy flex link');
                                              });
                                            },
                                            style: TextButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 5.0),
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
                                                  style: textTheme
                                                      .headlineSmall!
                                                      .copyWith(
                                                    color: primaryColor,
                                                    fontSize: 12.5,
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
                            style: textTheme.bodyMedium!.copyWith(
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
            ));
  }

  /// Function to make api call to host flex
  void _hostFlex() async {
    hostController.showSpinner.value = true;
    List broadcastLocation = [];
    List recurringDates = [];
    for (final latLngBroadcast in hostController.reoccuringLatLongs) {
      broadcastLocation.add({
        'locationName': latLngBroadcast[2],
        'coordinates': {
          'lat': latLngBroadcast[0],
          'lng': latLngBroadcast[1],
        }
      });
    }
    for (final broadcastTime in hostController.reoccuringDates) {
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
        hostController.startTime?.hour ?? 0,
        hostController.startTime?.minute ?? 0,
        hostController.startTime?.second ?? 0,
        hostController.startTime?.millisecond ?? 0,
      );
      recurringDates.add(
        {
          'fromDate': fromDate.toString(),
          'toDate': hostController.endTime.toString(),
        },
      );
    }
    Map<String, dynamic> body = {
      'lat': hostController.lat.value,
      'lng': hostController.long.value,
      'name': hostController.nameFlexController.text,
      'fromDate': hostController.startTime.toString(),
      'toDate': hostController.endTime.toString(),
      'capacity': hostController.numberOfPeopleController.text,
      'ageRating': hostController.ageRating.value == '18+' ? '18' : '17',
      'flexType': hostController.typeOfFlex.value,
      'hashtag': hostController.eventHashTagController.text,
      'payStatus': hostController.paid.value,
      'viewStatus': hostController.publicOrPrivate.value,
      'showOnAccepted':
          hostController.displayFlexLocation.value == 'Yes' ? 'true' : 'false',
      'genderRestriction':
          hostController.genderRestriction.value != 'All genders allowed'
              ? hostController.genderRestriction
              : 'Both',
      'consumablesPolicy': hostController.consumablePolicy.value,
      'flexRules': hostController.flexRulesController.text,
      'videoLink': hostController.videoLinkController.text,
      'broadcastLocations': broadcastLocation,
      'recurringDates': recurringDates,
    };
    log(body.toString());
    var api = FlexDataSource();
    await api
        .createFlex(hostController.multiPartImages.value, body)
        .then((flexSuccess) {
      hostController.image.clear();
      hostController.multiPartImages.clear();
      hostController.update();

      /// calling the [UserController] for [HostFlexTermsAndConditions]
      final UserController userController = Get.put(UserController());
      userController.getUserProfile();
      userController.getDashboardFlex();
      userController.getFlexHistory();
      hostController.createdFlex = flexSuccess;
      hostController.showSpinner.value = false;
      Get.offAllNamed(HostFlexSuccess.id);
    }).catchError((e) {
      hostController.showSpinner.value = false;
      hostController.convertFileToMultipart();
      log(':::error: $e');
      print(e);
      Functions.showMessage(e.toString());
    });
  }

  ///widget to prompt user if they want to logout
  Future<void> _showRedirectToProfileUpgrade(
      TextTheme textTheme, BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: Text(
          AppStrings.profileUpgrade,
          style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w600),
        ),
        content: Text(
          AppStrings.profileUpgradePrompt,
          style: textTheme.bodyLarge!.copyWith(
            fontSize: 17.5,
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
                Get.to(Settings(upgradeUser: true));
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
                      if (!mounted) return;
                      Get.back();
                      Get.to(Settings(upgradeUser: true));
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
