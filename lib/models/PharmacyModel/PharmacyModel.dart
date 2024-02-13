class ModelGroupPharmacy {
  String? name;
  String? sId;
  String? imageUrl;

  ModelGroupPharmacy({this.name, this.sId, this.imageUrl});

  ModelGroupPharmacy.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sId = json['_id'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['_id'] = this.sId;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}