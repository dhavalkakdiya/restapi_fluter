import 'package:flutter/material.dart';
import 'package:proworktreedemo/screen/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText2: TextStyle(fontSize: 14.0, color: Colors.white),
        ),
      ),
      home: Register(),
    );
  }
}
