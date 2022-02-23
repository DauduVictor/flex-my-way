import 'package:flex_my_way/src/content/utilities/base_change_notifier.dart';
import 'package:flex_my_way/src/content/utilities/screen_utility.dart';
import 'package:flex_my_way/src/services/navigation_service/i_navigation_services.dart';
import 'package:flex_my_way/src/shared/routing/app_routing.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashScreenViewModel extends BaseChangeNotifier {
  SplashScreenViewModel(this._read) {
    Future.delayed(const Duration(seconds: 5), () => animateWidth());
    navigateToFindAFlex();
  }

  final Reader _read;

  double width = 0;

  void animateWidth() {
    width = 1000;
  }

  void navigateToFindAFlex() async {
    await Future.delayed(const Duration(seconds: 5), () => animateWidth());
    _read(navigationService).offNamed(Routes.findAFlex);
  }

  void onEnd(BuildContext context) {
    width = ScreenUtil.screenWidth(context);
    animateWidth();
  }
}

final splashScreenViewModel =
    Provider((ref) => SplashScreenViewModel(ref.read));
