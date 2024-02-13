
class Post {
  String? sId;
  String? content;
  String? title;
  // int likes=0;
  //int dislikes=0;

  Post({this.sId, this.content, this.title});
  //Post({this.sId, this.content, this.title,required this.likes,required this.dislikes});

  Post.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    content = json['content'];
    title = json['title'];
     //likes=json['islike'];
    //  dislikes=json['isdilike'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['content'] = this.content;
    data['title'] = this.title;
    return data;
  }
}