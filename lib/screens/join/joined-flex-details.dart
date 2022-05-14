import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../components/flex-loader.dart';
import '../../controllers/join-controller.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/functions.dart';
import '../../util/constants/strings.dart';
import '../../util/size-config.dart';

class JoinedFlexDetails extends StatelessWidget {

  static const String id = "joinedFlexDetails";
  JoinedFlexDetails({Key? key}) : super(key: key);

  /// calling the [JoinController] for [JoinFlex]
  final JoinController joinController = Get.put(JoinController());

  /// Google map controller
  final Completer<GoogleMapController> _mapController = Completer();

  /// Function for _onMapCreated
  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }

  final CameraPosition userPosition = const CameraPosition(
    target: LatLng(6.519314, 3.396336),
    zoom: 16.0,
  );

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(unsplashImage),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 55),
                //appbar
                Hero(
                  tag: 'joinTag',
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                      backgroundColor: whiteColor,
                      radius: 22,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
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
          ),
          DraggableScrollableSheet(
              minChildSize: 0.5,
              maxChildSize: 0.77,
              builder: (context, controller) {
                return Container(
                  width: SizeConfig.screenWidth,
                  padding: const EdgeInsets.only(top: 4.0),
                  decoration:  const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: backgroundColor,
                  ),
                  child: SingleChildScrollView(
                    controller: controller,
                    child: joinController.isFlexLoaded == false
                      ? const FlexLoader()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      joinController.joinedFlex!.name!,
                                      style: textTheme.headline4!.copyWith(
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 26),
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(23),
                                      color: whiteColor,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          // 'DEC',
                                          Functions.getFlexDayAndMonth(DateTime(2021-12-04))[0],
                                          style: textTheme.headline5!.copyWith(
                                            color: primaryColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          // '25'
                                          Functions.getFlexDayAndMonth(DateTime(2021-12-04))[1],
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
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 26),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE9EEF4),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Text(
                                      'Join this flex',
                                      style: textTheme.button!.copyWith(
                                        color: whiteColor,
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
                                        // 'Kelechi Mo.',
                                        joinController.joinedFlex!.name!,
                                        style: textTheme.bodyText1!.copyWith(
                                          fontSize: 18.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'First Time Hoster',
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
                              const SizedBox(height: 32),
                              //about
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
                                    // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                                    //     'Amet lorem tellus viverra venenatis dui id vitae phasellus odio. '
                                    //     'Viverra diam venenatis aliquet imperdiet ultrices nullam gravida viverra faucibus.'
                                    //     ' Donec varius tortor mauris gravida sed amet ligula tempus.',
                                    joinController.joinedFlex!.name!,
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
                                          // '100/200 Total',
                                          '${joinController.joinedFlex!.capacity!} Total',
                                          style: textTheme.headline5!.copyWith(fontSize: 16.5),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  //provided
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        // 'Food & Drinks',
                                        joinController.joinedFlex!.consumablesPolicy!,
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
                                          // 'Beach Flex',
                                          joinController.joinedFlex!.flexType!,
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
                                    scrollGesturesEnabled: false,
                                    myLocationEnabled: false,
                                    myLocationButtonEnabled: false,
                                    zoomControlsEnabled: false,
                                    zoomGesturesEnabled: false,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 9),
                              GestureDetector(
                                onTap: () {},
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
                              const SizedBox(height: 17),
                              Container(
                                width: SizeConfig.screenWidth,
                                height: SizeConfig.screenHeight! * 0.25,
                                padding: const EdgeInsets.fromLTRB(30, 27, 30, 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: whiteColor,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        color: Colors.black.withOpacity(0.9),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(30, 12, 30, 0),
                                      child: Text(
                                        'Scan this code at the flex location',
                                        textAlign: TextAlign.center,
                                        style: textTheme.bodyText1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 35),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }

}
