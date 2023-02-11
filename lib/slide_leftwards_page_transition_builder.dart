import 'package:flutter/material.dart';

class SlideLeftwardsPageTransitionBuilder extends PageTransitionsBuilder {
  const SlideLeftwardsPageTransitionBuilder();

  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return SlideTransition(
      position: animation.drive(Tween(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).chain(CurveTween(
        curve: Curves.fastOutSlowIn,
      ))),
      child: child,
    );
  }
}
