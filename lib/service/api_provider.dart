import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:login_api_test/model/error_response.dart';
import 'deserializable.dart';
import 'endpoint.dart';

class ApiService {
  static void request<T extends Deserializable>(Endpoint target,
      Deserializable<T> type,
      Function(T) success,
      {Function(ErrorResponse) error,
      Function() failure}
      ) async {
    Response response;

    try {
      switch (target.route.method) {
        case HTTPMethods.get:
          response = await http.get(target.baseURL + target.route.path);
          break;
        case HTTPMethods.post:
          response = await http.post(target.baseURL + target.route.path, body: target.parameters);
          break;
      }
    } catch (e) {
      failure();
    }

    if (response.statusCode == 200) try {
      success(type.getFromJson(json.decode(response.body)));
    } catch (e) {
      failure();
    } else {
      error(ErrorResponse());
    }
  }
}