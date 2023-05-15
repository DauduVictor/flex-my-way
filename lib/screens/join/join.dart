import 'dart:async';
import 'dart:developer';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flex_my_way/components/components.dart';
import 'package:flex_my_way/screens/join/join-flex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bloc/future-values.dart';
import 'package:flex_my_way/model/model.dart';
import 'package:flex_my_way/util/util.dart';
import 'package:flex_my_way/networking/networking.dart';
import '../dashboard/notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

enum AgeFilter {
  below18,
  above18,
}

enum PayStatus {
  free,
  paid,
}

class Join extends StatefulWidget {
  static const String id = "join";
  const Join({Key? key}) : super(key: key);

  @override
  _JoinState createState() => _JoinState();
}

class _JoinState extends State<Join> with TickerProviderStateMixin {
  // AgeFilter selectedAge = AgeFilter.above18;
  // PayStatus payStatus = PayStatus.free;

  AgeFilter? selectedAge;
  PayStatus? payStatus;

  /// Instantiating a class of future values
  var futureValues = FutureValues();

  var locationPermission = LocationPermissionCheck();

  var api = FlexDataSource();

  CameraPosition? userPosition;

  /// Google map controller
  final Completer<GoogleMapController> _mapController = Completer();

  /// Focus node for search text editing controller
  final _searchFocusNode = FocusNode();

  /// Function for _onMapCreated
  void _onMapCreated(GoogleMapController controller) {
    // controller.animateCamera();
    _mapController.complete(controller);
  }

  /// Variable to hold a set of markers displayed to the user
  final Set<Marker> _markers = {};

  /// variable to hold custom icon used as the marker
  BitmapDescriptor? customIcon;

  /// Variable to hold latitude
  double lat = 0.0;

  /// Variable to hold longitude
  double long = 0.0;

  /// Variable to hold flex list
  List<Flexes> flex = [];

  /// Variable to hold flex length
  int flexLength = 0;

  /// Variable to hold the param to send
  String ageParam = '18+';

  /// Variable to hold the param to send
  String payParam = 'free';

  /// Function to get user location and use [LatLang] in the map
  void getUserLocation() async {
    if (!mounted) return;
    await futureValues.getUserLocation().then((value) {
      if (!mounted) return;
      setState(() {
        lat = double.parse(value[0]);
        long = double.parse(value[1]);
      });
      // _getFlexByLocation(lat, long, ageStatus: ageParam, payStatus: payParam);
      userPosition = CameraPosition(
        target: LatLng(lat, long),
        zoom: 19.5,
      );
    }).catchError((e) async {
      log(e);
      if (!mounted) return;
      if (e.toString().contains('denied')) {
        await locationPermission.buildLocationRequest(context).then((value) {
          getUserLocation();
        });
      }
    });
  }

  /// Function to make api call to get flex by [LatLang]
  void _getFlexByLocation(double lat, double long,
      {String? ageStatus, String? payStatus}) async {
    _markers.clear();
    flexLength = 0;
    GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.zoomOut());
    _showFlexSearchDialog(context);
    await api.getFlexByLocation(lat, long,ageStatus: ageStatus, payStatus: payStatus)
      .then((value) {
        setState(() {
          flex = value;
          flexLength = flex.length;
          controller.animateCamera(CameraUpdate.zoomBy(1.2));
          log(flexLength.toString());
        });
        _buildFlexOnMap();
        if (!mounted) return;
        Get.back();
      }).catchError((e) {
        if (!mounted) return;
        Get.back();
        log(e);
        Functions.showMessage(e);
      });
  }

  ///widget to prompt user if they want to logout
  Future<void> _showFlexSearchDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: whiteColor,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: SizeConfig.screenWidth! * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              SpinKitThreeBounce(
                color: primaryColor.withOpacity(0.88),
                size: 35,
              ),
              const Text(
                'Finding your flex...',
                style: TextStyle(
                  color: neutralColor,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 20,
                child: AnimatedTextKit(
                  repeatForever: true,
                  pause: const Duration(milliseconds: 1000),
                  animatedTexts: [
                    FadeAnimatedText(
                      'Just a moment',
                      textAlign: TextAlign.center,
                      textStyle: const TextStyle(
                        fontSize: 12.5,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                      duration: const Duration(milliseconds: 1000),
                    ),
                    FadeAnimatedText(
                      'hold on a sec.',
                      textAlign: TextAlign.center,
                      textStyle: const TextStyle(
                        fontSize: 12.5,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                      duration: const Duration(milliseconds: 1000),
                    ),
                    FadeAnimatedText(
                      'almost there..',
                      textAlign: TextAlign.center,
                      textStyle: const TextStyle(
                        fontSize: 12.5,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                      duration: const Duration(milliseconds: 1000),
                    ),
                    FadeAnimatedText(
                      'finding the closest flex..',
                      textAlign: TextAlign.center,
                      textStyle: const TextStyle(
                        fontSize: 12.5,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                      duration: const Duration(milliseconds: 1300),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// Function to build markers on the map from [List<Flexes>]
  void _buildFlexOnMap() {
    if (flex.isNotEmpty && flexLength > 0) {
      for (int i = 0; i < flex.length; i++) {
        _markers.add(
          Marker(
              markerId: MarkerId('markerFlexId$i'),
              position: LatLng(
                flex[i].locationCoordinates?.lat ?? lat,
                flex[i].locationCoordinates?.lng ?? long,
              ),
              icon: customIcon!,
              onTap: () {
                Get.to(() => JoinFlex(flex: flex[i]));
              }),
        );
      }
    } else {
      Functions.showMessage(
          'It seems like we couldn\'t find flexes close to you. Try again!');
    }
  }

  /// function to check if the user is currently logged in
  void checkUserIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('loggedIn') == true) {
      setState(() {
        isLoggedIn = true;
      });
    }
  }

  /// Function to create icon with the help of [customIcon]
  void _createCustomMarkerIcon(context) {
    if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, markerImage).then((value) {
        setState(() {
          customIcon = value;
        });
      }).catchError((e) {
        Functions.showMessage(
            'Unable to connect to google maps at this time, please try again');
      });
    }
  }

  /// Bool variable to hold the bool state if the user is currently logged in
  bool isLoggedIn = false;

  /// Variable to hold the state of the pay button
  bool _pay = false;

  /// Variable to hold value of price range
  double priceRange = 0;

  /// Variable to hold is search bool
  bool isSearchEnabled = false;

  /// bool to hold search api state
  bool showSearchSpinner = false;

  /// Declaring the animation controller
  late AnimationController _controller;

  /// Declaring the tween animation
  late Animation _colorTweenAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _controller.repeat(reverse: true);
    getUserLocation();
    checkUserIsLoggedIn();
    super.initState();

    /// setting the [_glowingAnimation] as a tween value
    _colorTweenAnimation = ColorTween(
            begin: Colors.black, end: Colors.purpleAccent)
        .animate(CurvedAnimation(curve: Curves.linear, parent: _controller));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    FocusScopeNode currentFocus = FocusScope.of(context);
    _createCustomMarkerIcon(context);
    final textTheme = Theme.of(context).textTheme;
    return DismissKeyboard(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            userPosition == null
              ? SpinKitDoubleBounce(
                  color: primaryColor.withOpacity(0.6),
                  size: 75,
                  duration: const Duration(milliseconds: 3000),
                )
              : GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(lat, long),
                    zoom: 19.5,
                  ),
                  myLocationEnabled: true,
                  buildingsEnabled: false,
                  myLocationButtonEnabled: false,
                  onMapCreated: _onMapCreated,
                  markers: _markers,
                  onTap: (value) {
                    if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
                  },
                ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  //appbar
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: whiteColor,
                        radius: 22,
                        child: TextButton(
                          onPressed: () {
                            if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
                            Get.back();
                          },
                          style: TextButton.styleFrom(
                            padding:
                                const EdgeInsets.fromLTRB(12, 8, 6, 8),
                            shape: const CircleBorder(),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: neutralColor,
                            size: 22,
                          ),
                        ),
                      ),
                      Expanded(
                        child: AnimatedCrossFade(
                          duration: const Duration(milliseconds: 200),
                          firstCurve: Curves.easeIn,
                          secondCurve: Curves.fastOutSlowIn,
                          crossFadeState: isSearchEnabled == false
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          firstChild: isLoggedIn ? Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          transitionDuration:
                                              const Duration(
                                                  milliseconds: 600),
                                          pageBuilder: (context,
                                              animation,
                                              secondaryAnimation) {
                                            return Notifications();
                                          },
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            return Container(
                                              color:
                                                  whiteColor.withOpacity(
                                                      animation.value),
                                              child: SlideTransition(
                                                position: animation.drive(
                                                  Tween(
                                                    begin: const Offset(
                                                        0.0, -1.0),
                                                    end: Offset.zero,
                                                  ).chain(CurveTween(
                                                      curve: Curves
                                                          .easeInCubic)),
                                                ),
                                                child: child,
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: const Icon(
                                      IconlyLight.notification,
                                      color: Colors.black,
                                      size: 23,
                                    ),
                                  ),
                                  Positioned(
                                    right: 2.3,
                                    top: 0.8,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        width: 6,
                                        height: 6,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ) : const SizedBox(),
                          secondChild: Container(
                            margin: const EdgeInsets.only(left: 3.5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: whiteColor,
                            ),
                            child: TextField(
                              keyboardType: TextInputType.text,
                              focusNode: _searchFocusNode,
                              autofocus: true,
                              textInputAction: TextInputAction.search,
                              style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
                              onChanged: (value) {
                                if (value.length == 6) getFlexByCode(value);
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(
                                    5, 15, 5, 5),
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  IconlyLight.search,
                                  color: neutralColor.withOpacity(0.3),
                                  size: 16,
                                ),
                                hintText: 'Search flex code',
                                hintStyle: textTheme.bodyLarge!.copyWith(
                                  fontSize: 13.5,
                                  color: primaryColor.withOpacity(0.3),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(24)),
                                  borderSide:
                                      BorderSide(color: neutralColor),
                                ),
                                suffixIcon: showSearchSpinner == true
                                    ? SizedBox(
                                        width: 5,
                                        height: 5,
                                        child: SpinKitCircle(
                                          color: primaryColor
                                              .withOpacity(0.9),
                                          size: 25,
                                        ),
                                      )
                                    : const SizedBox(
                                        width: 2,
                                        height: 2,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            DraggableScrollableSheet(
                maxChildSize: 0.48,
                initialChildSize: 0.2,
                minChildSize: 0.1,
                builder: (context, controller) {
                  return Container(
                    width: SizeConfig.screenWidth,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: backgroundColor,
                    ),
                    child: SingleChildScrollView(
                      controller: controller,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(26, 40, 5, 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Filters',
                                  style: textTheme.headlineSmall!
                                      .copyWith(fontSize: 28.5),
                                ),
                                const SizedBox(height: 17),
                                Text(
                                  'Preferred Age Range',
                                  style: textTheme.headlineSmall!
                                      .copyWith(fontSize: 17.5),
                                ),
                                const SizedBox(height: 17),
                                Row(
                                  children: [
                                    ReuableMapFilterButton(
                                      text: 'Below 18',
                                      onPressed: () {
                                        if (selectedAge != AgeFilter.below18) {
                                          setState(() {
                                            ageParam = '18-';
                                            selectedAge = AgeFilter.below18;
                                          });
                                          _getFlexByLocation(lat, long,
                                              ageStatus: ageParam,
                                              payStatus: payParam);
                                          _animateController(controller);

                                          ///TODO: amimate the camera here
                                        }
                                      },
                                      color: selectedAge == AgeFilter.below18
                                          ? primaryColor
                                          : null,
                                    ),
                                    ReuableMapFilterButton(
                                      text: '18+',
                                      onPressed: () {
                                        if (selectedAge != AgeFilter.above18) {
                                          setState(() {
                                            ageParam = '18+';
                                            selectedAge = AgeFilter.above18;
                                          });
                                          _getFlexByLocation(lat, long,
                                              ageStatus: ageParam,
                                              payStatus: payParam);
                                          _animateController(controller);

                                          ///TODO: amimate the camera here
                                        }
                                      },
                                      color: selectedAge == AgeFilter.above18
                                          ? primaryColor
                                          : null,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                //occupation
                                /*Text(
                                'Occupation',
                                style: textTheme.headlineSmall!.copyWith(fontSize: 17),
                              ),
                              const SizedBox(height: 17),
                              Row(
                                children: [
                                  ReuableMapFilterButton(
                                    text: 'Student',
                                    onPressed: () {},
                                  ),
                                  ReuableMapFilterButton(
                                    text: 'Working',
                                    onPressed: () {},
                                  ),
                                  ReuableMapFilterButton(
                                    text: 'Don\'t mind',
                                    onPressed: () {},
                                    color: primaryColor,
                                  ),
                                ],
                              ),
                              //cost of entry
                              const SizedBox(height: 30),*/
                                Text(
                                  'Cost of Entry',
                                  style: textTheme.headlineSmall!
                                      .copyWith(fontSize: 17.5),
                                ),
                                const SizedBox(height: 17),
                                Row(
                                  children: [
                                    ReuableMapFilterButton(
                                      text: 'Free',
                                      onPressed: () {
                                        if (payStatus != PayStatus.free) {
                                          setState(() {
                                            payParam = 'free';
                                            payStatus = PayStatus.free;
                                          });
                                          _getFlexByLocation(lat, long,
                                              payStatus: payParam,
                                              ageStatus: ageParam);
                                          _animateController(controller);

                                          ///TODO: amimate the camera here
                                        }
                                      },
                                      color: payStatus == PayStatus.free
                                          ? primaryColor
                                          : null,
                                    ),
                                    Visibility(
                                      visible: false,
                                      child: ReuableMapFilterButton(
                                        text: 'Paid',
                                        onPressed: () {
                                          if (payStatus != PayStatus.paid) {
                                            setState(() {
                                              payParam = 'paid';
                                              payStatus = PayStatus.paid;
                                            });
                                            // _getFlexByLocation(lat, long, payStatus: payParam, ageStatus: ageParam);
                                            _animateController(controller);

                                            ///TODO: amimate the camera here
                                          }
                                        },
                                        color: payStatus == PayStatus.paid
                                            ? primaryColor
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                                payStatus == PayStatus.paid
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 15),
                                          Text(
                                            'What paid flex range are you looking at?',
                                            style: textTheme.headlineSmall!
                                                .copyWith(fontSize: 17.5),
                                          ),
                                          const SizedBox(height: 30),
                                          Slider(
                                              value: priceRange,
                                              max: 100000,
                                              divisions: 1000,
                                              label: 'N${priceRange.round()}',
                                              onChanged: (value) {
                                                setState(() {
                                                  priceRange = value;
                                                });
                                              }),
                                          const SizedBox(height: 2),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'N1,000',
                                                  style: textTheme
                                                      .headlineSmall!
                                                      .copyWith(
                                                    color: primaryColor,
                                                    fontSize: 19.5,
                                                  ),
                                                ),
                                                Text(
                                                  'N100,000',
                                                  style: textTheme
                                                      .headlineSmall!
                                                      .copyWith(
                                                    color: primaryColor,
                                                    fontSize: 19.5,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Center(
                              child: AnimatedBuilder(
                                  animation: _controller,
                                  builder: (context, child) {
                                    return Container(
                                      height: 5,
                                      width: 45,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF000000)
                                              .withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          boxShadow: [
                                            BoxShadow(
                                              spreadRadius:
                                                  _controller.value * 7,
                                              color: _colorTweenAnimation.value
                                                  .withOpacity(0.2),
                                            ),
                                            // BoxShadow(
                                            //   spreadRadius: 10,
                                            //   color: const Color(0xFF000000).withOpacity(0.05)
                                            // ),
                                          ]),
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (!isSearchEnabled) {
              setState(() {
                isSearchEnabled = true;
              });
            }
            await Future.delayed(const Duration(milliseconds: 150))
                .then((value) {
              if (!_searchFocusNode.hasFocus) {
                 _searchFocusNode.requestFocus();
              }
            });
          },
          elevation: 10,
          backgroundColor: primaryColor,
          child: const Icon(
            IconlyLight.search,
            color: whiteColor,
          ),
        ),
      ),
    );
  }

  void _animateController(ScrollController controller) {
    controller.animateTo(-20,
        duration: const Duration(milliseconds: 400), curve: Curves.linear);
  }

  void getFlexByCode(String flexCode) async {
    setState(() => showSearchSpinner = true);
    await api.getFlexByCode(flexCode)
      .then((value) {
        if (!mounted) return;
        setState(() {
          showSearchSpinner = false;
          log(flexLength.toString());
        });
        Get.to(() => JoinFlex(flex: value));
      }).catchError((e) {
        if (!mounted) return;
        setState(() => showSearchSpinner = false);
        log(e);
        Functions.showMessage('Flex not found');
      });
  }
}

class ReuableMapFilterButton extends StatelessWidget {
  const ReuableMapFilterButton(
      {Key? key, required this.text, required this.onPressed, this.color})
      : super(key: key);

  final String text;
  final void Function() onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            side: BorderSide(color: color ?? lightButtonColor.withOpacity(0.3)),
            padding: const EdgeInsets.symmetric(vertical: 13.5, horizontal: 24),
          ),
          child: Text(
            text,
            style: textTheme.headlineSmall!.copyWith(
              fontSize: 14.5,
              color: color ?? lightButtonColor,
            ),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
