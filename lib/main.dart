import 'package:flex_my_way/screens/dashboard/dashboard.dart';
import 'package:flex_my_way/screens/dashboard/pending-invites.dart';
import 'package:flex_my_way/screens/find-a-flex.dart';
import 'package:flex_my_way/screens/flex-history/flex-history-detail.dart';
import 'package:flex_my_way/screens/flex-history/flex-history.dart';
import 'package:flex_my_way/screens/flex-media/flexery.dart';
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
      // getPages: [
      //   GetPage(name: SplashScreen.id, page: () => const SplashScreen()),
      //   GetPage(name: OnboardingScreen.id, page: () => const OnboardingScreen()),
      //   GetPage(name: Login.id, page: () => const Login()),
      //   GetPage(name: ForgotPassword.id, page: () => const ForgotPassword()),
      //   GetPage(name: ResetPassword.id, page: () => const ResetPassword()),
      //   GetPage(name: SignUp.id, page: () => const SignUp()),
      //   GetPage(name: FindAFlex.id, page: () => const FindAFlex()),
      //   GetPage(name: HostRegistration.id, page: () => const HostRegistration()),
      //   GetPage(name: HostAFlex.id, page: () => const HostAFlex()),
      //   GetPage(name: HostFlexTermsAndConditions.id, page: () => const HostFlexTermsAndConditions()),
      //   GetPage(name: HostFlexSuccess.id, page: () => const HostFlexSuccess()),
      //   GetPage(name: Dashboard.id, page: () => const Dashboard()),
      //   GetPage(name: Flexery.id, page: () => const Flexery()),
      //   GetPage(name: Notifications.id, page: () => const Notifications()),
      //   GetPage(name: Settings.id, page: () => const Settings()),
      //   GetPage(name: About.id, page: () => const About()),
      //   GetPage(name: EditProfileDetail.id, page: () => const EditProfileDetail()),
      //   GetPage(name: TermsAndCondition.id, page: () => const TermsAndCondition()),
      //   GetPage(name: PrivacyPolicy.id, page: () => const PrivacyPolicy()),
      //   GetPage(name: HelpAndSupport.id, page: () => const HelpAndSupport()),
      //   GetPage(name: PendingInvites.id, page: () => const PendingInvites()),
      //   GetPage(name: FlexHistory.id, page: () => const FlexHistory()),
      //   GetPage(name: FlexHistoryDetail.id, page: () => const FlexHistoryDetail()),
      //   GetPage(name: Join.id, page: () => const Join()),
      //   GetPage(name: JoinFlex.id, page: () => const JoinFlex()),
      //   GetPage(name: JoinedFlexDetails.id, page: () => const JoinedFlexDetails()),
      // ],
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        OnboardingScreen.id: (context) => const OnboardingScreen(),
        Login.id: (context) => Login(),
        ForgotPassword.id: (context) => ForgotPassword(),
        ResetPassword.id: (context) =>  ResetPassword(),
        SignUp.id: (context) => SignUp(),
        FindAFlex.id: (context) => const FindAFlex(),
        HostRegistration.id: (context) => HostRegistration(),
        HostAFlex.id: (context) => HostAFlex(),
        HostFlexTermsAndConditions.id: (context) => HostFlexTermsAndConditions(),
        HostFlexSuccess.id: (context) => HostFlexSuccess(),
        BetaSms.id: (context) => BetaSms(),
        Dashboard.id: (context) => Dashboard(),
        Flexery.id: (context) => const Flexery(),
        Notifications.id: (context) => Notifications(),
        Settings.id: (context) => Settings(),
        About.id: (context) => const About(),
        EditProfileDetail.id: (context) => EditProfileDetail(),
        TermsAndCondition.id: (context) => const TermsAndCondition(),
        PrivacyPolicy.id: (context) => const PrivacyPolicy(),
        HelpAndSupport.id: (context) => const HelpAndSupport(),
        PendingInvites.id: (context) => PendingInvites(),
        FlexHistory.id: (context) => const FlexHistory(),
        FlexHistoryDetail.id: (context) => FlexHistoryDetail(),
        Join.id: (context) => const Join(),
        JoinFlex.id: (context) => JoinFlex(),
        JoinedFlexDetails.id: (context) => JoinedFlexDetails(),
        ContactScreen.id: (context) => ContactScreen(),
      },
    );
  }
}
// for a join user
// - settings
// - gallery
// - history
// -