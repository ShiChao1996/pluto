import 'package:flutter/material.dart';

void goPage(BuildContext context, String route, Widget comp){
  Navigator.push(context, new MaterialPageRoute<Null>(
    settings: new RouteSettings(name: route),
    builder: (BuildContext context) {
      return comp;
    },
  ));
}