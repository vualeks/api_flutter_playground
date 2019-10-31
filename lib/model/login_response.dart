import 'package:login_api_test/service/deserializable.dart';

class LoginResponse extends Deserializable<LoginResponse> {
  final String success;
  final bool confirmed;

  LoginResponse({
    this.success,
    this.confirmed,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    success: json["success"],
    confirmed: json["confirmed"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "confirmed": confirmed,
  };

  @override
  LoginResponse getFromJson(Map<String, dynamic> map) {
    return LoginResponse.fromJson(map);
  }
}
