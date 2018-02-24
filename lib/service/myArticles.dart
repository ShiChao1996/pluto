import 'package:http/http.dart' as Http;
import 'dart:convert';
import 'dart:async';

import '../model/myArticle.dart';
import '../util/http.dart';

const String status = "status";
const String resp = "resp";

Future<List<MyListInfo>> getMyList()async{

  Http.Response res = await Http.get("http://api.littlechao.top/article/getall");
  var data = JSON.decode(res.body);
  print(data);

  if (data[status] != 0){
    return [];
  }

  var list  = data[resp];
  return formatList(list);
 }

 List<MyListInfo> formatList(list){
   int len = list.length;
   List<MyListInfo> ret = [];
   for (int i = 0;i<len;i++){
     var cur = list[i];
     MyListInfo info = new MyListInfo(
       id: cur["_id"],
       title: cur["title"],
       tags: cur["tags"],
       imageUrl: myPicUrl(cur["image"])
     );
     ret.add(info);
   }

   print("getdata");
   return ret;
 }