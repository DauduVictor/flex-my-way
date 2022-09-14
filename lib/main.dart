import 'package:flex_my_way/screens/dashboard/dashboard.dart';
import 'package:flex_my_way/screens/dashboard/edit-flex.dart';
import 'package:flex_my_way/screens/dashboard/pending-invites.dart';
import 'package:flex_my_way/screens/find-a-flex.dart';
import 'package:flex_my_way/screens/flex-history/FlexHistoryImageArchive.dart';
import 'package:flex_my_way/screens/flex-history/flex-history-detail.dart';
import 'package:flex_my_way/screens/flex-history/flex-history.dart';
import 'package:flex_my_way/screens/flex-media/flexery.dart';
import 'package:flex_my_way/screens/flex-media/upload-image.dart';
import 'package:flex_my_way/screens/host/beta-sms.dart';
import 'package:flex_my_way/screens/host/contact-screen.dart';
import 'package:flex_my_way/screens/host/host-flex-terms-and-conditions.dart';
import 'package:flex_my_way/screens/host/host-registration.dart';
import 'package:flex_my_way/screens/join/join-flex.dart';
import 'package:flex_my_way/screens/join/join.dart';
import 'package:flex_my_way/screens/join/joined-flex-details.dart';
import 'package:flex_my_way/screens/dashboard/notifications.dart';
import 'package:flex_my_way/screens/onboarding/forgot-password.dart';
import 'package:flex_my_way/screens/host/host-a-flex.dart';
import 'package:flex_my_way/screens/host/host-flex-success.dart';
import 'package:flex_my_way/screens/onboarding/login.dart';
import 'package:flex_my_way/screens/onboarding/reset-password.dart';
import 'package:flex_my_way/screens/onboarding/sign-up.dart';
import 'package:flex_my_way/screens/payment/add-card.dart';
import 'package:flex_my_way/screens/payment/payment-method.dart';
import 'package:flex_my_way/screens/settings/about.dart';
import 'package:flex_my_way/screens/settings/edit-profile-detail.dart';
import 'package:flex_my_way/screens/settings/help-and-support.dart';
import 'package:flex_my_way/screens/settings/privacy-policy.dart';
import 'package:flex_my_way/screens/settings/settings.dart';
import 'package:flex_my_way/screens/settings/terms-and-condition.dart';
import 'package:flex_my_way/screens/onboarding/onboarding-screen.dart';
import 'package:flex_my_way/screens/splash-screen.dart';
import 'package:flex_my_way/screens/theme/app-theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flex My Way',
      theme: AppTheme.themeData,
      initialRoute: SplashScreen.id,
      enableLog: true,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        OnboardingScreen.id: (context) => const OnboardingScreen(),
        Login.id: (context) => Login(),
        ForgotPassword.id: (context) => ForgotPassword(),
        ResetPassword.id: (context) =>  ResetPassword(),
        SignUp.id: (context) => SignUp(),
        FindAFlex.id: (context) => FindAFlex(),
        HostRegistration.id: (context) => HostRegistration(),
        HostAFlex.id: (context) => HostAFlex(),
        HostFlexTermsAndConditions.id: (context) => HostFlexTermsAndConditions(),
        HostFlexSuccess.id: (context) => HostFlexSuccess(),
        BetaSms.id: (context) => BetaSms(),
        Dashboard.id: (context) => const Dashboard(),
        Flexery.id: (context) => Flexery(),
        Notifications.id: (context) => Notifications(),
        Settings.id: (context) => Settings(),
        About.id: (context) => const About(),
        EditProfileDetail.id: (context) => EditProfileDetail(),
        TermsAndCondition.id: (context) => const TermsAndCondition(),
        PrivacyPolicy.id: (context) => const PrivacyPolicy(),
        HelpAndSupport.id: (context) => const HelpAndSupport(),
        PendingInvites.id: (context) => PendingInvites(),
        FlexHistory.id: (context) => FlexHistory(),
        FlexHistoryDetail.id: (context) => FlexHistoryDetail(),
        Join.id: (context) => const Join(),
        JoinFlex.id: (context) => JoinFlex(),
        JoinedFlexDetails.id: (context) => JoinedFlexDetails(),
        ContactScreen.id: (context) => ContactScreen(),
        UploadImage.id: (context) => UploadImage(),
        EditFlex.id: (context) => const EditFlex(),
        FlexHistoryImageArchive.id: (context) => FlexHistoryImageArchive(),
        PaymentMethod.id: (context) => PaymentMethod(),
        AddCard.id: (context) => AddCard(),
      },
    );
  }
}

// for a join user
// - settings
// - gallery
// - history
// -