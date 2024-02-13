import 'Specialties.dart';

class SpecialtiesModel {
  String? sId;
  List<Specialties>? specialties;

  SpecialtiesModel({this.sId, this.specialties});

  SpecialtiesModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['specialties'] != null) {
      specialties = <Specialties>[];
      json['specialties'].forEach((v) {
        specialties!.add(new Specialties.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.specialties != null) {
      data['specialties'] = this.specialties!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}