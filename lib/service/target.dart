import 'dart:core';

enum Endpoints {
  login, user_data
}

class Target {

  Endpoints endpoint;

  String baseURL = "http://app.profitapp.me";

  Route route;

  Map<String, String> parameters = Map();

  Target.login(String email, String password) {
    endpoint = Endpoints.login;
    route = Route.post('/account/loginjson');
    parameters['email'] = email;
    parameters['password'] = password;
  }

  Target.userData() {
    endpoint = Endpoints.user_data;
    route = Route.post('/korisnik/korisnikservice');
  }
}

// --------------------------------------

class Route {
  String path;
  HTTPMethods method;

  Route.get(String path): this.path = path, this.method = HTTPMethods.get;
  Route.post(String path): this.path = path, this.method = HTTPMethods.post;
}

enum HTTPMethods {
  get, post
}

