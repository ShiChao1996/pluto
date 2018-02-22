import 'package:flutter/material.dart';
import './component/container.dart';

void main() {
  runApp(
    new MaterialApp(
      home: new MyContainer(),
      /*routes: <String, WidgetBuilder>{
        '/my': (BuildContext context) => new Personal(person: person),
        '/favorite': (BuildContext context) => new Favorite(person: person),
        '/cache': (BuildContext context) => new ReadAndWriteDemo(),
      },*/
    ),
  );
}