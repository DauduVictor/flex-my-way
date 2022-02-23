import 'package:flex_my_way/src/content/utilities/base_change_notifier.dart';
import 'package:flex_my_way/src/services/navigation_service/i_navigation_services.dart';
import 'package:flex_my_way/src/shared/routing/app_routing.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HostFlexTermsAndConditionViewModel extends BaseChangeNotifier {
  HostFlexTermsAndConditionViewModel(this._read);
  final Reader _read;

  Future<Object?>? navigateToHostFlexSuccess() {
    _read(navigationService).toNamed(Routes.hostFlexSuccess);
  }
}

final hostFlexTermsAndConditionViewModel =
    Provider((ref) => HostFlexTermsAndConditionViewModel(ref.read));
