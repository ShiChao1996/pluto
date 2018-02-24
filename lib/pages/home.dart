import 'package:flutter/material.dart';
import '../model/myArticle.dart';
import '../component/aticleListItem.dart';
import '../service/myArticles.dart';
import '../pages/myArtiDetail.dart';
import '../util/util.dart';

const double _kAppBarHeight = 128.0;
Map articleCache = {};

class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  List<MyListInfo> infos = [];
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  initState() {
    super.initState();
    if (infos.length == 0) {
      getMyList().then((List<MyListInfo> l) {
        this.setState(() {
          infos = l;
        });
      });
    }
  }

  Widget _buildAppBar(BuildContext context, double statusBarHeight) {
    return new SliverAppBar(
      pinned: true,
      expandedHeight: _kAppBarHeight,
      actions: <Widget>[
        new IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'Search',
          onPressed: () {
            scaffoldKey.currentState.showSnackBar(const SnackBar(
              content: const Text('Not supported.'),
            ));
          },
        ),
      ],
      flexibleSpace: new LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final Size size = constraints.biggest;
          final double appBarHeight = size.height - statusBarHeight;
          final double t = (appBarHeight - kToolbarHeight) /
              (_kAppBarHeight - kToolbarHeight);
          final double extraPadding = new Tween<double>(begin: 10.0, end: 24.0)
              .lerp(t) - 5;
          final double logoHeight = appBarHeight - 1.5 * extraPadding;
          return new Padding(
            padding: new EdgeInsets.only(
              top: statusBarHeight + 0.5 * extraPadding,
              bottom: extraPadding,
            ),
            child: new Center(
              child: new CircleAvatar(
                backgroundImage: new AssetImage(
                  "images/avatar.png",
                ),
                radius: logoHeight / 2,
                backgroundColor: Colors.lightBlue,
              ),
            ),
          );
        },
      ),
    );
  }

  void goDetail(String id) {
    MyArtDetail article;
    if (articleCache[id] != null) {
      article = articleCache[id];
      goPage(context, "/mydetail", new ArticleDetailPage(article: article));
      return;
    }
    getDetail(id).then((article) {
      articleCache[id] = article;
      goPage(context, "/mydetail", new ArticleDetailPage(article: article));
    });
  }

  Widget _buildBody(BuildContext context, double statusBarHeight) {
    final EdgeInsets padding = const EdgeInsets.all(8.0);
    return new SliverPadding(
      padding: padding,
      sliver: new SliverList(
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
                    child: new GestureDetector(
                      onTap: () {
                        goDetail(info.id);
                      },
                      child: new StatelessListItem(
                          info: info
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
          childCount: 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return new Container(
      /*child: new CustomScrollView(
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
      ),*/

      child: new CustomScrollView(
        slivers: <Widget>[
          _buildAppBar(context, statusBarHeight),
          _buildBody(context, statusBarHeight),
        ],
      ),
    );
  }
}