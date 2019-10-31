import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_api_test/model/login_response.dart';
import 'package:login_api_test/service/api_provider.dart';
import 'package:login_api_test/service/endpoint.dart';

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

  @override
  void initState() {
    super.initState();
  }

  _loginRequest(BuildContext context) async {
    ApiService.request<LoginResponse>(
        Endpoint.login(_usernameController.text, _passwordController.text),
        LoginResponse(), (loginResponse) {
      print(loginResponse.success);
      setState(() {
        isLoading = false;
      });
    }, error: (errorResponse) {
      _showToast(context, "Greska!");
    }, failure: () {
      _showToast(context, "Nema interneta");
      setState(() {
        isLoading = false;
      });
    });
    setState(() {
      isLoading = true;
    });
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

                    _loginRequest(context);
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
