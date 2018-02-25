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
import '../model/myArticle.dart';

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

  @override
  Widget build(BuildContext context) {
    final picWidth = 100.0;
    return new Container( //todo: change to card
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
              child: new Hero(
                tag: _info.title,
                child: new Image.network(
                  _info.imageUrl,
                  fit: BoxFit.fitWidth,
                  scale: 1.0,
                  repeat: ImageRepeat.noRepeat,
                ),
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
    );
  }
}