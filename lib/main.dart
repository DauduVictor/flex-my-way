import 'package:flex_my_way/screens/dashboard/dashboard.dart';
import 'package:flex_my_way/screens/dashboard/pending-invites.dart';
import 'package:flex_my_way/screens/find-a-flex.dart';
import 'package:flex_my_way/screens/flex-history/flex-history-detail.dart';
import 'package:flex_my_way/screens/flex-history/flex-history.dart';
import 'package:flex_my_way/screens/flex-media/flexery.dart';
import 'package:flex_my_way/screens/host/host_flex_terms_and_conditions.dart';
import 'package:flex_my_way/screens/host/host_registration.dart';
import 'package:flex_my_way/screens/notifications.dart';
import 'package:flex_my_way/screens/onboarding/forgot_password.dart';
import 'package:flex_my_way/screens/host/host_a_flex.dart';
import 'package:flex_my_way/screens/host/host_flex_success.dart';
import 'package:flex_my_way/screens/onboarding/login.dart';
import 'package:flex_my_way/screens/settings/about.dart';
import 'package:flex_my_way/screens/settings/edit-profile-detail.dart';
import 'package:flex_my_way/screens/settings/help-and-support.dart';
import 'package:flex_my_way/screens/settings/privacy-policy.dart';
import 'package:flex_my_way/screens/settings/settings.dart';
import 'package:flex_my_way/screens/settings/terms-and-condition.dart';
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
        Dashboard.id: (context) => const Dashboard(),
        Flexery.id: (context) => const Flexery(),
        Notifications.id: (context) => const Notifications(),
        Settings.id: (context) => const Settings(),
        About.id: (context) => const About(),
        EditProfileDetail.id: (context) => const EditProfileDetail(),
        TermsAndCondition.id: (context) => const TermsAndCondition(),
        PrivacyPolicy.id: (context) => const PrivacyPolicy(),
        HelpAndSupport.id: (context) => const HelpAndSupport(),
        PendingInvites.id: (context) => const PendingInvites(),
        FlexHistory.id: (context) => const FlexHistory(),
        FlexHistoryDetail.id: (context) => const FlexHistoryDetail(),
      },
    );
  }
}
