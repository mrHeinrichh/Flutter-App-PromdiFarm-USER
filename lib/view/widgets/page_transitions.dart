import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SlideLeftExitRight extends CustomTransitionPage {
  SlideLeftExitRight({
    required Widget child,
    Duration transitionDuration = const Duration(milliseconds: 500),
  }) : super(
          child: child,
          transitionDuration: transitionDuration,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.ease,
                ),
              ),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(1.0, 0.0),
                ).animate(
                  CurvedAnimation(
                    parent: secondaryAnimation,
                    curve: Curves.ease,
                  ),
                ),
                child: child,
              ),
            );
          },
        );
}

class SlideLeftExitLeft extends CustomTransitionPage {
  SlideLeftExitLeft({
    required Widget child,
    Duration transitionDuration = const Duration(milliseconds: 500),
  }) : super(
          child: child,
          transitionDuration: transitionDuration,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.ease,
                ),
              ),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(-1.0, 0.0),
                ).animate(
                  CurvedAnimation(
                    parent: secondaryAnimation,
                    curve: Curves.ease,
                  ),
                ),
                child: child,
              ),
            );
          },
        );
}

class SlideRightExitLeft extends CustomTransitionPage {
  SlideRightExitLeft({
    required Widget child,
    Duration transitionDuration = const Duration(milliseconds: 500),
  }) : super(
          child: child,
          transitionDuration: transitionDuration,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.ease,
                ),
              ),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(-1.0, 0.0),
                ).animate(
                  CurvedAnimation(
                    parent: secondaryAnimation,
                    curve: Curves.ease,
                  ),
                ),
                child: child,
              ),
            );
          },
        );
}

class SlideRightExitRight extends CustomTransitionPage {
  SlideRightExitRight({
    required Widget child,
    Duration transitionDuration = const Duration(milliseconds: 500),
  }) : super(
          child: child,
          transitionDuration: transitionDuration,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.ease,
                ),
              ),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(1.0, 0.0),
                ).animate(
                  CurvedAnimation(
                    parent: secondaryAnimation,
                    curve: Curves.ease,
                  ),
                ),
                child: child,
              ),
            );
          },
        );
}

class SlideTopRoute extends CustomTransitionPage {
  SlideTopRoute({
    required Widget child,
    Duration transitionDuration = const Duration(milliseconds: 500),
  }) : super(
          child: child,
          transitionDuration: transitionDuration,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1).animate(animation),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, -1.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.ease,
                  ),
                ),
                child: child,
              ),
            );
          },
        );
}

class SlideBottomRoute extends CustomTransitionPage {
  SlideBottomRoute({
    required Widget child,
    Duration transitionDuration = const Duration(milliseconds: 500),
  }) : super(
          child: child,
          transitionDuration: transitionDuration,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1).animate(animation),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0.0, 1.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.ease,
                  ),
                ),
                child: child,
              ),
            );
          },
        );
}

class PushToLeft extends CustomTransitionPage {
  PushToLeft({
    required Widget child,
    Duration transitionDuration = const Duration(milliseconds: 500),
  }) : super(
          child: child,
          transitionDuration: transitionDuration,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.ease,
                ),
              ),
              child: child,
            );
          },
        );
}

class PushToRight extends CustomTransitionPage {
  PushToRight({
    required Widget child,
    Duration transitionDuration = const Duration(milliseconds: 500),
  }) : super(
          child: child,
          transitionDuration: transitionDuration,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.ease,
                ),
              ),
              child: child,
            );
          },
        );
}
