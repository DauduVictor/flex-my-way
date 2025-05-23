import 'dart:async';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_my_way/screens/join/joined-flex-details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flex_my_way/components/components.dart';
import 'package:flex_my_way/util/util.dart';
import 'package:flex_my_way/controllers/controllers.dart';
import 'package:flex_my_way/networking/networking.dart';
import '../onboarding/login.dart';
import 'package:flex_my_way/model/model.dart';

import '../web-view.dart';

class JoinFlex extends StatelessWidget {

  final Flexes? flex;

  static const String id = "joinFlex";
  JoinFlex({
    Key? key,
    this.flex,
  }) : super(key: key);

  /// calling the [JoinController] for [JoinFlex]
  final JoinController controller = Get.put(JoinController());

  /// calling the user controller [UserController]
  final UserController userController = Get.put(UserController());

  final CameraPosition userPosition = const CameraPosition(
    target: LatLng(
      6.519314,
      3.396336,
    ),
    zoom: 16.0,
  );

  /// Google map controller
  final Completer<GoogleMapController> _mapController = Completer();

  /// Function for _onMapCreated
  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: Stack(
              children: [
                CachedNetworkImage(
                  width: SizeConfig.screenWidth!,
                  height: SizeConfig.screenHeight! * 0.65,
                  alignment: Alignment.topCenter,
                  imageUrl: flex!.bannerImage!,
                  progressIndicatorBuilder: (context, url, downloadProgress) {
                    return SpinKitCircle(
                      color: primaryColor.withOpacity(0.7),
                    );
                  },
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
                Column(
                  children: [
                    const SizedBox(height: 55),
                    //appbar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: CircleAvatar(
                          backgroundColor: whiteColor,
                          radius: 22,
                          child: TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.only(left: 8),
                              shape: const CircleBorder(),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: neutralColor,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //body
                  ],
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
              minChildSize: 0.4,
              maxChildSize: 0.7,
              builder: (context, scrollController) {
                return Container(
                  width: SizeConfig.screenWidth,
                  padding: const EdgeInsets.only(top: 4),
                  decoration:  const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: backgroundColor,
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Obx(() => AbsorbPointer(
                        absorbing: controller.showSpinner.value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      flex!.name!,
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
                                          'Dec',
                                          // Functions.getFlexDayAndMonth(flex!.fromDate!)[0],
                                          style: textTheme.headline5!.copyWith(
                                            color: primaryColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          '20',
                                          // Functions.getFlexDayAndMonth(flex!.fromDate!)[1],
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
                                          '1:00PM - 1:00AM',
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
                                    onPressed: () {
                                      if (userController.isLoggedIn.value) {
                                        if(flex!.payStatus! == 'Paid') {
                                          Functions.showMessage('You will be redirected to the payment gateway to make payment');
                                        }
                                        else {
                                          _joinFlex(flex!.joinCode!);
                                        }
                                      }
                                      else {
                                        Functions.showMessage('Please log in to join a flex.');
                                        Get.toNamed(Login.id);
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: primaryColor, //const Color(0xFFE9EEF4),
                                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: controller.showSpinner.value == false
                                        ? Text(
                                            flex!.payStatus! == 'Free' ? 'Join Flex' : 'Buy Flex Ticket',
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
                                        flex!.creator?.name ?? 'Victor',
                                        style: textTheme.bodyText1!.copyWith(
                                          fontSize: 18.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'Multiple Time Hoster',
                                        style: textTheme.headline5!.copyWith(
                                          color: primaryColor,
                                          fontSize: 16.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 72,
                                    height: 72,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      image: const DecorationImage(
                                        image: AssetImage(hostImage),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              /// video link button
                              GestureDetector(
                                onTap: () {
                                  // controller.launchVideo('https://youtube.com').catchError((e){
                                  //   Functions.showMessage('Could not launch url');
                                  // });
                                  Get.to(() => WebViewer(url: flex!.videoLink!));
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
                              /// about
                              const SizedBox(height: 16),
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
                                    flex!.flexRules!,
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
                                          '100/200 Total',
                                          style: textTheme.headline5!.copyWith(fontSize: 16.5),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  //provided
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        flex!.consumablesPolicy!,
                                        style: textTheme.bodyText1!.copyWith(
                                          fontSize: 18.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Will be Provided',
                                        style: textTheme.headline5!.copyWith(fontSize: 16.5),
                                      ),
                                    ],
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
                                          flex!.flexType!,
                                          style: textTheme.headline5!.copyWith(fontSize: 16.5),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  //rsvp
                                  Column(
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
                                        '+234 706 197 2722',
                                        style: textTheme.headline5!.copyWith(fontSize: 16.5),
                                      ),
                                    ],
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
                                    initialCameraPosition: userPosition,
                                    onMapCreated: _onMapCreated,
                                    myLocationEnabled: false,
                                    myLocationButtonEnabled: false,
                                    scrollGesturesEnabled: false,
                                    zoomControlsEnabled: false,
                                    zoomGesturesEnabled: false,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              GestureDetector(
                                onTap: () async {
                                  Clipboard.setData(
                                    ClipboardData(
                                      text: await controller.formatLocation(
                                        flex!.locationCoordinates!.lat!,
                                        flex!.locationCoordinates!.lng!
                                      ))
                                    ).then((value) {
                                    Functions.showMessage('Flex location copied');
                                  }).catchError((e){
                                    Functions.showMessage('Could not copy flex link');
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                      )
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }

  /// Function to make api call to join flex
  void _joinFlex(String joinCode) async {
    controller.showSpinner.value = true;
    var api = FlexDataSource();
    await api.joinFlex(joinCode).then((flex) {
      controller.showSpinner.value = false;
      controller.joinedFlex = flex;
      Functions.showMessage('Successfully joined flex!');
      Get.toNamed(JoinedFlexDetails.id);
    }).catchError((e){
      log(e);
      controller.showSpinner.value = false;
      Functions.showMessage(e);
    });
  }
}
