import 'package:flutter/material.dart';

import 'base_routes.dart';
import 'exception.dart';
import 'navigation_route.dart';

abstract class NavigationState with ChangeNotifier {
  List<Page<dynamic>> get stack;
  void addRoute(RoutePath route, {dynamic params});
  void setRoute(RoutePath baseRoute, {RoutePath? subRoute, dynamic params});
  bool removeRoute([dynamic params]);
}

class NavigationStateImpl extends NavigationState {
  late final Map<BaseRoutes, NavigationRoute> _pages;
  late List<Page<dynamic>> _stack;
  @override
  List<Page<dynamic>> get stack => _stack;

  late NavigationRoute _selectedPage;

  NavigationStateImpl({Map<BaseRoutes, NavigationRoute> Function() builderPages = defaultBuilderPages}) {
    const initialPage = BaseRoutes.home;
    _pages = builderPages();
    _selectedPage = _pages[initialPage]!;
    _stack = _selectedPage.routes(route: initialPage);
  }

  void _selectPage(RoutePath route) {
    final isChangingPage = route is BaseRoutes;
    if (!isChangingPage) {
      return;
    }

    if (!_pages.containsKey(route)) {
      throw const RouteNotFoundException('Route not found');
    }

    _selectedPage = _pages[route]!;
  }

  List<Page> _findRoutes(RoutePath route, {dynamic params}) {
    final List<Page> result = _selectedPage.routes(route: route, params: params);
    if (result.isNotEmpty) {
      return result;
    }
    throw const RouteNotFoundException('Route not found');
  }

  /// Can thrown a [RouteNotFoundException]
  @override
  void addRoute(RoutePath route, {dynamic params}) {
    _selectPage(route);
    _stack.addAll(_findRoutes(route, params: params));
    notifyListeners();
  }

  /// Can thrown a [RouteNotFoundException]
  @override
  void setRoute(RoutePath route, {RoutePath? subRoute, dynamic params}) {
    _selectPage(route);
    _stack = _findRoutes(subRoute ?? route, params: params);
    notifyListeners();
  }

  @override
  bool removeRoute([dynamic params]) {
    if(_stack.length > 1) {
      _stack.removeLast();
      return true;
    }
    return false;
  }
}