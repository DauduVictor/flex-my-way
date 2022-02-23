import 'package:flex_my_way/src/content/utilities/base_change_notifier.dart';
import 'package:flex_my_way/src/services/navigation_service/i_navigation_services.dart';
import 'package:flex_my_way/src/shared/routing/app_routing.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FindAFlexViewModel extends BaseChangeNotifier {
  FindAFlexViewModel(this._read);
  final Reader _read;

  Future<Object?>? navigateToHostRegistration() {
    _read(navigationService).toNamed(Routes.hostRegistration);
  }
}

final findAFlexViewModel = Provider((ref) => FindAFlexViewModel(ref.read));
