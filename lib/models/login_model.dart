import 'package:json_annotation/json_annotation.dart';
part 'login_model.g.dart';
@JsonSerializable()
class LoginRequest{
  final String email;
  final String password;
    late String? token;


  LoginRequest({
   required this.email,
    required this.password,
});
 factory LoginRequest.fromJson(Map<String,dynamic> json)=>_$LoginRequestFromJson(json);
 Map<String,dynamic> toJson()=>_$LoginRequestToJson(this);
}
