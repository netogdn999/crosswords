import 'package:flutter/material.dart';

import 'base_routes.dart';

abstract interface class NavigationAction<T> {
  void Function(T route, {dynamic params}) get navigate;
  void Function(T baseRoute, {T route, dynamic params}) get replace;
  void Function([dynamic params]) get pop;
  void Function(RouteAware routeAware, ModalRoute route) get subscribe;
  
  static NavigationAction<T> of<T extends RoutePath>(BuildContext context) => context.dependOnInheritedWidgetOfExactType<NavigationActionImpl<T>>()!;
}

class NavigationActionImpl<T> extends InheritedWidget implements NavigationAction<T> {
  final void Function(T route, {dynamic params}) _navigate;
  @override
  void Function(T route, {dynamic params}) get navigate =>_navigate;

  final void Function([dynamic params]) _pop;
  @override
  void Function([dynamic params]) get pop => _pop;

  final void Function(T baseRoute, {T route, dynamic params}) _replace;
  @override
  void Function(T baseRoute, {T route, dynamic params}) get replace => _replace;

  final void Function(RouteAware routeAware, ModalRoute route) _subscribe;
  @override
  void Function(RouteAware routeAware, ModalRoute route) get subscribe => _subscribe;

  const NavigationActionImpl({
    super.key, 
    required void Function(T route, {dynamic params}) navigate,
    required void Function([dynamic params]) pop, 
    required void Function(T baseRoute, {T route, dynamic params}) replace,
    required void Function(RouteAware routeAware, ModalRoute route) subscribe,
    required super.child,
  }) : _navigate = navigate,
      _pop = pop,
      _replace = replace,
      _subscribe = subscribe;
      
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

}