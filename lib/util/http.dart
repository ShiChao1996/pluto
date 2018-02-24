

String myUrl(String path) {
  return "http://api.littlechao.top/" + path;
}

String myPicUrl(String path) {
  if(path == null){
    return "http://avatar.csdn.net/6/F/2/2_hekaiyou.jpg";
  }

  return "http://image.littlechao.top/" + path.substring(15);
}