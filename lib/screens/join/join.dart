import 'dart:async';
import 'package:flex_my_way/screens/join/join-flex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bloc/future-values.dart';
import 'package:flex_my_way/model/model.dart';
import 'package:flex_my_way/util/util.dart';
import 'package:flex_my_way/networking/networking.dart';
import '../dashboard/drawer.dart';
import '../dashboard/notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Join extends StatefulWidget {

  static const String id = "join";
  const Join({Key? key}) : super(key: key);

  @override
  _JoinState createState() => _JoinState();
}

class _JoinState extends State<Join> with TickerProviderStateMixin {

  /// Instantiating a class of future values
  var futureValues = FutureValues();

  var locationPermission = LocationPermissionCheck();

  var api = FlexDataSource();

  CameraPosition? userPosition;

  /// Google map controller
  final Completer<GoogleMapController> _mapController = Completer();

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

  /// Function to get user location and use [LatLang] in the map
  void getUserLocation() async {
    if(!mounted) return;
    await futureValues.getUserLocation().then((value) {
      if(!mounted) return;
      setState(() {
        lat = double.parse(value[0]);
        long = double.parse(value[1]);
      });
      _getFlexByLocation(lat, long);
      userPosition = CameraPosition(
        target: LatLng(lat, long),
        zoom: 19.5,
      );
      _getFlexMarkers(lat, long);
    }).catchError((e) async {
      print(e);
      if(!mounted) return;
      if(e.toString().contains('denied')) {
        await locationPermission.buildLocationRequest(context).then((value) {
          getUserLocation();
        });
      }
    });
  }

  /// Function to make api call to get flex by [LatLang]
  void _getFlexByLocation(double lat, double long) async {
    await api.getFlexByLocation(lat, long).then((value) {
      setState(() {
        flex = value;
        flexLength = flex.length;
      });
      _buildFlexOnMap();
    }).catchError((e) {
      if (!mounted) return;
      print(e);
      Functions.showMessage(e);
    });
  }

  /// Function to build markers on the map from [List<Flexes>]
  void _buildFlexOnMap() {
    if (flex.isNotEmpty && flexLength > 0) {
      for (int i = 0; i < flex.length; i++) {
        _markers.add(
          Marker(
            markerId: MarkerId('markerFlexId$i'),
            position: LatLng(
              lat,
              long,
            ),
            icon: customIcon!,
            onTap: () {
              Navigator.pushNamed(context, JoinFlex.id);
            }
          ),
        );
      }
    } else {
      Functions.showMessage('It seems like we couldn\'t find flexes close to you. Try again!');
    }
  }



  /// function to check if the user is currently logged in
  void checkUserIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('loggedIn') == true) {
      setState(() {
        isLoggedIn = true;
      });
    }
  }

  /// Function to create icon with the help of [customIcon]
  void _createCustomMarkerIcon(context) {
    if(customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, markerImage).then((value) {
        setState(() {
          customIcon = value;
        });
      }).catchError((e){
        Functions.showMessage('Unable to connect to google maps at this time, please try again');
      });
    }
  }

  /// function to get a list of markers to be displayed to the user
  void _getFlexMarkers(double lat, double long) {
     _markers.add(
       Marker(
         markerId: const MarkerId('markerId'),
         position: LatLng(lat, long),
         icon: customIcon!,
         onTap: () {
           Navigator.pushNamed(context, JoinFlex.id);
         }
       ),
     );
  }

  /// Bool variable to hold the bool state if the user is currently logged in
  bool isLoggedIn = false;

  /// Variable to hold the state of the pay button
  bool _pay = true;

  /// Variable to hold value of price range
  double priceRange = 0;

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
    _colorTweenAnimation = ColorTween(begin: Colors.black, end: Colors.purpleAccent).animate(CurvedAnimation(
        curve: Curves.linear,
        parent: _controller
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _createCustomMarkerIcon(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      drawer: const RefactoredDrawer(),
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
              initialCameraPosition: userPosition!,
              myLocationEnabled: true,
              buildingsEnabled: false,
              myLocationButtonEnabled: false,
              onMapCreated: _onMapCreated,
              markers: _markers,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 50),
                //appbar
                isLoggedIn == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Builder(
                            builder: (context) {
                              return CircleAvatar(
                                backgroundColor: whiteColor,
                                radius: 22,
                                child: TextButton(
                                  onPressed: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(8),
                                    shape: const CircleBorder(),
                                  ),
                                  child: const Icon(
                                    Icons.menu_rounded,
                                    color: neutralColor,
                                    size: 24,
                                  ),
                                ),
                              );
                            }
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      transitionDuration: const Duration(milliseconds: 600),
                                      pageBuilder: (context, animation, secondaryAnimation) {
                                        return Notifications();
                                      },
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        return Container(
                                          color: whiteColor.withOpacity(animation.value),
                                          child: SlideTransition(
                                            position: animation.drive(
                                              Tween(
                                                begin: const Offset(0.0, -1.0),
                                                end: Offset.zero,
                                              ).chain(CurveTween(curve: Curves.easeInCubic)),
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
                      ],
                  )
                  : Align(
                    alignment: Alignment.centerLeft,
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
              ],
            ),
          ),
          DraggableScrollableSheet(
            maxChildSize: 0.68,
            initialChildSize: 0.3,
            minChildSize: 0.1,
            builder: (context, controller) {
              return Container(
                width: SizeConfig.screenWidth,
                clipBehavior: Clip.hardEdge,
                decoration:  const BoxDecoration(
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
                        padding: const EdgeInsets.fromLTRB(26, 40, 5, 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Filters',
                              style: textTheme.headline5!.copyWith(fontSize: 28),
                            ),
                            const SizedBox(height: 17),
                            Text(
                              'Preferred Age Range',
                              style: textTheme.headline5!.copyWith(fontSize: 17),
                            ),
                            const SizedBox(height: 17),
                            Row(
                              children: [
                                ReuableMapFilterButton(
                                  text: '18 - 25',
                                  onPressed: () {},
                                  color: primaryColor,
                                ),
                                ReuableMapFilterButton(
                                  text: '25+',
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            //occupation
                            Text(
                              'Occupation',
                              style: textTheme.headline5!.copyWith(fontSize: 17),
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
                            const SizedBox(height: 30),
                            Text(
                              'Cost of Entry',
                              style: textTheme.headline5!.copyWith(fontSize: 17),
                            ),
                            const SizedBox(height: 17),
                            Row(
                              children: [
                                ReuableMapFilterButton(
                                  text: 'Free',
                                  onPressed: () {},
                                ),
                                ReuableMapFilterButton(
                                  text: 'Paid',
                                  onPressed: () {},
                                  color: primaryColor,
                                ),
                              ],
                            ),
                            _pay == true
                                ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20),
                                    Text(
                                      'What paid flex range are you looking at?',
                                      style: textTheme.headline5!.copyWith(fontSize: 17),
                                    ),
                                    const SizedBox(height: 21),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'N1,000',
                                            style: textTheme.headline5!.copyWith(
                                              color: primaryColor,
                                              fontSize: 19,
                                            ),
                                          ),
                                          Text(
                                            'N5,000',
                                            style: textTheme.headline5!.copyWith(
                                              color: primaryColor,
                                              fontSize: 19,
                                            ),
                                          ),
                                          Text(
                                            'N20,000',
                                            style: textTheme.headline5!.copyWith(
                                              color: primaryColor,
                                              fontSize: 19,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 9),
                                    Slider(
                                      value: priceRange,
                                      max: 20000,
                                      onChanged: (value) {
                                        setState(() {
                                          priceRange = value;
                                        });
                                    }),
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
                                      color: const Color(0xFF000000).withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(4),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: _controller.value * 7,
                                            color: _colorTweenAnimation.value.withOpacity(0.2),
                                        ),
                                        // BoxShadow(
                                        //   spreadRadius: 10,
                                        //   color: const Color(0xFF000000).withOpacity(0.05)
                                        // ),
                                      ]
                                  ),
                                );
                              }
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}

class ReuableMapFilterButton extends StatelessWidget {

  const ReuableMapFilterButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color
  }) : super(key: key);

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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            side: BorderSide(color: color ?? lightButtonColor.withOpacity(0.3)),
            padding: const EdgeInsets.symmetric(vertical: 13.5, horizontal: 24),
          ),
          child: Text(
            text,
            style: textTheme.headline5!.copyWith(
              fontSize: 14,
              color: color ?? lightButtonColor,
            ),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
