class MyListInfo {
  final String id;
  final String title;
  String imageUrl;
  final List<String> tags;
  final String date;
  final String contentId;

  MyListInfo(
      {this.id, this.title, this.imageUrl, this.tags, this.date, this.contentId});
}

class MyArtDetail {
  final String id;
  final String title;
  String imageUrl;
  final List<String> tags;
  final String date;
  final String content;

  MyArtDetail(
      {this.id, this.title, this.tags, this.date, this.content, this.imageUrl});
}