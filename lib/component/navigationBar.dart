/*
 * MIT License
 *
 * Copyright (c)  ShiChao
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

/*
 * Revision History:
 *     Initial: 2018/02/21        ShiChao
 */

import 'package:flutter/material.dart';

class NavigationIconView {
  NavigationIconView({
    Widget icon,
    Widget title,
    Color color,
    TickerProvider vsync
  })
      : icon = icon,
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

  final Widget icon;
  final BottomNavigationBarItem item;
  final Color _color;
  final AnimationController controller;
  CurvedAnimation animation;

  FadeTransition transition(BuildContext context) {
    Color iconColor;
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
          child: icon,
        ),
      ),
    );
  }
}

