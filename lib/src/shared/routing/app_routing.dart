import 'package:flex_my_way/src/features/views/find_a_flex.dart';
import 'package:flex_my_way/src/features/views/host_a_flex.dart';
import 'package:flex_my_way/src/features/views/host_flex_success.dart';
import 'package:flex_my_way/src/features/views/host_flex_terms_and_conditions.dart';
import 'package:flex_my_way/src/features/views/host_registration.dart';
import 'package:flex_my_way/src/features/views/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const splashScreen = '/splashScreen';
  static const findAFlex = '/findAFlex';
  static const hostRegistration = '/hostRegistration';
  static const hostAFlex = '/hostAFlex';
  static const hostFlexTermsAndConditions = '/hostFlexTermsAndConditions';
  static const hostFlexSuccess = '/hostFlexSuccess';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreenView(),
        );
      case findAFlex:
        return MaterialPageRoute(
          builder: (_) => const FindAFlex(),
        );
      case hostRegistration:
        return MaterialPageRoute(
          builder: (_) => const HostRegistration(),
        );
      case hostAFlex:
        return MaterialPageRoute(
          builder: (_) => const HostAFlex(),
        );
      case hostFlexTermsAndConditions:
        return MaterialPageRoute(
          builder: (_) => const HostFlexTermsAndConditions(),
        );
      case hostFlexSuccess:
        return MaterialPageRoute(
          builder: (_) => const HostFlexSuccess(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
