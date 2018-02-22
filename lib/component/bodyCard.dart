import 'package:flutter/material.dart';


class BodyCard {
  BodyCard({
    Widget child,
    TickerProvider vsync
  })
      : _child = child,
        controller = new AnimationController(
            vsync: vsync, duration: kThemeAnimationDuration) {
    animation = new CurvedAnimation(
      parent: controller,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
  }

  final AnimationController controller;
  CurvedAnimation animation;
  final Widget _child;

  FadeTransition transition(BuildContext context) {
    Color iconColor;
    iconColor = Colors.blueGrey;

    return new FadeTransition(
      opacity: animation,
      child: new SlideTransition(
        position: new FractionalOffsetTween(
          begin: const FractionalOffset(0.0, 0.02),
          // Small offset from the top.
          end: FractionalOffset.topLeft,
        ).animate(animation),
        child: new IconTheme(
          data: new IconThemeData(
            color: iconColor,
            size: 120.0,
          ),
          child: _child,
        ),
      ),
    );
  }
}

