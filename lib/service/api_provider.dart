import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:login_api_test/model/LoginResponse.dart';
import 'endpoint.dart';

class ApiProvider {
  static void request<T extends JsonDeserializable>(Endpoint target, Function(T) success, JsonDeserializable<T> type) async {
    Response response;

    switch (target.route.method) {
      case HTTPMethods.get:
        response = await http.get(target.baseURL + target.route.path);
        break;
      case HTTPMethods.post:
        response = await http.post(target.baseURL + target.route.path, body: target.parameters);
        break;
    }

    if (response.statusCode == 200)
//      success(factory(type).create(json.decode(response.body)));
      success(type.getFromJson(json.decode(response.body)));
  }
}


abstract class ResponseFactory<T> {
  T create(Map<String, dynamic> s);
}

class LoginResponseFactory extends ResponseFactory<LoginResponse> {
  @override
  LoginResponse create(Map<String, dynamic> s) {
    return LoginResponse.fromJson(s);
  }

}

class FactoryRegistry {
  final Map<Type, ResponseFactory> _registry = new Map();

  ResponseFactory getFactory(Type type) {
    return _registry[type];
  }

  void registerFactory(Type type, ResponseFactory f) {
    _registry[type] = f;
  }

  static final FactoryRegistry _instance = FactoryRegistry._internal();

  factory FactoryRegistry() {
    return _instance;
  }

  FactoryRegistry._internal();
}

ResponseFactory factory(Type type) {
  return FactoryRegistry().getFactory(type);
}

