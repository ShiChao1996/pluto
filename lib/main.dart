import 'package:flutter/material.dart';
import './component/container.dart';
import './pages/myArtiDetail.dart';

void main() {
  runApp(
    new MaterialApp(
      home: new MyContainer(),
      routes: <String, WidgetBuilder>{
        '/mydetail': (BuildContext context) => new ArticleDetailPage(),
        // '/favorite': (BuildContext context) => new Favorite(person: person),
        //'/cache': (BuildContext context) => new ReadAndWriteDemo(),
      },
    ),
  );
}