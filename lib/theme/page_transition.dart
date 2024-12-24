import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage emptyTransaction(Widget child) {
  return CustomTransitionPage(
    child: child,
    transitionDuration: Duration.zero,
    reverseTransitionDuration: Duration.zero,
    transitionsBuilder: (
      context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      child,
    ) {
      return child;
    },
  );
}

CustomTransitionPage pageTransaction(Widget child) {
  return CustomTransitionPage(
    child: child,
    transitionsBuilder: (
      context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      child,
    ) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
        ),
        child: child,
      );
    },
  );
}
