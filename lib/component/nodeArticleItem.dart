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

import '../model/node.dart';

class NodeArticleItem extends StatelessWidget {
  NodeArticleItem({
    NodeArticle article
  })
      : article = article,
        key = new Key(article.title),
        showTitle = article.title.length > 25
            ? article.title.substring(0, 25) + "..."
            : article.title;

  final Key key;
  final NodeArticle article;
  final String showTitle;

  //final String date;


  Size getSize(context) {
    return MediaQuery
        .of(context)
        .size;
  }

  @override
  Widget build(BuildContext context) {
    final picWidth = 60.0;
    return new Container( //todo: change to card
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: new Container(
        height: 90.0,
        color: Colors.white,
        padding: new EdgeInsets.all(8.0),
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Center(
              child: new CircleAvatar(
                backgroundImage: new NetworkImage(
                  article.authorvatar,
                  scale: 1.0
                ),
                radius: picWidth/2,
                backgroundColor: Colors.lightBlue,
              ),
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
                    padding: const EdgeInsets.symmetric(vertical: 1.0),
                  ),

                  new Container(
                    //width: 500.0,
                    child: new Text(
                      "阅读量：${article.visit}  回复：${article.reply}",
                      style: new TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                      ),
                    ),
                  ),

                  new Container(
                    child: article.createAt == null ? null : new Text(
                      article.createAt.substring(0, 10),
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
    );
  }
}