import 'package:flutter/material.dart';
import 'belch_list.dart';
import 'useless.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final double BUTTON_HEIGHT = 60;

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
              Container(
                height: BUTTON_HEIGHT,
                width: BUTTON_HEIGHT,
                child: FlatButton(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(BUTTON_HEIGHT / 2),
                      topLeft: Radius.circular(BUTTON_HEIGHT / 2),
                    ),
                  ),
                  onPressed: () =>
                      Useless(context).uselessFunction('record a belch'),
                  child: Icon(Icons.fiber_manual_record),
                ),
              ),
              Container(
                height: BUTTON_HEIGHT,
                width: BUTTON_HEIGHT,
                child: FlatButton(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(BUTTON_HEIGHT / 2),
                      topRight: Radius.circular(BUTTON_HEIGHT / 2),
                    ),
                  ),
                  onPressed: () =>
                      Useless(context).uselessFunction('choose a belch file'),
                  child: Icon(Icons.folder_open),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
