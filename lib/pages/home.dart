import 'package:flutter/material.dart';
import '../model/myArticle.dart';
import '../component/aticleListItem.dart';
import '../service/myArticles.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  List<MyListInfo> infos = [];

  @override
  initState() {
    super.initState();
    if(infos.length == 0){
      getMyList().then((List<MyListInfo> l) {
        this.setState(() {
          infos = l;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          new SliverList(
            delegate: new SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return new Column(
                  children: infos.map((MyListInfo info) {
                    return new GestureDetector(
                      onTap: () {
                        //gotoPage(info);
                      },
                      child: new Container(
                        width: 500.0, //todo
                        child: new StatelessListItem(
                            info: info
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}