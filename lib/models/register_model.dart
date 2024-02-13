import 'package:json_annotation/json_annotation.dart';
part 'register_model.g.dart';
@JsonSerializable()
class RegisterModel{
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final String birthday;
  final String phoneNumber;
  final String gender;
  final String address;
  RegisterModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.birthday,
    required this.gender,
    required this.address,
  });
  factory RegisterModel.fromJson(Map<String,dynamic> json)=>_$RegisterModelFromJson(json);
  Map<String,dynamic> toJson()=>_$RegisterModelToJson(this);
}

//  class RegisterModel {
//   String? firstName;
//   String? lastName;
//   String? gender;
//   String? phoneNumber;
//   String? password;
//   String? email;
//   String? birthday;
//   String? sId;
//   int? iV;
//
//   RegisterModel(
//       {this.firstName,
//         this.lastName,
//         this.gender,
//         this.phoneNumber,
//         this.password,
//         this.email,
//         this.birthday,
//         this.sId,
//         this.iV});
//
//   RegisterModel.fromJson(Map<String, dynamic> json) {
//     firstName = json['firstName'];
//     lastName = json['lastName'];
//     gender = json['gender'];
//     phoneNumber = json['phoneNumber'];
//     password = json['password'];
//     email = json['email'];
//     birthday = json['birthday'];
//     sId = json['_id'];
//     iV = json['__v'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['firstName'] = this.firstName;
//     data['lastName'] = this.lastName;
//     data['gender'] = this.gender;
//     data['phoneNumber'] = this.phoneNumber;
//     data['password'] = this.password;
//     data['email'] = this.email;
//     data['birthday'] = this.birthday;
//     data['_id'] = this.sId;
//     data['__v'] = this.iV;
//     return data;
//   }
// }