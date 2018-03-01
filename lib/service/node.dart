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


import 'package:http/http.dart' as Http;
import 'dart:convert';
import 'dart:async';

import '../model/node.dart';
import '../util/http.dart';

const String status = "success";
const String resp = "data";
const int numPerRequest = 10;

Future<List<NodeArticle>> getListByTab(String tab, int limit, int page) async {
  if(limit == null){
    limit = numPerRequest;
  }
  if(page == null){
    page = 1;
  }
  print(page);
  String url = nodeApiUrl("topics?limit=${limit}&tab=${tab}&page=${page}");
  Http.Response res = await Http.get(url);
  var data = JSON.decode(res.body);
  print("status: ${data[status]}");

  if (data[status] != true) {
    return [];
  }

  var list = data[resp];
  return formatList(list);
}

List<NodeArticle> formatList(list) {
  int len = list.length;
  List<NodeArticle> ret = [];
  for (int i = 0; i < len; i++) {
    var cur = list[i];
    NodeArticle info = new NodeArticle(
      id: cur["id"],
      title: cur["title"],
      tab: cur["tab"],
      reply: cur["reply_count"],
      createAt: cur["create_at"],
      visit: cur["visit_count"],
      authorvatar: cur["author"]["avatar_url"]
    );
    ret.add(info);
  }

  print("get node data");
  return ret;
}
