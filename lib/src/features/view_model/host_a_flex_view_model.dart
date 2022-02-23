import 'package:flex_my_way/src/content/utilities/base_change_notifier.dart';
import 'package:flex_my_way/src/services/navigation_service/i_navigation_services.dart';
import 'package:flex_my_way/src/shared/routing/app_routing.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class HostAFlexViewModel extends BaseChangeNotifier {
  HostAFlexViewModel(this._read);
  final Reader _read;

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

  void navigateToHostAFlex() {
    _read(navigationService).toNamed(Routes.hostFlexTermsAndConditions);
  }

  String formatDate(DateTime date) {
    return DateFormat.yMd('en_US').format(date);
  }
}

final hostAFlexViewModel = ChangeNotifierProvider(
  (ref) => HostAFlexViewModel(ref.read),
);
