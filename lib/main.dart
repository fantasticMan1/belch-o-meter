import 'package:flutter/material.dart';
import 'myhomepage.dart';
import 'theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: getAppTheme(),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
