import 'package:flutter/material.dart';

class Useless {
  BuildContext context;

  Useless(BuildContext context) {
    this.context = context;
  }

  void uselessFunction(String msg) {
    final snackBar = SnackBar(content: Text('Coming soon: ' + msg));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
