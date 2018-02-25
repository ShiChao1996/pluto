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
 *     Initial: 2018/02/23        ShiChao
 */

import 'package:http/http.dart' as Http;
import 'dart:convert';
import 'dart:async';

import '../model/myArticle.dart';
import '../util/http.dart';

const String status = "status";
const String resp = "resp";

Future<List<MyListInfo>> getMyList() async {
  String url = myUrl("article/getall");
  Http.Response res = await Http.get(url);
  var data = JSON.decode(res.body);

  if (data[status] != 0) {
    return [];
  }

  var list = data[resp];
  return formatList(list);
}

List<MyListInfo> formatList(list) {
  int len = list.length;
  List<MyListInfo> ret = [];
  for (int i = 0; i < len; i++) {
    var cur = list[i];
    MyListInfo info = new MyListInfo(
        id: cur["_id"],
        title: cur["title"],
        tags: cur["tags"],
        imageUrl: myPicUrl(cur["image"]),
        date: cur["date"],
        contentId: cur["contentId"]
    );
    ret.add(info);
  }

  print("getdata");
  return ret;
}

Future<MyArtDetail> getDetail(String id) async {
  String url = myUrl("article/getdetail");
  String data = JSON.encode({
    "_id": id
  });

  Http.Response res = await Http.post(
    url,
    body: data,
    headers: {
      "Content-Type": "application/json"
    },
  );

  Map resp = JSON.decode(res.body);
  if (resp[status] != 0) {
    return null;
  }

  return formatDetail(resp["resp"]);
}

MyArtDetail formatDetail(Map cur) {
  MyArtDetail article = new MyArtDetail(
      id: cur["_id"],
      title: cur["title"],
      tags: cur["tags"],
      date: cur["date"],
      content: cur["content"],
      imageUrl: cur["image"]
  );

  return article;
}