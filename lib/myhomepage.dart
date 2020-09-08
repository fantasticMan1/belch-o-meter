import 'package:flutter/material.dart';
import 'belchlist.dart';
import 'useless.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BelchList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('record a belch'),
        tooltip: 'Show useless message',
        child: Icon(Icons.fiber_manual_record),
      ),
    );
  }
}
