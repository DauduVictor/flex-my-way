import 'package:flex_my_way/screens/find-a-flex.dart';
import 'package:flex_my_way/screens/host/host_flex_terms_and_conditions.dart';
import 'package:flex_my_way/screens/host/host_registration.dart';
import 'package:flex_my_way/screens/onboarding/forgot_password.dart';
import 'package:flex_my_way/screens/host/host_a_flex.dart';
import 'package:flex_my_way/screens/host/host_flex_success.dart';
import 'package:flex_my_way/screens/onboarding/login.dart';
import 'package:flex_my_way/screens/splash-screen.dart';
import 'package:flex_my_way/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flex My Way',
      theme: AppTheme.themeData,
      home: const SplashScreen(),
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        Login.id: (context) => const Login(),
        ForgotPassword.id: (context) => const ForgotPassword(),
        FindAFlex.id: (context) => const FindAFlex(),
        HostRegistration.id: (context) => const HostRegistration(),
        HostAFlex.id: (context) => const HostAFlex(),
        HostFlexTermsAndConditions.id: (context) => const HostFlexTermsAndConditions(),
        HostFlexSuccess.id: (context) => const HostFlexSuccess(),
      },
    );
  }
}
