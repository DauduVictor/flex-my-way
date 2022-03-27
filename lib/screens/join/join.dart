import 'dart:async';
import 'package:flex_my_way/screens/join/join-flex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../util/constants/constants.dart';
import '../../util/size-config.dart';
import '../dashboard/drawer.dart';
import '../notifications.dart';

class Join extends StatefulWidget {

  static const String id = "join";
  const Join({Key? key}) : super(key: key);

  @override
  _JoinState createState() => _JoinState();
}

class _JoinState extends State<Join> {

  /// Bool variable to hold the bool state if the user is currently logged in
  bool isLoggedIn = false;

  /// function to check if the user is currently logged in
  void checkUserIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('loggedIn') == true) {
      setState(() {
        isLoggedIn = true;
      });
    }
  }

  /// Google map controller
  Completer<GoogleMapController> _mapController = Completer();

  /// Function for _onMapCreated
  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }

  CameraPosition userPosition = const CameraPosition(
    target: LatLng(6.519314, 3.396336),
    zoom: 19.3,
  );

  /// Variable to hold the state of the pay button
  bool _pay = true;

  /// Variable to hold value of price range
  double priceRange = 0;

  @override
  void initState() {
    checkUserIsLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      drawer: const RefactoredDrawer(),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: userPosition,
            myLocationEnabled: false,
            onMapCreated: _onMapCreated,
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
                                        return const Notifications();
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
                const SizedBox(height: 200),
                Center(
                  child: CircleAvatar(
                    backgroundColor: whiteColor,
                    radius: 18,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, JoinFlex.id);
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(6),
                        shape: const CircleBorder(),
                      ),
                      child: const Icon(
                        Icons.location_pin,
                        color: primaryColor,
                        size: 21,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            maxChildSize: 0.5,
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 10.0),
                      child: Center(
                        child: Container(
                          height: 5,
                          width: 45,
                          decoration: BoxDecoration(
                            color: const Color(0xFF000000).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: controller,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(26, 17, 5, 15),
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
                                  ReuableMapFilterButton(
                                    text: '18+',
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
                                    const SizedBox(height: 17),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'N5,000',
                                            style: textTheme.headline5!.copyWith(
                                              color: primaryColor,
                                              fontSize: 19,
                                            ),
                                          ),
                                          Text(
                                            'N50,000',
                                            style: textTheme.headline5!.copyWith(
                                              color: primaryColor,
                                              fontSize: 19,
                                            ),
                                          ),
                                          Text(
                                            'N100,000',
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
                                      max: 100000,
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
                      ),
                    ),
                  ],
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
