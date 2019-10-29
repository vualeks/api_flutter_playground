class LoginResponse extends Codable<LoginResponse> {
  final String success;
  final bool confirmed;
  final String error;

  LoginResponse({
    this.success,
    this.confirmed,
    this.error,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    success: json["success"],
    confirmed: json["confirmed"],
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "confirmed": confirmed,
    "error": error,
  };

  @override
  LoginResponse getFromJson(Map<String, String> map) {
    return LoginResponse.fromJson(map);
  }
}

//mixin LoginResponseExtension {
//  void someFunc(){
//    print("some text");
//  }
//}

abstract class Codable<T> {
  T getFromJson(Map<String, String> map);
}
