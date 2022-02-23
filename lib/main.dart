import 'package:flex_my_way/src/features/views/splash_screen.dart';
import 'package:flex_my_way/src/services/navigation_service/i_navigation_services.dart';
import 'package:flex_my_way/src/services/snackbar_service/snackbar_service.dart';
import 'package:flex_my_way/src/shared/routing/app_routing.dart';
import 'package:flex_my_way/src/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flex My Way',
      theme: AppTheme.themeData,
      navigatorKey: ref.watch(navigationService).navigatorKey,
      scaffoldMessengerKey: ref.watch(snackbarService).scaffoldMessengerKey,
      onGenerateRoute: Routes.generateRoute,
      home: const SplashScreenView(),
    );
  }
}
