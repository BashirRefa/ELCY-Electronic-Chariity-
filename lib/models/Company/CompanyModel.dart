  class Comapny {
  String? name;
  String? sId;
  String?ImgaeUrl;
  int?years;
  int? employees;
  int? rating;
  int? NumberPost;
  Comapny({this.name, this.sId});

  Comapny.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sId = json['id'];
    ImgaeUrl=json['imageUrl'];
    years=json['years'];
    employees=json['employees'];
    rating=json['rating'];
    NumberPost=json['NumberPost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['_id'] = this.sId;
    data['imageUrl']=this.ImgaeUrl;
    data['years']=this.years;
    data['rating']=this.rating;
    data['employees']=this.employees;
    data['NumberPost']=this.NumberPost;
    return data;
  }
}