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