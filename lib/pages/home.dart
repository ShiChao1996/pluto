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
 *     Initial: 2018/02/22        ShiChao
 */

import 'package:flutter/material.dart';
import 'package:flutter_web_view/flutter_web_view.dart';

import '../component/nodeArticleItem.dart';
import '../service/node.dart';
import '../model/node.dart';
import '../util/util.dart';
import '../util/http.dart';
import './webview.dart';

const double _kAppBarHeight = 200.0;
Map articleCache = {};

class Home extends StatefulWidget {
  final List<NodeArticle> list;
  final setList;
  final addList;

  const Home(this.list, this.setList, this.addList);

  @override
  HomeState createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  List<NodeArticle> artiList = [];
  String _redirectedToUrl;
  FlutterWebView flutterWebView = new FlutterWebView();
  bool _isLoading = false;

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  initState() {
    super.initState();
    this.setState(() {
      artiList = widget.list;
    });
    print("home initState, list length: ${artiList.length}");

    if (artiList.length == 0) {
      getListByTab("share").then((res) {
        widget.setList(res);
        this.setState(() {
          artiList = res;
        });
      });
    }
  }

  Widget _buildAppBar(BuildContext context, double statusBarHeight) {
    return new SliverAppBar(
      pinned: true,
      expandedHeight: _kAppBarHeight,
      /*actions: <Widget>[
        new IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'Search',
          onPressed: () {
            scaffoldKey.currentState.showSnackBar(const SnackBar(
              content: const Text('Not supported.'),
            ));
          },
        ),
      ],*/
      flexibleSpace: new FlexibleSpaceBar(
        title: const Text(
          'Node Community',
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
        background: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Image.asset(
              'images/node_dark.jpg',
              fit: BoxFit.fill,
              height: _kAppBarHeight,
            ),
            // This gradient ensures that the toolbar icons are distinct
            // against the background image.
            const DecoratedBox(
              decoration: const BoxDecoration(
                gradient: const LinearGradient(
                  begin: const FractionalOffset(0.5, 0.0),
                  end: const FractionalOffset(0.5, 0.30),
                  colors: const <Color>[
                    const Color(0x60000000), const Color(0x00000000)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void goDetail(String id) {
    String url = nodeUrl("topic/${id}");
    launchWebViewExample(url);
  }

  void launchWebViewExample(String url) {
    if (flutterWebView.isLaunched) {
      return;
    }

    flutterWebView.launch(url,
        headers: {
          "X-SOME-HEADER": "MyCustomHeader",
        },
        javaScriptEnabled: false,
        inlineMediaEnabled: true,
        toolbarActions: [
          new ToolbarAction("Close", 1),
          new ToolbarAction("Reload", 2)
        ],
        barColor: Colors.blue,
        tintColor: Colors.white
    );
    flutterWebView.onToolbarAction.listen((identifier) {
      switch (identifier) {
        case 1:
          flutterWebView.dismiss();
          break;
        case 2:
          reload(url);
          break;
      }
    });
    flutterWebView.listenForRedirect("mobile://test.com", true);

    flutterWebView.onWebViewDidStartLoading.listen((url) {
      setState(() => _isLoading = true);
    });
    flutterWebView.onWebViewDidLoad.listen((url) {
      setState(() => _isLoading = false);
    });
    flutterWebView.onRedirect.listen((url) {
      flutterWebView.dismiss();
      setState(() => _redirectedToUrl = url);
    });
  }

  void reload(String url) {
    flutterWebView.load(
      url,
      headers: {
        "X-SOME-HEADER": "MyCustomHeader",
      },
    );
  }

  refresh() async {
    getListByTab("share").then((res){
      this.setState((){
        artiList = res;
      });
      widget.setList(res);
    });

    return true;
  }

  Widget _buildBody(BuildContext context, double statusBarHeight) {
    final EdgeInsets padding = const EdgeInsets.all(8.0);
    return new SliverPadding(
      padding: padding,
      sliver: new SliverList(
        delegate: new SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            return new Column(
              children: artiList.map((NodeArticle article) {
                return new GestureDetector(
                  onTap: () {
                    goDetail(article.id);
                  },
                  child: new Container(
                      width: 500.0, //todo
                      child: new NodeArticleItem(article: article,)
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
      child: new RefreshIndicator(
        onRefresh: refresh,
        child: new CustomScrollView(
          slivers: <Widget>[
            _buildAppBar(context, statusBarHeight),
            _buildBody(context, statusBarHeight),
          ],
        ),
      ),
    );
  }
}