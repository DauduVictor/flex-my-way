import 'package:flutter/material.dart' as m;

import 'i_navigation_services.dart';

class NavigationService implements INavigationService {
  @override
  final navigatorKey = m.GlobalKey<m.NavigatorState>();

  @override
  Future<T?>? toNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState?.pushNamed(routeName);
  }

  @override
  Future<T?>? to<T extends Object?>(
    m.Route<T> route, {
    Object? arguments,
  }) {
    return navigatorKey.currentState?.push(route);
  }

  @override
  Future<T?>? offNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return navigatorKey.currentState?.pushReplacementNamed(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  @override
  void back<T extends Object?>([T? result]) {
    return navigatorKey.currentState?.pop(result);
  }

  @override
  Future<T?> showDialog<T>({
    required m.Widget builderWidget,
  }) {
    final context = navigatorKey.currentContext!;
    return m.showDialog(
      context: context,
      builder: (context) => builderWidget,
    );
  }

  @override
  Future<dynamic> showBottomSheet<T>({
    required m.Widget builderWidget,
    m.Color? backgroundColor,
    bool? isScrolledControlled,
    m.ShapeBorder? shape,
  }) {
    final context = navigatorKey.currentContext!;
    return m.showModalBottomSheet(
      backgroundColor: backgroundColor,
      isScrollControlled: true,
      shape: shape,
      context: context,
      builder: (context) => builderWidget,
    );
  }
}
