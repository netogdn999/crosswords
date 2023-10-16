import 'package:flutter/material.dart';

class SlideTransationBuilder extends PageTransitionsBuilder {

  const SlideTransationBuilder();
  
  @override
  Widget buildTransitions<T>(PageRoute<T> route, BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    final tween = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero);
    return SlideTransition(position: tween.animate(animation), child: child);
  }
}