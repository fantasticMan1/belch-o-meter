import 'package:flutter/material.dart';
import 'my_homepage.dart';
import 'theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Belch o Meter',
      theme: getAppTheme(),
      home: MyHomePage(title: 'Belch-o-Meter Home'),
    );
  }
}
