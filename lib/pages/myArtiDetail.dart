import 'package:flutter/material.dart';
import '../flutter_markdown/lib/flutter_markdown.dart';

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

import '../model/myArticle.dart';
import '../util/http.dart';

class ArticleDetailPage extends StatefulWidget {
  const ArticleDetailPage({ Key key, this.article }) : super(key: key);

  final MyArtDetail article;

  @override
  _ArticleDetailPageState createState() => new _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  final _kFabHalfSize = 28.0;
  var isFavorite = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  double _getAppBarHeight(BuildContext context) =>
      MediaQuery
          .of(context)
          .size
          .height * 0.3;

  void changeFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    //add to person collections
    //person.collections.add(widget.article);

    //snackbar
    String text = isFavorite ? '已收藏~' : '已移除收藏';
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
      backgroundColor: isFavorite ? Colors.pinkAccent : Colors.blueAccent[100],
    ));
  }

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = _getAppBarHeight(context);
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    final bool fullWidth = true;
    return new Scaffold(
      key: _scaffoldKey,
      body: new Stack(

        children: <Widget>[
          new Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            height: appBarHeight + _kFabHalfSize + 5.0,
            child: new Hero(
              tag: widget.article.title,
              child: new Image.network(
                myPicUrl(widget.article.imageUrl),
                fit: fullWidth ? BoxFit.fitHeight : BoxFit.cover,
              ),
            ),
          ),
          new CustomScrollView(
            slivers: <Widget>[
              new SliverAppBar(
                expandedHeight: appBarHeight - _kFabHalfSize,
                backgroundColor: Colors.transparent,
                flexibleSpace: new FlexibleSpaceBar(
                  background: new DecoratedBox(
                    decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                        begin: const FractionalOffset(0.5, 0.0),
                        end: const FractionalOffset(0.5, 0.40),
                        colors: <Color>[
                          const Color(0x60000000), const Color(0x00000000)],
                      ),
                    ),
                  ),
                ),
              ),

              new SliverToBoxAdapter(
                child: new Stack(
                  children: <Widget>[
                    new Container(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: new Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 40.0),
                        child: new MarkdownBody(data: widget.article.content,),
                      ),
                    ),
                    new Positioned(
                      top: 0.0,
                      right: 16.0,
                      child: new FloatingActionButton(
                        child: new Icon(isFavorite ? Icons.favorite : Icons
                            .favorite_border),
                        onPressed: changeFavorite,
                        backgroundColor: isFavorite ? Colors.pinkAccent : Colors
                            .blueAccent[100],
                        tooltip: 'lovae',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/*
class ArticleSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: new Markdown(data: _kMarkdownData),
      ),
    );
  }
}*/
