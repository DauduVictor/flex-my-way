import 'package:flex_my_way/src/content/utilities/base_change_notifier.dart';
import 'package:flex_my_way/src/services/navigation_service/i_navigation_services.dart';
import 'package:flex_my_way/src/shared/routing/app_routing.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class HostRegistrationViewModel extends BaseChangeNotifier {
  HostRegistrationViewModel(this._read);
  final Reader _read;

  List<String> genders = ['Male', 'Female'];
  List<String> occupations = ['Architect', 'Lawyer', 'Mobile Developer'];

  bool textObscured = false;

  void changeTextObscured() {
    textObscured = !textObscured;
    setState();
  }

  void navigateToHostAFlex() {
    _read(navigationService).toNamed(Routes.hostAFlex);
  }

  String formatDate(DateTime date) {
    return DateFormat.yMd('en_US').format(date);
  }
}

final hostRegistrationViewModel = ChangeNotifierProvider(
  (ref) => HostRegistrationViewModel(ref.read),
);
