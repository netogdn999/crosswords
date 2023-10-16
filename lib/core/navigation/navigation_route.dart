import 'package:flutter/material.dart';

abstract class NavigationRoute<D> {
  List<Page> routes({required D route, dynamic params});
}
