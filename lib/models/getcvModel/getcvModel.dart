class getcvModel {
  String? sId;
  String? engineering;
  String? skills;

  getcvModel({this.sId, this.engineering, this.skills});

  getcvModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    engineering = json['Engineering'];
    skills = json['Skills'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['Engineering'] = this.engineering;
    data['Skills'] = this.skills;
    return data;
  }
}