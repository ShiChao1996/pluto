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
 *     Initial: 2018/02/25        ShiChao
 */

import 'package:flutter/material.dart';
import '../model/myArticle.dart';
import '../component/aticleListItem.dart';
import '../service/myArticles.dart';
import '../pages/myArtiDetail.dart';
import '../util/util.dart';

const double _kAppBarHeight = 128.0;
Map articleCache = {};

class MyBlogPage extends StatefulWidget {
  final List<MyListInfo> list;
  final setList;
  final addList;

  const MyBlogPage(this.list,this.setList,this.addList);

  @override
  MyBlogPageState createState() => new MyBlogPageState();
}

class MyBlogPageState extends State<MyBlogPage> {
  List<MyListInfo> articleList = [];
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  initState() {
    super.initState();
    this.setState((){
      articleList = widget.list;
    });
    if (articleList.length == 0) {
      getMyList().then((List<MyListInfo> l) {
        widget.setList(l);
        this.setState(() {
          articleList = l;
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
              children: articleList.map((MyListInfo info) {
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
                      child: new myArticleItem(
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
      child: new CustomScrollView(
        slivers: <Widget>[
          _buildAppBar(context, statusBarHeight),
          _buildBody(context, statusBarHeight),
        ],
      ),
    );
  }
}