import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:proworktreedemo/screen/homescreen.dart';
import 'package:proworktreedemo/screen/loginscreen.dart';
import 'package:proworktreedemo/shared.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isLoading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text(
          'Sign up',
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => LoginPage()));
            },
          ),
        ],
      ),
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.teal],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  HeaderSection(),
                  TextSection(passwordController: passwordController,emailController: emailController,),
                  buttonSection(),
                ],
              ),
      ),
    );
  }



  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed: emailController.text == ""
            ? null
            : () {
                setState(() {
                  _isLoading = true;
                });
                register(emailController.text, passwordController.text);
              },
        elevation: 0.0,
        color: Colors.purple,
        child: Text("Register", style: TextStyle(color: Colors.white70)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  register(String email, String password) async {
    Map data = {'email': email, 'password': password};
    String error = "";
    var jsonResponse;
    final http.Response response =
        await http.post('https://reqres.in/api/register', body: data);

    if (response.statusCode == 200) {
      print(response.body);
      return Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => HomePage()),
          (Route<dynamic> route) => false);
    } else {
      jsonResponse = json.decode(response.body);
      error = jsonResponse['error'];
      // error = jsonResponse['error']['Note'];
      final snackBar = SnackBar(content: Text(error));
      _scaffoldKey.currentState.showSnackBar(snackBar);

      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }
}




