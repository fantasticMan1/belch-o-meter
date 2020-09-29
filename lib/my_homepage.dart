import 'package:flutter/material.dart';
import 'belch_list.dart';
import 'useless.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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
      floatingActionButton: Builder(
        builder: (BuildContext context) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                  onPressed: () =>
                      Useless(context).uselessFunction('record a belch'),
                  child: Icon(Icons.fiber_manual_record)),
              FloatingActionButton(
                onPressed: () =>
                    Useless(context).uselessFunction('choose a belch file'),
                child: Icon(Icons.folder_open),
              ),
            ],
          );
        },
      ),
    );
  }
}
