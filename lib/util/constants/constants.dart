import 'package:flutter/material.dart';

const primaryColor = Color(0xFF7259F7);
const primaryColorVariant = Color(0xFFDDD7FD);
const backgroundColor = Color(0xFFF8F7FE);
const whiteColor = Colors.white;
const transparent = Colors.transparent;
const neutralColor = Color(0xFF003951);
const neutralColorLight = Color(0xFFDBDDE0);
const errorColor = Color(0xFFDB3704);
const greenColor = Color(0xFF00A41A);
const splashBackgroundColor = Color(0xFF86CBF0);
const lightTextColor = Color(0xFF374957);

// images
const splashBackground = 'assets/images/svgs/splash_background.svg';
const newSplash = 'assets/images/svgs/new_splash.svg';
const calendar = 'assets/images/svgs/calendar.svg';
const uploadIcon = 'assets/images/svgs/upload_icon.svg';
const cameraIcon = 'assets/images/svgs/camera.svg';
const successImage = 'assets/images/svgs/success.svg';
const copyIcon = 'assets/images/svgs/copy_icon.svg';
const shareIcon = 'assets/images/svgs/share_icon.svg';
const splashBackgroundImage = 'assets/images/jpegs/splash.png';

BorderRadius appBarBottomBorder = const BorderRadius.only(
  bottomLeft: Radius.circular(30.0),
  bottomRight: Radius.circular(30.0),
);

List<int> ageRating = [10, 13, 15, 16, 18];
List<String> typeOfFlex = [
  'After Party, Ball',
  'Banquet',
  'Birthday',
  'Beach',
  'Bach-Eve',
  'Block',
  'Cocktail',
  'Christmas',
  'Dinner',
  'Fundraising',
  'Graduation',
  'HouseWarming',
  'Marriage',
  'Pool',
  'Surprise',
  'Showers',
  'Welcome Others'
];

List<String> paidOrFree = ['Free', 'Paid'];
List<String> publicOrPrivate = ['Public', 'Private'];
List<bool> displayToOnlyAcceptedParticipants = [false, true];
List<bool> isGenderRestrictions = [false, true];
List<String> foodAndDrinkPolicy = ['Food', 'Drink'];
List<String> genders = ['Male', 'Female'];
List<String> occupations = ['Architect', 'Lawyer', 'Mobile Developer'];