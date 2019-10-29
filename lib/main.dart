import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:login_api_test/model/LoginResponse.dart';
import 'package:login_api_test/service/api_provider.dart';
import 'package:login_api_test/service/target.dart';

void main() {
  runApp(MaterialApp(
    home: LoginApp(),
  ));
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: CredFields(),
      ),
    );
  }
}

class CredFields extends StatefulWidget {
  @override
  _TextFieldsState createState() => _TextFieldsState();
}

class _TextFieldsState extends State<CredFields> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  var isLoading = false;

//  var test: LoginResponse = {
//    return LoginResponse();
//  }

  @override
  void initState() {
    super.initState();
    FactoryRegistry().registerFactory(LoginResponse, new LoginResponseFactory());
    _loginRequest();
  }

  bool _certificateCheck(X509Certificate cert, String host, int port) =>
      host == 'app.profitapp.me';

  http.Client profitappClient() {
    var ioClient = HttpClient()..badCertificateCallback = _certificateCheck;

    return IOClient(ioClient);
  }

  _loginRequest() async {
    ApiProvider.request<LoginResponse>(
        Target.login('petar.jankovic3331@gmail.com', 'blabla64'),
        (loginResponse) {
      print(loginResponse.success);
    }, LoginResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Username'),
              controller: _usernameController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
              controller: _passwordController,
              textInputAction: TextInputAction.go,
              obscureText: true,
            ),
            RaisedButton(
              child: Text(
                'LOGIN',
              ),
              onPressed: () {
                setState(() {
                  if (_usernameController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty) {
                    isLoading = true;

                    _loginRequest();
                  }
                });
              },
            ),
          ],
        ),
      ),
      isLoading
          ? Stack(children: <Widget>[
              Container(
                color: Colors.white.withAlpha(200),
                constraints: BoxConstraints.expand(),
              ),
              Center(
                child: Container(
                  width: 44,
                  height: 44,
                  child: CircularProgressIndicator(),
                ),
              ),
            ])
          : SizedBox.shrink(),
    ]);
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

//    final chopper = ChopperClient(
//      baseUrl: "http://app.profitapp.me",
//      services: [
//        // the generated service
//        MyService.create()
//      ],
//      converter: JsonConverter(),
//    );

//    final myService = MyService.create(chopper);
//    final response = await myService.login('petar.jankovic3331@gmail.com', 'blabla64');
//    var loginJSON = LoginResponse.fromJson(json.decode(response.));
//    var url = 'https://app.profitapp.me/account/loginjson';
//    var response = await http.post(url, body: {'email': 'test', 'password': 'test'});
//    var loginJSON = LoginResponse.fromJson(json.decode(response.body));
//    try {
//      var response = await Dio().post(
//          'http://app.profitapp.me/account/loginjson',
//          data: {'email': 'petar.jankovic3331@gmail.com', 'password': 'blabla64'});
//      var loginJSON = LoginResponse.fromJson(json.decode(response.data));
//      print(loginJSON.success);
//    } catch (e) {
//      print(e);
//    }
//    loginJSON.someFunc();
//    print(loginJSON.error);
//    chopper.httpClient.close();
