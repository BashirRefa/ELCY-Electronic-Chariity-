class Services {
  String? sId;
  String? name;
  String?imageUrl;

  Services({this.sId, this.name});

  Services.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    imageUrl=json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['imageUrl']=this.imageUrl;
    return data;
  }
}