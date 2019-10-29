import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:login_api_test/model/LoginResponse.dart';
import 'target.dart';

class ApiProvider {
  static void request<T extends Codable<T>>(
    Target target,
    Function(T) success,
  ) async {

    Response response;

    switch (target.route.method) {
      case HTTPMethods.get:
        {
          response = await http.get(target.baseURL + target.route.path);
        }
        break;
      case HTTPMethods.post:
        {
          response = await http.post(target.baseURL + target.route.path, body: target.parameters);
        }
        break;
    }

    if (response.statusCode == 200) success((T as Codable).getFromJson(json.decode(response.body)));
  }
}
