import 'package:flutter/material.dart';
import '../model/myArticle.dart';
import '../service/myArticles.dart';

class StatelessListItem extends StatelessWidget {
  StatelessListItem({
    MyListInfo info
  })
      : _info = info,
        key = new Key(info.title),
        showTitle = info.title.length > 20
            ? info.title.substring(0, 20) + "..."
            : info.title;

  final Key key;
  final MyListInfo _info;
  final String showTitle;

  //final String date;


  Size getSize(context) {
    return MediaQuery
        .of(context)
        .size;
  }

  void goDetail() {
    getDetail(_info.id).then((article){
      print(article.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final picWidth = 100.0;
    return new GestureDetector(
      onTap: () {
        goDetail();
      },
      child: new Container( //todo: change to card
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: new Container(
          height: 80.0,
          color: Colors.white,
          padding: new EdgeInsets.all(8.0),
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Container(
                child: new Image.network(
                  _info.imageUrl,
                  fit: BoxFit.fitWidth,
                  scale: 1.0,
                  repeat: ImageRepeat.noRepeat,
                ),
                width: picWidth,
              ),

              new Container(
                width: getSize(context).width - picWidth - 50.0,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      //width: getSize(context).width,
                      child: new Text(
                        showTitle,
                        style: new TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),

                    new Container(
                      //width: 500.0,
                      child: new Row(
                        children: _info.tags.map((String tag) {
                          return new GestureDetector(
                            onTap: () {
                              print(tag);
                            },
                            child: new Text(
                              '#' + tag + " ",
                              style: new TextStyle(
                                fontSize: 12.0,
                                color: Colors.black54,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 1.0),
                    ),

                    new Container(
                      child: _info.date == null ? null : new Text(
                        _info.date.substring(0, 10),
                        style: new TextStyle(
                          fontSize: 12.0,
                          color: Colors.black54,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}