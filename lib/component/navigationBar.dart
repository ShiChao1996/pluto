import 'package:flutter/material.dart';


class NavigationIconView {
  NavigationIconView({
    Widget icon,
    Widget title,
    Color color,
    TickerProvider vsync
  })
      : _icon = icon,
        _color = color,
        item = new BottomNavigationBarItem(
          icon: icon, title: title, backgroundColor: color,
        ),
        controller = new AnimationController(
            vsync: vsync, duration: kThemeAnimationDuration) {
    animation = new CurvedAnimation(
      parent: controller,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
  }

  final Widget _icon;
  final BottomNavigationBarItem item;
  final Color _color;
  final AnimationController controller;
  CurvedAnimation animation;

  FadeTransition transition(BuildContext context) {
    Color iconColor;
    /* final ThemeData themeData = Theme.of(context);
    iconColor = themeData.brightness == Brightness.light
        ? themeData.primaryColor
        : themeData.accentColor;*/
    iconColor = _color;

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
          child: _icon,
        ),
      ),
    );
  }
}

