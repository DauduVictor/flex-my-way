import 'package:flutter/material.dart';

const primaryColor = Color(0xFF7259F7);
const lightPurpleColor = Color(0xFFB482DB);
const primaryColorVariant = Color(0xFFDDD7FD);
const backgroundColor = Color(0xFFF8F7FE);
const whiteColor = Colors.white;
const neutralWhiteColor = Color(0xFFDBDDE0);
const transparentColor = Colors.transparent;
const neutralColor = Color(0xFF003951);
const neutralColorLight = Color(0xFFDBDDE0);
const errorColor = Color(0xFFDB3704);
const greenColor = Color(0xFF00A41A);
const splashBackgroundColor = Color(0xFF86CBF0);
const lightTextColor = Color(0xFF374957);
const lightButtonColor = Color(0xFF7D9AA5);

// images
const uploadIcon = 'assets/images/svgs/upload_icon.svg';
const empty = 'assets/images/svgs/empty.svg';
const successImage = 'assets/images/svgs/success.svg';
const helpHeadSetImage = 'assets/images/svgs/fi-br-headset.svg';
const splashScreenLocationImage = 'assets/images/svgs/location.svg';
const splashScreenLocationImage2 = 'assets/images/jpegs/locationImage.png';
const darkBackgroundImage = 'assets/images/jpegs/darker-background-image.png';
const loginDecoratedImage = 'assets/images/jpegs/login-decorated-screen.png';
const flexBackgroundImage = 'assets/images/jpegs/flex-history-background-image.png';
const hostImage = 'assets/images/jpegs/host-image.png';
const unsplashImage = 'assets/images/jpegs/unsplash_3cBFqagweZM.png';
const splashImage = 'assets/images/jpegs/splash-image.png';
const markerImage = 'assets/images/jpegs/marker-icon.png';
const agentImage = 'assets/images/jpegs/search-splash.gif';

BorderRadius appBarBottomBorder = const BorderRadius.only(
  bottomLeft: Radius.circular(30.0),
  bottomRight: Radius.circular(30.0),
);

List<dynamic> ageRating = ['Below 18', '18+'];
List<String> preferredFlexes = [
  'After Party',
  'Ball',
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
  'Others'
];

// List<String> paidOrFree = ['Free', 'Paid'];
List<String> paidOrFree = ['Free'];
List<String> publicOrPrivate = ['Public', 'Private'];
List<bool> displayToOnlyAcceptedParticipants = [false, true];
List<String> isGenderRestrictions = ['Only Female', 'Only Male', 'Both'];
List<String> yesOrNo = ['Yes', 'No'];
List<String> foodAndDrinkPolicy = [
  'Food & Drinks @ a cost',
  'Come with your Drinks',
  'You can come with your Food and Drinks',
  'Food and Drinks are not allowed',
  'Free Food and Drink',
  'Men come with a bottle of Drink',
  'Women come with a bottle of Drink',
  'Not applicable'
];
List<String> genders = ['Male', 'Female'];
List<String> infoSource = ['Social Media', 'Friend', 'Website'];
