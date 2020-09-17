import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = "https://reqres.in/api/users?page=2";
  List data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  getJsonData() async {
    var response = await http.get(url);

    print(response.body);

    setState(() {
      var convertDataTojson = json.decode(response.body);
      data = convertDataTojson['data'];
    });

    //return "Success";
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'User List',
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.teal],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(data[index]['avatar']),
                      ),
                      title: Text(
                        data[index]['first_name'],
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        data[index]['email'],
                        style: TextStyle(color: Colors.white),
                      ),
                      
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
