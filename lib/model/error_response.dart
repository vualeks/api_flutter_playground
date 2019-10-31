import '../service/deserializable.dart';

class ErrorResponse extends Deserializable<ErrorResponse> {
  int code;
  String error;

  ErrorResponse({this.code, this.error});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
    code: json["code"],
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "error": error,
  };

  @override
  ErrorResponse getFromJson(Map<String, dynamic> map) {
    return ErrorResponse.fromJson(map);
  }
}